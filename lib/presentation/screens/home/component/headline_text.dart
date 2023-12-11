import 'package:flutter/cupertino.dart';

import '../../../widget/custom_test_style.dart';

class HeadlineText extends StatelessWidget {
  const HeadlineText(
      {Key? key,
      required this.text,
      required this.onTap,
      this.isPadding = true})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  final bool isPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
              horizontal: isPadding ? 15.0 : 0.0, vertical: 12.0)
          .copyWith(top: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextStyle(
            text: text,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          GestureDetector(
            onTap: onTap,
            child: const CustomTextStyle(
              text: 'See All',
              fontSize: 16.0,
              color: Color(0xFF7E8BA0),
            ),
          ),
        ],
      ),
    );
  }
}
