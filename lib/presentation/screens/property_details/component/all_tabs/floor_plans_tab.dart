import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../logic/cubit/home/cubit/property_details_cubit.dart';
import '../single_floor_structure.dart';

class FloorPlansTab extends StatelessWidget {
  const FloorPlansTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyDetailsCubit, PropertyDetailsState>(
      builder: (context, state) {
        if (state is PropertyDetailsLoaded) {
          final floors = state.singlePropertyModel.propertyPlans;
          return ListView.builder(
            itemCount: floors!.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 20.0),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => SingleFloorStructure(
              plan: floors[index],
              isExpand: index == 1 ? true : false,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
