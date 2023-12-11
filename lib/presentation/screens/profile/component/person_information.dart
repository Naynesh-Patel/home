import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/data_provider/remote_url.dart';
import 'package:real_estate/logic/bloc/login/login_bloc.dart';
import 'package:real_estate/presentation/router/route_names.dart';

import '../../../../data/model/agent/agent_profile_model.dart';
import '../../../../data/model/auth/user_profile_model.dart';
import '../../../../logic/cubit/profile/profile_cubit.dart';
import '../../../../logic/cubit/profile/profile_state_model.dart';
import '../../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';

class PersonInformation extends StatelessWidget {
  const PersonInformation({Key? key, required this.properties})
      : super(key: key);
  final AgentProfileModel properties;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Map<String, String>> propertyList = [
      {"number": '20', "title": 'Property'},
      {"number": '330', "title": 'Total Sell'},
      {"number": '40', "title": 'Apartment'},
    ];
    final profile = context.read<LoginBloc>().userInfo!.user;
    print('proffffff ${profile.address}');
    final profileCubit = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileStateModel>(
      builder: (context, state) {
        final profile = state.profileState;
        if (profile is AgentProfileLoaded) {
          return ProfileInLoaded(profile: profile.users!);
        }
        return ProfileInLoaded(profile: profileCubit.users!);
      },
    );
  }
}

class ProfileInLoaded extends StatelessWidget {
  const ProfileInLoaded({Key? key, required this.profile}) : super(key: key);
  final UserProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final properties = context.read<ProfileCubit>().agentDetailModel;
    final appSetting = context.read<AppSettingCubit>();
    final image = profile.image.isNotEmpty
        ? profile.image
        : appSetting.settingModel!.setting.defaultAvatar;
    return SizedBox(
      height: size.height * 0.34,
      width: size.width,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: CustomImage(
              path: KImages.profileBackground,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 20.0,
            left: 10.0,
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
                  text: 'My Profile',
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  color: whiteColor,
                )
              ],
            ),
          ),
          Positioned.fill(
              top: -size.height / 60.0,
              left: 10.0,
              right: 0.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: ClipOval(
                      child: CustomImage(
                        path: RemoteUrls.imageUrl(image),
                        height: size.height * 0.14,
                        width: size.height * 0.14,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextStyle(
                        text: profile.name,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const CustomImage(
                            path: KImages.locationIcon,
                            color: whiteColor,
                          ),
                          const SizedBox(width: 6.0),
                          CustomTextStyle(
                            text: profile.address.isNotEmpty
                                ? profile.address
                                : 'Your Address will show here',
                            color: whiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const CustomImage(
                            path: KImages.callIcon,
                            color: whiteColor,
                            height: 12.0,
                            width: 12.0,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 6.0),
                          CustomTextStyle(
                            text: profile.phone.isNotEmpty
                                ? profile.phone
                                : '+880 123-456-7890',
                            color: whiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )),
          Positioned(
            right: size.width * 0.08,
            top: size.height * 0.03,
            child: ElevatedButton.icon(
              //onPressed: () => messageDialog(context),
              onPressed: () => Navigator.pushNamed(
                  context, RouteNames.updateProfileScreen,
                  arguments: profile),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(100.0, 40.0)),
                backgroundColor: MaterialStateProperty.all(yellowColor),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
                elevation: MaterialStateProperty.all(0.0),
                shadowColor: MaterialStateProperty.all(transparent),
                splashFactory: NoSplash.splashFactory,
              ),
              icon: const CustomImage(
                path: KImages.settingIcon03,
                color: blackColor,
              ),
              label: const CustomTextStyle(
                text: 'Edit',
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: blackColor,
              ),
            ),
          ),
          Positioned(
            bottom: -(size.height * 0.05),
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 70.0,
              width: double.infinity,
              color: const Color(0xFFECEAFF),
              // color: whiteColor,
              margin:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: DottedBorder(
                color: primaryColor,
                dashPattern: const [6, 3],
                strokeCap: StrokeCap.square,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    propertiesCount(properties!.publishProperty, 'Property'),
                    propertiesCount(properties.totalPurchase, 'Purchase'),
                    //propertiesCount(properties.totalWishlist, 'Wishlist'),
                    // propertiesCount(properties.awaitingProperty, 'Awaiting'),
                    // propertiesCount(properties.rejectProperty, 'Rejected'),
                    propertiesCount(properties.totalReview, 'Reviewed'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget propertiesCount(int count, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextStyle(
            text: count.toString().padLeft(2, '0'),
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: blackColor),
        const SizedBox(height: 5.0),
        CustomTextStyle(
            text: title,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: grayColor),
      ],
    );
  }
}
