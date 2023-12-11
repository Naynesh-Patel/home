import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import 'custom_test_style.dart';

class CustomRoundedAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomRoundedAppBar({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const CircleAvatar(
                backgroundColor: whiteColor,
                minRadius: 16.0,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: grayColor,
                    size: 22.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            CustomTextStyle(
              text: text,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: whiteColor,
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
