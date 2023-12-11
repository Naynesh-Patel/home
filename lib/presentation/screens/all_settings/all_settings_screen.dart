import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/cubit/profile/profile_cubit.dart';

import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/utils/k_images.dart';
import '../../../../presentation/utils/utils.dart';
import '../../../../presentation/widget/custom_images.dart';
import '../../../../presentation/widget/custom_test_style.dart';
import '../../../../presentation/widget/primary_button.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../router/route_names.dart';
import 'component/single_elements.dart';

class AllSettingScreen extends StatelessWidget {
  const AllSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileCubit>();
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: settingAppBar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20.0),
          const CustomTextStyle(
            text: 'My Profile',
            fontWeight: FontWeight.w500,
            fontSize: 15.0,
            color: primaryColor,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(radius)),
            child: Column(
              children: [
                SingleElement(
                  icon: KImages.settingIcon01,
                  text: 'All Category',
                  onTap: () => Navigator.pushNamed(
                      context, RouteNames.allCategoryScreen),
                ),
                SingleElement(
                  icon: KImages.settingIcon02,
                  text: 'My Profile',
                  onTap: () =>
                      Navigator.pushNamed(context, RouteNames.profileScreen),
                ),
                SingleElement(
                  icon: KImages.settingIcon03,
                  text: 'Edit Profile',
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.updateProfileScreen,
                        arguments: profile.users);
                  },
                ),
                // SingleElement(
                //     icon: KImages.settingIcon04,
                //     text: 'My Deals',
                //     onTap: () {}),
                SingleElement(
                  icon: KImages.settingIcon05,
                  text: 'About us',
                  onTap: () =>
                      Navigator.pushNamed(context, RouteNames.aboutUsScreen),
                ),
                SingleElement(
                    icon: KImages.settingIcon06,
                    text: 'Review',
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.reviewScreen)),
                SingleElement(
                  icon: KImages.settingIcon07,
                  text: 'Support/Contact us',
                  onTap: () =>
                      Navigator.pushNamed(context, RouteNames.contactUsScreen),
                  // onTap: () => contactUsDialog(context),
                ),
              ],
            ),
          ),
          const CustomTextStyle(
            text: 'Settings',
            fontWeight: FontWeight.w500,
            fontSize: 15.0,
            color: primaryColor,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(radius)),
            child: Column(
              children: [
                // SingleElement(
                //     icon: KImages.settingIcon08, text: 'Setting', onTap: () {}),
                SingleElement(
                  icon: KImages.settingIcon14,
                  text: 'Purchase History',
                  onTap: () =>
                      Navigator.pushNamed(context, RouteNames.purchaseScreen),
                ),
                SingleElement(
                  icon: KImages.settingIcon07,
                  text: 'Terms & Conditions',
                  onTap: () => Navigator.pushNamed(
                      context, RouteNames.termsAndConditionScreen),
                ),
                SingleElement(
                  icon: KImages.settingIcon10,
                  text: 'Privacy Policy',
                  onTap: () => Navigator.pushNamed(
                      context, RouteNames.privacyPolicyScreen),
                ),
                SingleElement(
                  icon: KImages.settingIcon11,
                  text: 'FAQ',
                  onTap: () =>
                      Navigator.pushNamed(context, RouteNames.faqScreen),
                ),
                SingleElement(
                  icon: KImages.settingIcon12,
                  text: 'App Info',
                  onTap: () => Utils.appInfoDialog(context),
                ),
                BlocListener<LoginBloc, LoginModelState>(
                  listener: (context, state) {
                    final logout = state.state;
                    if (logout is LoginStateLogOutLoading) {
                      Utils.loadingDialog(context);
                    } else {
                      Utils.closeDialog(context);
                      if (logout is LoginStateSignOutError) {
                        Utils.errorSnackBar(context, logout.errorMsg);
                      } else if (logout is LoginStateLogOut) {
                        Navigator.of(context).pop();
                        Navigator.pushNamedAndRemoveUntil(
                            context, RouteNames.loginScreen, (route) => false);
                        Utils.showSnackBar(context, logout.msg);
                      }
                    }
                  },
                  child: SingleElement(
                    icon: KImages.settingIcon13,
                    text: 'Logout',
                    onTap: () => logoutDialog(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  editProfileDialog(BuildContext context) {
    const spacer = SizedBox(height: 12.0);
    Utils.showCustomDialog(
      context,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTextStyle(
                    text: 'Update your profile',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: blackColor,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const CustomImage(path: KImages.cancelIcon))
                ],
              ),
              const SizedBox(height: 14.0),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                keyboardType: TextInputType.name,
              ),
              spacer,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              spacer,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              spacer,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
              ),
              const SizedBox(height: 20.0),
              PrimaryButton(
                  text: 'Update Profile',
                  onPressed: () => Navigator.of(context).pop(),
                  textColor: blackColor,
                  fontSize: 20.0,
                  borderRadiusSize: radius,
                  bgColor: yellowColor)
            ],
          ),
        ),
      ),
    );
  }

  contactUsDialog(BuildContext context) {
    const spacer = SizedBox(height: 12.0);
    Utils.showCustomDialog(
      context,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTextStyle(
                    text: 'Contact Us',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: blackColor,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const CustomImage(path: KImages.cancelIcon))
                ],
              ),
              const SizedBox(height: 14.0),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                keyboardType: TextInputType.name,
              ),
              spacer,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              spacer,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              spacer,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
              ),
              const SizedBox(height: 20.0),
              PrimaryButton(
                  text: 'Send Message',
                  onPressed: () => Navigator.of(context).pop(),
                  textColor: blackColor,
                  fontSize: 20.0,
                  borderRadiusSize: radius,
                  bgColor: yellowColor)
            ],
          ),
        ),
      ),
    );
  }

  logoutDialog(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    Utils.showCustomDialog(
      context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomImage(path: KImages.logoutIcon),
            const SizedBox(height: 10.0),
            const CustomTextStyle(
              textAlign: TextAlign.center,
              text: 'Are you sure\nYou want to Logout?',
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoutButton(
                    'Not Now', () => Navigator.of(context).pop(), blackColor),
                const SizedBox(width: 14.0),
                logoutButton('Logout', () {
                  loginBloc.add(const LoginEventLogout());
                }, primaryColor),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget logoutButton(String text, VoidCallback onPressed, Color bgColor) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(100.0, 40.0)),
          backgroundColor: MaterialStateProperty.all(bgColor),
          elevation: MaterialStateProperty.all(0.0),
          shadowColor: MaterialStateProperty.all(transparent),
          splashFactory: NoSplash.splashFactory,
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: borderRadius))),
      child: CustomTextStyle(
        text: text,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
        color: whiteColor,
      ),
    );
  }

  PreferredSizeWidget settingAppBar(BuildContext context) {
    final profile = context.read<ProfileCubit>();
    final appSetting = context.read<AppSettingCubit>();
    final image = profile.users!.image.isNotEmpty
        ? profile.users!.image
        : appSetting.settingModel!.setting.defaultAvatar;
    return AppBar(
      toolbarHeight: 100.0,
      elevation: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 40.0,
              width: 80.0,
              child: CustomImage(
                //path: KImages.logo3,
                path:
                    RemoteUrls.imageUrl(appSetting.settingModel!.setting.logo),
                fit: BoxFit.cover,
                color: whiteColor,
              )),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, RouteNames.profileScreen),
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
                  // path: KImages.profilePicture,
                  path: RemoteUrls.imageUrl(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: primaryColor,
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
    );
  }
}
