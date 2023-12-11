import 'package:flutter/material.dart';

import '../../../utils/constraints.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';

class SingleElement extends StatelessWidget {
  const SingleElement(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onTap,
      this.showBorder = true})
      : super(key: key);
  final String icon;
  final String text;
  final VoidCallback onTap;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                CustomImage(
                  path: icon,
                  width: 20.0,
                  height: 20.0,
                  // fit: BoxFit.cover,
                ),
                const SizedBox(width: 15.0),
                CustomTextStyle(
                  text: text,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  color: blackColor,
                ),
              ],
            ),
          ),
        ),
        showBorder
            ? Container(
                width: double.infinity,
                height: 1.0,
                color: borderColor,
              )
            : const SizedBox(),
      ],
    );
  }
}
