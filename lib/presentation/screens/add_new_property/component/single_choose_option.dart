import 'package:flutter/material.dart';

import '../../../utils/constraints.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';

class SingleChooseOption extends StatelessWidget {
  const SingleChooseOption({
    Key? key,
    required this.onTap,
    required this.text,
    required this.subText,
    required this.icon,
    required this.iconBgColor,
  }) : super(key: key);
  final VoidCallback onTap;
  final String icon;
  final String text;
  final String subText;
  final Color iconBgColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.14,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: borderRadius,
        ),
        child: Row(
          children: [
            Container(
              height: size.height * 0.2,
              width: size.width * 0.2,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 20.0, top: 6.0),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: CustomImage(
                path: icon,
                height: size.height * 0.12,
                width: size.width * 0.12,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextStyle(
                  text: text,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: blackColor,
                ),
                const SizedBox(height: 6.0),
                SizedBox(
                  width: 200.0,
                  //height: 30.0,
                  //color: redColor,
                  child: CustomTextStyle(
                    text: subText,
                    fontSize: 12.0,
                    color: grayColor,
                    maxLine: 4,
                    height: 1.4,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
