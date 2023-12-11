import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/data/data_provider/remote_url.dart';
import 'package:real_estate/presentation/utils/utils.dart';

import '../../../../data/model/product/single_property_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';

class PropertyImagesSlider extends StatefulWidget {
  final SinglePropertyModel property;
  const PropertyImagesSlider({Key? key, required this.property})
      : super(key: key);

  @override
  State<PropertyImagesSlider> createState() => _PropertyImagesSliderState();
}

class _PropertyImagesSliderState extends State<PropertyImagesSlider> {
  final int initialPage = 0;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final images = widget.property.sliders;
    final item = widget.property.propertyItemModel;
    return SizedBox(
      height: size.height * 0.38,
      width: size.width,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            child: CustomImage(
              path: KImages.profileBackground,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: size.height * 0.03,
            left: size.width * 0.04,
            child: Row(
              children: [
                //const SizedBox(width: 10.0),
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
                const CustomTextStyle(
                  text: 'Property Details',
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  color: whiteColor,
                )
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.1,
            left: 0.0,
            right: 0.0,
            child: CarouselSlider(
              items: images!
                  .map((e) => CustomImage(
                      path: RemoteUrls.imageUrl(e.image), fit: BoxFit.cover))
                  .toList(),
              options: CarouselOptions(
                height: 240.0,
                viewportFraction: 1,
                initialPage: initialPage,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Positioned(
            right: size.width * 0.1,
            top: size.height * 0.12,
            child: Row(
              children: List.generate(
                images.length,
                (index) {
                  final isActive = _currentIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: isActive ? 13.0 : 12.0,
                    width: isActive ? 13.0 : 12.0,
                    margin: const EdgeInsets.only(right: 5.5),
                    decoration: BoxDecoration(
                      color: isActive ? primaryColor : transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive ? transparent : blackColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: -(size.height * 0.06),
            right: size.width * 0.1,
            child: Container(
              height: item!.rentPeriod.isNotEmpty ? 70.0 : 50.0,
              width: 85.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: yellowColor,
                borderRadius: borderRadius,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextStyle(
                    text: Utils.formatPrice(context, item.price),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: blackColor,
                  ),
                  item.rentPeriod.isNotEmpty
                      ? CustomTextStyle(
                          text: '/${item.rentPeriod}',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: blackColor,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }
}

final List<String> images = [
  KImages.detailsImage,
  KImages.detailsImage,
  KImages.detailsImage,
  KImages.detailsImage,
];
