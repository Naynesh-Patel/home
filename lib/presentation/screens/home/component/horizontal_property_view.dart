import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate/data/data_provider/remote_url.dart';
import 'package:real_estate/presentation/utils/utils.dart';

import '../../../../data/model/home/home_property_model.dart';
import '../../../router/route_names.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/favorite_button.dart';
import 'headline_text.dart';

class HorizontalPropertyView extends StatelessWidget {
  const HorizontalPropertyView(
      {Key? key,
      required this.featuredProperty,
      required this.onTap,
      this.headingText = 'Location by Property'})
      : super(key: key);
  final String headingText;
  final HomePropertyModel featuredProperty;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeadlineText(
          text: headingText,
          onTap: onTap,
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              featuredProperty.properties.length >= 3
                  ? 3
                  : featuredProperty.properties.length,
              (index) {
                final element = featuredProperty.properties[index];
                return Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? 15.0 : 0.0,
                      right: index == 9 ? 0.0 : 0.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteNames.propertyDetailsScreen,
                        arguments: element.slug),
                    child: Container(
                      // height: 260.0.h,
                      width: 220.0.w,
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: borderRadius,
                            child: Stack(
                              // fit: StackFit.expand,
                              children: [
                                CustomImage(
                                  path: RemoteUrls.imageUrl(
                                      element.thumbnailImage),
                                  height: 150.0,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 10.0,
                                  right: 10.0,
                                  child:
                                      FavoriteButton(id: element.id.toString()),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextStyle(
                                text: Utils.formatPrice(context, element.price),
                                color: primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                              ),
                              CustomTextStyle(
                                text: element.rentPeriod.isNotEmpty
                                    ? '/${element.rentPeriod}'
                                    : element.rentPeriod,
                                color: grayColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                            ],
                          ),
                          CustomTextStyle(
                            text: element.title,
                            color: blackColor,
                            fontWeight: FontWeight.w600,
                            maxLine: 2,
                            fontSize: 18.0,
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const CustomImage(path: KImages.locationIcon),
                              Utils.horizontalSpace(6),
                              Expanded(
                                child: CustomTextStyle(
                                  text: element.address,
                                  color: grayColor,
                                  fontWeight: FontWeight.w400,
                                  maxLine: 1,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
