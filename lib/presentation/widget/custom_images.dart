import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    Key? key,
    required this.path,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.color,
    this.isFile = false,
  }) : super(key: key);
  final String path;
  final BoxFit fit;
  final double? height, width;
  final Color? color;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    if (isFile) {
      return Image.file(
        File(path),
        fit: fit,
        color: color,
        height: height,
        width: width,
      );
    }

    if (path.endsWith('.svg') &&
        !(path.startsWith('http') || path.startsWith('https'))) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset(
          path,
          fit: fit,
          height: height,
          width: width,
          color: color,
        ),
      );
    }
    if (path.startsWith('http') ||
        path.startsWith('https') ||
        path.startsWith('www.') ||
        path.endsWith('.svg')) {
      return CachedNetworkImage(
        imageUrl: path,
        fit: fit,
        color: color,
        height: height,
        width: width,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Center(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          );
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
    return Image.asset(
      path,
      fit: fit,
      color: color,
      height: height,
      width: width,
    );
  }
}

// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../utils/k_images.dart';
//
// class CustomImage extends StatelessWidget {
//   const CustomImage({
//     Key? key,
//     required this.source,
//     this.fit = BoxFit.contain,
//     this.height,
//     this.width,
//     this.color,
//     this.isFile = false,
//   }) : super(key: key);
//   final String? source;
//   final BoxFit fit;
//   final double? height, width;
//   final Color? color;
//   final bool isFile;
//
//   @override
//   Widget build(BuildContext context) {
//     final imageSource = source ?? KImages.kNetworkImage;
//
//     if (isFile) {
//       return Image.file(
//         File(imageSource),
//         fit: fit,
//         color: color,
//         height: height,
//         width: width,
//       );
//     }
//
//     if (imageSource.endsWith('.svg')) {
//       return SizedBox(
//         height: height,
//         width: width,
//         child: SvgPicture.asset(
//           imageSource,
//           fit: fit,
//           height: height,
//           width: width,
//           color: color,
//         ),
//       );
//     }
//     if (imageSource.startsWith('http') ||
//         imageSource.startsWith('https') ||
//         imageSource.startsWith('www.')) {
//       return CachedNetworkImage(
//         imageUrl: imageSource,
//         fit: fit,
//         color: color,
//         height: height,
//         width: width,
//         progressIndicatorBuilder: (context, url, downloadProgress) => Center(
//             child: CircularProgressIndicator(value: downloadProgress.progress)),
//         errorWidget: (context, url, error) => const Icon(Icons.error),
//       );
//     }
//     return Image.asset(
//       imageSource,
//       fit: fit,
//       color: color,
//       height: height,
//       width: width,
//     );
//   }
// }
