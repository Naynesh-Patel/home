import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import 'custom_test_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      required this.title,
      this.showButton = true,
      this.bgColor = scaffoldBackground})
      : super(key: key);
  final String title;
  final bool showButton;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actionsIconTheme:
          const IconThemeData(color: primaryColor, size: 30.0, fill: 0.6),
      // actions: [const SizedBox()],
      title: Row(
        children: [
          showButton
              ? GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const CircleAvatar(
                    backgroundColor: primaryColor,
                    minRadius: 18.0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: whiteColor,
                        size: 22.0,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          SizedBox(width: showButton ? 14.0 : 10.0),
          CustomTextStyle(
            text: title,
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
