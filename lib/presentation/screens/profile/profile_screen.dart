import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/utils/utils.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_test_style.dart';
import '../../../../presentation/widget/primary_button.dart';
import '../../../data/model/agent/agent_profile_model.dart';
import '../../../logic/bloc/create_property/bloc/property_create_bloc.dart';
import '../../../logic/cubit/create_property/cubit/update_cubit.dart';
import '../../../logic/cubit/profile/profile_cubit.dart';
import '../../../logic/cubit/profile/profile_state_model.dart';
import '../../router/route_names.dart';
import '../../widget/loading_widget.dart';
import 'component/person_information.dart';
import 'component/person_single_property.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    profileCubit.getAgentProfile();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileCubit, ProfileStateModel>(
              listener: (context, state) {
            final profile = state.profileState;
            if (profile is ProfileUpdateLoaded) {
              Utils.showSnackBar(context, profile.message);
              //profileCubit.users = context.read<LoginBloc>().userInfo!.user;
              //final newUser = profileCubit.users;
              //profileCubit.getAgentDashboardInfo();
              profileCubit.getAgentProfile();
            }
          }),
          BlocListener<UpdateCubit, UpdateState>(
            listener: (context, state) {
              if (state is PropertyDeleteSuccess) {
                profileCubit.getAgentDashboardInfo();
              }
            },
          ),
          BlocListener<PropertyCreateBloc, PropertyCreateModel>(
            listener: (context, state) {
              final updateState = state.state;
              if (updateState is PropertyUpdateSuccess) {
                profileCubit.getAgentDashboardInfo();
              }
            },
          ),
          BlocListener<PropertyCreateBloc, PropertyCreateModel>(
            listener: (context, state) {
              final updateState = state.state;
              if (updateState is PropertyCreateSuccess) {
                profileCubit.getAgentDashboardInfo();
              }
            },
          ),
        ],
        child: BlocBuilder<ProfileCubit, ProfileStateModel>(
          builder: (context, state) {
            final profileState = state.profileState;
            if (profileState is ProfileLoading) {
              return const LoadingWidget();
            } else if (profileState is ProfileError) {
              if (profileState.statusCode == 503) {
                return ProfileLoadedWidget(
                    properties: profileCubit.agentDetailModel!);
              } else {
                return Center(
                    child: CustomTextStyle(
                        text: profileState.message, color: redColor));
              }
            } else if (profileState is ProfileLoaded) {
              return ProfileLoadedWidget(properties: profileState.profile);
            }
            return ProfileLoadedWidget(
                properties: profileCubit.agentDetailModel!);
            // return const Center(
            //   child: Text('something is wrong'),
            // );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<ProfileCubit, ProfileStateModel>(
        builder: (context, state) {
          final profileState = state.profileState;
          if (profileState is ProfileLoading) {
            return const SizedBox.shrink();
          } else if (profileState is ProfileError) {
            return const SizedBox.shrink();
          }
          return Container(
            height: size.height * 0.12,
            width: size.width,
            padding:
                const EdgeInsets.symmetric(horizontal: 34.0, vertical: 20.0),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: PrimaryButton(
              text: 'Create New Property',
              onPressed: () {
                Navigator.pushNamed(
                    context, RouteNames.choosePropertyOptionScreen);
              },
              bgColor: yellowColor,
              borderRadiusSize: radius,
              textColor: blackColor,
              fontSize: 20.0,
            ),
          );
        },
      ),
    );
  }
}

class ProfileLoadedWidget extends StatelessWidget {
  const ProfileLoadedWidget({Key? key, required this.properties})
      : super(key: key);
  final AgentProfileModel properties;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // if (properties.properties == null) {
    //   print('null');
    // } else {
    //   print('not null');
    // }
    return ListView(
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        PersonInformation(properties: properties),
        SizedBox(height: size.height * 0.07),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              CustomTextStyle(
                text: 'My Property List',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ],
          ),
        ),
        if (properties.properties != null) ...[
          PersonSingleProperty(properties: properties.properties!.data!),
        ],
        SizedBox(height: size.height * 0.07),
      ],
    );
  }
}
