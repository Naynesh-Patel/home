import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_app_bar.dart';
import '../../../logic/cubit/home/cubit/home_cubit.dart';
import '../../router/route_names.dart';
import '../home/component/single_category_circle.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCubit =
        context.read<HomeCubit>().homeModel.category.propertyTypes;
    //print(homeCubit[0].slug);
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: const CustomAppBar(title: 'All Category'),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 0.0, mainAxisExtent: 110.0),
        itemCount: homeCubit.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              final type =
                  homeCubit[index].name.replaceAll(' ', '-').toLowerCase();
              print(type);
              Navigator.pushNamed(context, RouteNames.filterPropertyScreen,
                  arguments: type);
            },
            child: SingleCategoryCircle(category: homeCubit[index])),
      ),
    );
  }
}
