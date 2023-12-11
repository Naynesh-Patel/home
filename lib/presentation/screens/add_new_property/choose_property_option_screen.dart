import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_app_bar.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/product/property_choose_model.dart';
import '../../../logic/bloc/create_property/bloc/property_create_bloc.dart';
import '../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../router/route_names.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/loading_widget.dart';
import 'component/single_choose_option.dart';

class ChoosePropertyOptionScreen extends StatelessWidget {
  const ChoosePropertyOptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final propertyCubit = context.read<CreateInfoCubit>();
    propertyCubit.getPropertyChooseInfo();
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Choose Property Option',
      ),
      body: BlocBuilder<CreateInfoCubit, CreateInfoState>(
        builder: (context, state) {
          if (state is CreateInfoLoading) {
            return const LoadingWidget();
          } else if (state is CreateInfoError) {
            if (state.statusCode == 503) {
              return LoadedPropertyChooseInfo(
                  chooseProperty: propertyCubit.chooseProperty!);
            } else {
              return Center(
                child: CustomTextStyle(
                  text: state.error,
                  color: redColor,
                  fontSize: 20.0,
                ),
              );
            }
          } else if (state is PropertyChooseInfoLoaded) {
            return LoadedPropertyChooseInfo(
                chooseProperty: state.chooseProperty);
          }
          return const Center(
              child: CustomTextStyle(text: 'Something went wrong'));
        },
      ),
    );
  }
}

class LoadedPropertyChooseInfo extends StatelessWidget {
  const LoadedPropertyChooseInfo({Key? key, required this.chooseProperty})
      : super(key: key);
  final PropertyChooseModel chooseProperty;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: [
        SingleChooseOption(
          onTap: () {
            context.read<PropertyCreateBloc>().add(PropertyStateReset());
            Navigator.pushNamed(context, RouteNames.addNewPropertyScreen,
                arguments: 'rent');
          },
          //icon: KImages.rentIcon,
          icon: RemoteUrls.imageUrl(chooseProperty.rentLogo),
          text: chooseProperty.rentTitle,
          subText: chooseProperty.rentDescription,
          iconBgColor: borderColor,
        ),
        const SizedBox(height: 10.0),
        SingleChooseOption(
          onTap: () {
            context.read<PropertyCreateBloc>().add(PropertyStateReset());
            Navigator.pushNamed(context, RouteNames.addNewPropertyScreen,
                arguments: 'sale');
          },
          //icon: KImages.saleIcon,
          icon: RemoteUrls.imageUrl(chooseProperty.saleLogo),
          text: chooseProperty.saleTitle,
          subText: chooseProperty.saleDescription,
          iconBgColor: yellowColor.withOpacity(0.15),
        ),
      ],
    );
  }
}
