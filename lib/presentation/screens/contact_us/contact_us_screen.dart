import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/data/data_provider/remote_url.dart';
import '/data/model/contact_us/contact_us_model.dart';
import '/logic/cubit/contact_us/contact_us_cubit.dart';
import '/presentation/utils/utils.dart';
import '/presentation/widget/custom_app_bar.dart';
import '/presentation/widget/custom_images.dart';
import '../../../logic/cubit/contact_us/contact_us_state_model.dart';
import '../../utils/constraints.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/loading_widget.dart';
import 'component/contact_us_form_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactUsCubit = context.read<ContactUsCubit>();
    contactUsCubit.getContactUs();
    return Scaffold(
      appBar:
          CustomAppBar(title: contactUsCubit.contactUs!.seoSetting!.pageName),
      body: ListView(
        shrinkWrap: true,
        children: [
          const ContactUsFormWidget(),
          Utils.verticalSpace(30.0),
          BlocBuilder<ContactUsCubit, ContactUsStateModel>(
            builder: (context, state) {
              final contact = state.contactUsState;
              if (contact is ContactUsLoading) {
                return const LoadingWidget();
              } else if (contact is ContactUsError) {
                if (contact.statusCode == 503) {
                  return ContactUsLoadedWidget(
                      contactUs: contactUsCubit.contactUs!);
                } else {
                  return Center(
                    child: CustomTextStyle(
                      text: contact.message,
                      color: redColor,
                      fontSize: 20.0,
                    ),
                  );
                }
              } else if (contact is ContactUsLoaded) {
                return ContactUsLoadedWidget(contactUs: contact.contactUs);
              }
              return ContactUsLoadedWidget(
                  contactUs: contactUsCubit.contactUs!);
              // return const Center(
              //     child: CustomTextStyle(text: 'Something went wrong'));
            },
          )
        ],
      ),
    );
  }
}

class ContactUsLoadedWidget extends StatefulWidget {
  const ContactUsLoadedWidget({Key? key, required this.contactUs})
      : super(key: key);
  final ContactUsModel contactUs;

  @override
  State<ContactUsLoadedWidget> createState() => _ContactUsLoadedWidgetState();
}

class _ContactUsLoadedWidgetState extends State<ContactUsLoadedWidget> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    initController();
  }

  initController() {
    controller = WebViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImage(
          path: RemoteUrls.imageUrl(widget.contactUs.contact!.supporterImage),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomTextStyle(
              //     text: widget.contactUs.contact!.supportTime, fontSize: 20.0),
              // CustomTextStyle(text: widget.contactUs.contact!.email),
              // CustomTextStyle(text: widget.contactUs.contact!.phone),
              // CustomTextStyle(text: widget.contactUs.contact!.address),
              const SizedBox(height: 20.0),
              contactInfo(widget.contactUs.contact!.email, Icons.email),
              contactInfo(widget.contactUs.contact!.phone, Icons.phone),
              contactInfo(
                  widget.contactUs.contact!.address, Icons.location_pin),
            ],
          ),
        ),
        Container(
          height: 200.0,
          width: 550.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          alignment: Alignment.center,
          child: WebViewWidget(
            controller: controller
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..enableZoom(true)
              //..setBackgroundColor(whiteColor)
              ..loadHtmlString(widget.contactUs.contact!.map),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }

  Widget contactInfo(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20.0),
          const SizedBox(width: 10.0),
          CustomTextStyle(text: text),
        ],
      ),
    );
  }
}
