import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/data/data_provider/remote_url.dart';
import '/data/model/auth/user_profile_model.dart';
import '/logic/cubit/setting/app_setting_cubit.dart';
import '../../../router/route_names.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';

class SingleBrokerAgentCartView extends StatelessWidget {
  const SingleBrokerAgentCartView({Key? key, required this.agent})
      : super(key: key);
  final UserProfileModel agent;

  @override
  Widget build(BuildContext context) {
    final defaultImage =
        context.read<AppSettingCubit>().settingModel!.setting.defaultAvatar;
    final image = agent.image.isNotEmpty ? agent.image : defaultImage;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.agentProfileScreen,
            arguments: agent.userName);
        //print(agent.userName);
      },
      child: Container(
        width: 160.0.w,
        margin: const EdgeInsets.only(right: 0.0),
        // padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: borderRadius,
              child: CustomImage(
                path: RemoteUrls.imageUrl(image),
                width: double.infinity,
                height: 160.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)
                      .copyWith(bottom: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextStyle(
                    text: agent.name,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: blackColor,
                  ),
                  CustomTextStyle(
                    text: agent.designation.isNotEmpty
                        ? agent.designation
                        : 'Your Designation',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                    color: grayColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
