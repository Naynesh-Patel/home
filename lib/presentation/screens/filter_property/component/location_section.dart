import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/cubit/filter_property/filter_property_cubit.dart';
import 'package:real_estate/logic/cubit/filter_property/filter_property_state_model.dart';

import '../../../../data/model/home/location_model.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_test_style.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({Key? key, required this.location}) : super(key: key);
  final List<LocationItemModel> location;

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.read<FilterPropertyCubit>();
    return BlocBuilder<FilterPropertyCubit, FilterPropertyStateModel>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextStyle(
              text: 'Location',
              fontSize: 20.0,
            ),
            const SizedBox(height: 10.0),
            DropdownButtonFormField<LocationItemModel>(
              isDense: true,
              isExpanded: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: borderColor,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
              ),
              hint: const CustomTextStyle(
                text: 'Select Location',
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
              icon: const Icon(Icons.keyboard_arrow_down_sharp,
                  color: blackColor),
              items: location
                  .map<DropdownMenuItem<LocationItemModel>>(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: CustomTextStyle(
                        text: e.name,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val == null) return;
                filterCubit.locationChange(val.slug);
              },
            ),
          ],
        );
      },
    );
  }
}
