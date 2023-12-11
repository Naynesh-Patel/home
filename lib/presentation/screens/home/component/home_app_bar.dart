import 'package:flutter/material.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../router/route_names.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key, required this.logo, required this.image})
      : super(key: key);

  final String logo;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImage(
            path: RemoteUrls.imageUrl(logo),
            height: 45.0,
            width: 120.0,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, RouteNames.premiumMembershipScreen),
                child: Container(
                  height: 50.0,
                  width: 100.0,
                  margin: const EdgeInsets.only(right: 14.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: whiteColor, width: 2.0),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: yellowColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: CustomTextStyle(
                        text: 'Create',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.profileScreen),
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: whiteColor, width: 2.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CustomImage(
                      path: RemoteUrls.imageUrl(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
