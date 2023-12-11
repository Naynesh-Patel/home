import 'package:flutter/material.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/home/counter_model.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/utils/k_images.dart';
import '../../../../presentation/widget/custom_images.dart';
import '../../../../presentation/widget/custom_test_style.dart';

class FunFactSection extends StatelessWidget {
  const FunFactSection({Key? key, required this.counter}) : super(key: key);
  final CounterModel counter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final List<Map<String, String>> funList = [
    //   {"icon": KImages.funIcon01, "title": '150K', "sub_title": 'Built-House'},
    //   {"icon": KImages.funIcon02, "title": '120+', "sub_title": 'Co-Agent'},
    //   {"icon": KImages.funIcon03, "title": '150+', "sub_title": 'Branches'},
    // ];

    String bgImage = counter.content.bgImage.isNotEmpty
        ? RemoteUrls.imageUrl(counter.content.bgImage)
        : KImages.funFactImageImage;
    print(RemoteUrls.imageUrl(counter.items[0].icon));
    return SizedBox(
      height: size.height * 0.3,
      width: size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomImage(
            path: bgImage,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 30.0,
            left: 20.0,
            child: CustomTextStyle(
              text: counter.content.title,
              color: whiteColor,
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
            ),
          ),
          Positioned.fill(
            top: size.height * 0.1,
            left: size.width / 20.0,
            child: Row(
              children: List.generate(
                counter.items.length >= 3 ? 3 : counter.items.length,
                (index) {
                  final items = counter.items[index];
                  return Flexible(
                    child: buildContainer(
                      size,
                      RemoteUrls.imageUrl(items.icon),
                      items.number.toString(),
                      items.title,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer(Size size, String icon, String title, String subTitle) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          // width: 220.0,
          // height: 100.0,
          width: size.height * 0.16,
          height: size.height * 0.15,
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: primaryColor, width: 1.2),
            borderRadius: borderRadius,
          ),
        ),
        Positioned(
          top: -20.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            width: 45.0,
            height: 45.0,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: CustomImage(
              path: icon,
              height: 25.0, width: 25.0,
              // fit: BoxFit.cover,
              //  color: redColor,
            ),
          ),
        ),
        Positioned(
          bottom: size.height * 0.018,
          left: 0.0,
          right: 0.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextStyle(
                  text: title,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: blackColor,
                  //textAlign: TextAlign.center,
                  maxLine: 1,
                ),
                const SizedBox(height: 4.0),
                CustomTextStyle(
                  text: subTitle,
                  fontWeight: FontWeight.w400,
                  color: grayColor,
                  maxLine: 2,
                  textAlign: TextAlign.center,
                  fontSize: 16.0,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
