import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import 'custom_images.dart';
import 'custom_test_style.dart';

class ContactButton extends StatelessWidget {
  const ContactButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconTextColor,
      required this.bgColor,
      required this.onPressed})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final String icon;
  final Color iconTextColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(164.0, 50.0)),
        backgroundColor: MaterialStateProperty.all(bgColor),
        elevation: MaterialStateProperty.all(0.0),
        shadowColor: MaterialStateProperty.all(transparent),
        splashFactory: NoSplash.splashFactory,
      ),
      icon: CustomImage(
        path: icon,
        color: iconTextColor,
      ),
      label: CustomTextStyle(
        text: text,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
        color: iconTextColor,
      ),
    );
  }
}
