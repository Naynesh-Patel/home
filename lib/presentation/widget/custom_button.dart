// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
// class PrimaryButton extends StatelessWidget {
//   const PrimaryButton({
//     Key? key,
//     this.maximumSize = const Size(double.infinity, 52),
//     required this.text,
//     this.bgColor = blue,
//     this.textColor = white,
//     this.fontSize = 13,
//     required this.onPressed,
//     this.minimumSize = const Size(double.infinity, 52),
//     this.borderRadiusSize = 0,
//     this.fontWeight = FontWeight.w400,
//   }) : super(key: key);
//
//   final VoidCallback onPressed;
//
//   final String text;
//   final Size maximumSize;
//   final Size minimumSize;
//   final double fontSize;
//   final Color bgColor;
//   final Color textColor;
//   final double borderRadiusSize;
//   final FontWeight fontWeight;
//
//   @override
//   Widget build(BuildContext context) {
//     final borderRadius = BorderRadius.circular(borderRadiusSize.r);
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(borderRadius: borderRadius),
//         minimumSize: minimumSize,
//         maximumSize: maximumSize,
//         backgroundColor: bgColor,
//         shadowColor: Colors.transparent,
//       ),
//       child: Text(
//         text,
//         style: GoogleFonts.roboto(
//           color: textColor,
//           fontSize: fontSize,
//           fontWeight: fontWeight,
//         ),
//       ),
//     );
//   }
// }
