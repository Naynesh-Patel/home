import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/presentation/utils/constraints.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../router/route_names.dart';
import '../../utils/utils.dart';

class MolliPaymentScreen extends StatefulWidget {
  const MolliPaymentScreen({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<MolliPaymentScreen> createState() => _FlutterWaveState();
}

class _FlutterWaveState extends State<MolliPaymentScreen> {
  double value = 0.0;

  bool _canRedirect = true;

  bool _isLoading = true;

  late WebViewController controllerGlobal;

  @override
  void initState() {
    initialController();
    super.initState();
  }

  initialController() {
    controllerGlobal = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(whiteColor)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          setState(() {
            value = progress / 100;
          });
          log("WebView is loading (progress : $progress%)");
        },
        onPageStarted: (String url) {
          log('Page started loading: $url');
          setState(() {
            _isLoading = true;
          });
          log("printing urls $url");
          _redirect(url);
        },
        onPageFinished: (String url) {
          log('Page finished loading: $url');
          setState(() {
            _isLoading = false;
          });
          _redirect(url);
        },
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Text("Payment"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => _exitApp(context),
          ),
          backgroundColor: whiteColor,
        ),
        body: Column(
          children: [
            if (_isLoading)
              Center(
                child: LinearProgressIndicator(
                  value: value,
                ),
              ),
            Expanded(
              child: WebViewWidget(controller: controllerGlobal),
            ),
          ],
        ),
      ),
    );
  }

  void _redirect(String url) {
    if (_canRedirect) {
      bool _isSuccess = url.contains('/webview-success-payment') &&
          url.contains(RemoteUrls.rootUrl);
      bool _isFailed = url.contains('fail') && url.contains(RemoteUrls.rootUrl);
      bool _isCancel = url.contains('/order-fail-url-for-mobile-app') &&
          url.contains(RemoteUrls.rootUrl);
      if (_isSuccess || _isFailed || _isCancel) {
        _canRedirect = false;
      }
      if (_isSuccess) {
        getData();
      } else if (_isFailed || _isCancel) {
        Utils.errorSnackBar(context, 'Payment cancelled');
        Navigator.pop(context);
        return;
      } else {
        log("Encountered problem");
      }
    }
  }

  void getData() {
    controllerGlobal
        .runJavaScriptReturningResult("document.body.innerText")
        //.runJavascriptReturningResult("document.body.innerText")
        .then(
      (data) {
        var decodedJSON = jsonDecode(data.toString());
        var responseJSON = jsonDecode(decodedJSON);
        log(decodedJSON, name: 'MolliPaymentScreen');
        if (responseJSON["result"] == false) {
          Utils.errorSnackBar(context, responseJSON["message"]);
        } else if (responseJSON["result"] == true) {
          Utils.showSnackBar(context, responseJSON["message"]);
        }
        Navigator.pushNamedAndRemoveUntil(context, RouteNames.purchaseScreen,
            (route) {
          if (route.settings.name == RouteNames.mainPageScreen) {
            return true;
          }
          return false;
        });
      },
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      return true;
    }
  }
}
