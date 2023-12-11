import 'package:flutter/material.dart';

import '../../../../data/model/product/single_property_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';

class PropertyHorizontalView extends StatelessWidget {
  const PropertyHorizontalView({Key? key, required this.property})
      : super(key: key);
  final SinglePropertyModel property;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final item = property.propertyItemModel!;
    String calculation(dynamic val) => val.toString();
    final List<Map<String, String>> properties = [
      {
        "icon": KImages.propertiesIcon01,
        "title": "Area",
        "size": calculation(item.totalArea)
      },
      {
        "icon": KImages.propertiesIcon02,
        "title": "Unit",
        "size": calculation(item.totalUnit),
      },
      {
        "icon": KImages.propertiesIcon03,
        "title": "Bedrooms",
        "size": calculation(item.totalBedroom)
      },
      {
        "icon": KImages.propertiesIcon02,
        "title": "Bathroom",
        "size": calculation(item.totalBathroom)
      },
      {
        "icon": KImages.propertiesIcon03,
        "title": "Garage",
        "size": calculation(item.totalGarage),
      },
      {
        "icon": KImages.propertiesIcon01,
        "title": "Kitchen",
        "size": calculation(item.totalKitchen),
      },
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(
          properties.length,
          (index) => Padding(
            padding: EdgeInsets.only(
                left: index == 0 ? 15.0 : 0.0,
                right: index == properties.length - 1 ? 10.0 : 0.0),
            child: Container(
              height: size.height * 0.18,
              width: size.width * 0.34,
              // color: Colors.red,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(
                  color: const Color.fromRGBO(20, 0, 255, 0.06),
                ),
                borderRadius: borderRadius,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 54.0,
                    width: 54.0,
                    margin: const EdgeInsets.only(bottom: 6.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor.withOpacity(0.1),
                    ),
                    child: CustomImage(
                      path: properties[index]['icon']!,
                      height: 30.0,
                      width: 30.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  CustomTextStyle(
                    text: properties[index]['title']!,
                    color: blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                  const SizedBox(height: 4.0),
                  CustomTextStyle(
                    text: properties[index]['size']!,
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 22.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
