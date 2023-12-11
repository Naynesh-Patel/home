import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/logic/cubit/home/cubit/home_cubit.dart';
import '/logic/cubit/profile/profile_cubit.dart';
import '/presentation/utils/utils.dart';
import '/presentation/widget/loading_widget.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../data/model/home/home_data_model.dart';
import '../../../logic/cubit/profile/profile_state_model.dart';
import '../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../router/route_names.dart';
import 'component/fun_fact_section.dart';
import 'component/home_app_bar.dart';
import 'component/horizontal_category_view.dart';
import 'component/horizontal_property_view.dart';
import 'component/property_agents_view.dart';
import 'component/search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      //appBar: const HomeAppBar(),
      body: BlocListener<ProfileCubit, ProfileStateModel>(
        listener: (context, state) {
          final profile = state.profileState;
          if (profile is ProfileUpdateLoaded) {
            Utils.showSnackBar(context, profile.message);
            context.read<ProfileCubit>().getAgentProfile();
          }
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const LoadingWidget();
            }
            if (state is HomeErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is HomeDataLoaded) {
              return LoadedWidget(homeDataModel: state.homeDataLoaded);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class LoadedWidget extends StatelessWidget {
  const LoadedWidget({
    super.key,
    required this.homeDataModel,
  });

  final HomeDataModel homeDataModel;

  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<AppSettingCubit>().settingModel!.setting;
    final profileImage = context.read<ProfileCubit>().users!.image;
    final image =
        profileImage.isNotEmpty ? profileImage : appSetting.defaultAvatar;
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        HomeAppBar(image: image, logo: appSetting.logo),
        Utils.verticalSpace(0.0),
        // const HomeAppBar(),
        const SearchField(),
        HorizontalCategoryView(category: homeDataModel.category),
        Utils.verticalSpace(20),
        if (homeDataModel.urgentProperty != null) ...[
          HorizontalPropertyView(
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.urgentPropertyScreen),
              headingText: homeDataModel.urgentProperty!.title,
              featuredProperty: homeDataModel.urgentProperty!),
        ],
        Utils.verticalSpace(20),
        PropertyAgentView(agentsModel: homeDataModel.agent),
        Utils.verticalSpace(20),
        HorizontalPropertyView(
            onTap: () =>
                Navigator.pushNamed(context, RouteNames.allPropertyScreen),
            headingText: homeDataModel.featuredProperty!.description,
            featuredProperty: homeDataModel.featuredProperty!),
        Utils.verticalSpace(20),
        FunFactSection(counter: homeDataModel.counter),
        Utils.verticalSpace(20),
        // const RecommendedProperties(),
        // const SizedBox(height: 20.0),
      ],
    );
  }
}
