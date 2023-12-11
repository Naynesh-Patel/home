import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/auth/user_profile_model.dart';
import '../../../logic/cubit/profile/profile_cubit.dart';
import '../../../logic/cubit/profile/profile_state_model.dart';
import '../../utils/utils.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/error_text.dart';
import '../../widget/loading_widget.dart';
import '../../widget/primary_button.dart';
import 'component/profile_image.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key, required this.profile})
      : super(key: key);
  final UserProfileModel profile;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    getExitingProfileData();
    super.initState();
  }

  getExitingProfileData() {
    final profile = context.read<ProfileCubit>();
    profile.nameChange(widget.profile.name);
    profile.phoneChange(widget.profile.phone);
    profile.addressChange(widget.profile.address);
    profile.designationChange(widget.profile.designation);
    profile.aboutMeChange(widget.profile.aboutMe);
    profile.facebookChange(widget.profile.facebook);
    profile.instagramChange(widget.profile.instagram);
    profile.twitterChange(widget.profile.twitter);
    profile.linkedinChange(widget.profile.linkedin);
  }

  final _className = "UpdateProfileScreen";
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    //print('nameeee ${widget.profile.name}');
    final spacer = Utils.verticalSpace(20.0);
    final profileCubit = context.read<ProfileCubit>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: 'Update Profile',
      ),
      body: BlocListener<ProfileCubit, ProfileStateModel>(
        listener: (context, state) {
          final update = state.profileState;
          if (update is ProfileUpdateLoading) {
            log(_className, name: update.toString());
          } else if (update is ProfileUpdateError) {
            Utils.errorSnackBar(context, update.message);
          } else if (update is ProfileUpdateLoaded) {
            Navigator.of(context).pop();
            //Utils.showSnackBar(context, update.message);
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          controller: _controller,
          children: [
            const SizedBox(height: 20.0),
            ProfileImages(profilePicture: widget.profile.image),
            spacer,
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                final update = state.profileState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: widget.profile.name,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                      ),
                      keyboardType: TextInputType.name,
                      onChanged: (String text) => profileCubit.nameChange(text),
                    ),
                    if (update is ProfileUpdateFormValidate) ...[
                      if (update.error.name.isNotEmpty)
                        ErrorText(
                          text: update.error.name.first,
                        ),
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                final update = state.profileState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: widget.profile.phone,
                      decoration: const InputDecoration(
                        hintText: 'Phone',
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (String text) =>
                          profileCubit.phoneChange(text),
                    ),
                    if (update is ProfileUpdateFormValidate) ...[
                      if (update.error.phone.isNotEmpty)
                        ErrorText(
                          text: update.error.phone.first,
                        ),
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                final update = state.profileState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: widget.profile.address,
                      decoration: const InputDecoration(
                        hintText: 'Address',
                      ),
                      keyboardType: TextInputType.streetAddress,
                      onChanged: (String text) =>
                          profileCubit.addressChange(text),
                    ),
                    if (update is ProfileUpdateFormValidate) ...[
                      if (update.error.address.isNotEmpty)
                        ErrorText(
                          text: update.error.address.first,
                        ),
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                final update = state.profileState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: widget.profile.designation,
                      decoration: const InputDecoration(
                        hintText: 'Designation',
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (String text) =>
                          profileCubit.designationChange(text),
                    ),
                    if (update is ProfileUpdateFormValidate) ...[
                      if (update.error.designation.isNotEmpty)
                        ErrorText(
                          text: update.error.designation.first,
                        ),
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                final update = state.profileState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: widget.profile.aboutMe,
                      decoration: const InputDecoration(
                        hintText: 'About me',
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 6,
                      onChanged: (String text) =>
                          profileCubit.aboutMeChange(text),
                    ),
                    if (update is ProfileUpdateFormValidate) ...[
                      if (update.error.aboutMe.isNotEmpty)
                        ErrorText(
                          text: update.error.aboutMe.first,
                        ),
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                return TextFormField(
                  initialValue: widget.profile.facebook,
                  decoration: const InputDecoration(
                    hintText: 'Facebook',
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (String text) => profileCubit.facebookChange(text),
                );
              },
            ),
            spacer,
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                return TextFormField(
                  initialValue: widget.profile.twitter,
                  decoration: const InputDecoration(
                    hintText: 'Twitter',
                  ),
                  keyboardType: TextInputType.url,
                  onChanged: (String text) => profileCubit.twitterChange(text),
                );
              },
            ),
            spacer,
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                return TextFormField(
                  initialValue: widget.profile.linkedin,
                  decoration: const InputDecoration(
                    hintText: 'LinkedIn',
                  ),
                  keyboardType: TextInputType.url,
                  onChanged: (String text) => profileCubit.linkedinChange(text),
                );
              },
            ),
            spacer,
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                return TextFormField(
                  initialValue: widget.profile.instagram,
                  decoration: const InputDecoration(
                    hintText: 'Instagram',
                  ),
                  keyboardType: TextInputType.url,
                  onChanged: (String text) =>
                      profileCubit.instagramChange(text),
                );
              },
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                final update = state.profileState;
                if (update is ProfileUpdateLoading) {
                  return const LoadingWidget();
                }
                return PrimaryButton(
                    text: 'Update Profile',
                    onPressed: () {
                      Utils.closeKeyBoard(context);
                      profileCubit.updateAgentProfileInfo();
                    });
              },
            ),
            Utils.verticalSpace(20.0),
          ],
        ),
      ),
    );
  }
}
