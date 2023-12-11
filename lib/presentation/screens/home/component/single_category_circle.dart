import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate/data/data_provider/remote_url.dart';
import 'package:real_estate/data/model/category/property_category_model.dart';

import '../../../../data/model/product/property_type_model.dart';
import '../../../core/dummy_text.dart';

import '../../../widget/custom_test_style.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_images.dart';

class SingleCategoryCircle extends StatelessWidget {
  const SingleCategoryCircle({Key? key, required this.category})
      : super(key: key);
  final PropertyTypeModel category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 72.0.h,
            width: 72.0.h,
            margin: const EdgeInsets.only(bottom: 6.0),
            decoration: BoxDecoration(
              border:
                  Border.all(color: primaryColor.withOpacity(0.5), width: 1),
              shape: BoxShape.circle,
            ),
            child: Container(
              height: 70.0.h,
              width: 70.0.h,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
              ),
              child: CustomImage(
                path: RemoteUrls.imageUrl(category.icon),
                height: 40,
              ),
            ),
          ),
          CustomTextStyle(
            text: category.name,
            fontSize: 11.0,
            color: const Color(0xFF7E8BA0),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}
