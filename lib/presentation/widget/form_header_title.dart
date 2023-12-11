import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormHeaderTitle extends StatelessWidget {
  const FormHeaderTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: const Color(0xff32395c),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          border: Border.all(
            color: Colors.black,
          )),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}