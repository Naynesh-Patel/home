import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../logic/cubit/home/cubit/property_details_cubit.dart';
import '../../../../utils/constraints.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({Key? key}) : super(key: key);

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
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
    return BlocBuilder<PropertyDetailsCubit, PropertyDetailsState>(
      builder: (context, state) {
        if (state is PropertyDetailsLoaded) {
          final item = state.singlePropertyModel.propertyItemModel;
          return Column(
            children: [
              ReadMoreText(
                item!.addressDescription,
                trimLines: 4,
                trimCollapsedText: 'Read More',
                trimExpandedText: 'Show Less',
                trimLength: 180,
                moreStyle: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: primaryColor),
                lessStyle: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: primaryColor),
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: grayColor),
              ),
              const SizedBox(height: 12.0),
              Container(
                height: 200.0,
                width: 600.0,
                alignment: Alignment.center,
                child: WebViewWidget(
                  controller: controller
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..enableZoom(true)
                    ..loadHtmlString(item.googleMap),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
