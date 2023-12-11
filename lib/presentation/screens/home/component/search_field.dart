import 'package:flutter/material.dart';

import '/presentation/router/route_names.dart';
import '/presentation/widget/custom_test_style.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_images.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 14.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, RouteNames.searchScreen),
            child: Container(
              height: 52.0,
              width: 270.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: borderWithOpacityColor,
                  border: Border.all(color: whiteColor)),
              child: const Row(
                children: [
                  CustomImage(
                    path: KImages.searchIcon,
                    color: primaryColor,
                  ),
                  SizedBox(width: 20.0),
                  CustomTextStyle(text: 'Find your house..')
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, RouteNames.filterPropertyScreen,
                arguments: ''),
            child: Container(
              height: 50.0,
              width: 50.0,
              margin: const EdgeInsets.only(left: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: const CustomImage(
                path: KImages.filterIcon,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Flexible buildFlexible() {
    return Flexible(
      child: TextFormField(
        onTap: () => print('hhhhh'),
        enabled: false,
        decoration: const InputDecoration(
            prefixIcon: SizedBox(
              height: 55.0,
              width: 40.0,
              child: Center(
                child: CustomImage(
                  path: KImages.searchIcon,
                  color: primaryColor,
                ),
              ),
            ),
            hintText: 'Find your house..'),
      ),
    );
  }
}
