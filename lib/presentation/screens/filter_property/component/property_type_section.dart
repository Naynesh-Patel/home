import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/cubit/filter_property/filter_property_state_model.dart';

import '../../../../data/model/product/property_type_model.dart';
import '../../../../logic/cubit/filter_property/filter_property_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_test_style.dart';

class PropertyTypeSection extends StatelessWidget {
  const PropertyTypeSection({Key? key, required this.propertyType})
      : super(key: key);
  final List<PropertyTypeModel> propertyType;

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.read<FilterPropertyCubit>();
    //print(filterCubit.property!.propertyType!.length);
    return BlocBuilder<FilterPropertyCubit, FilterPropertyStateModel>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextStyle(text: 'Property Type', fontSize: 20.0),
            const SizedBox(height: 10.0),
            DropdownButtonFormField<PropertyTypeModel>(
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
                text: 'Select Property Type',
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
              icon: const Icon(Icons.keyboard_arrow_down_sharp,
                  color: blackColor),
              items: filterCubit.property!.propertyType!
                  .map<DropdownMenuItem<PropertyTypeModel>>(
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
                //if (val == null) return;
                filterCubit
                    .typeChange(val!.name.toLowerCase().replaceAll(' ', '-'));
              },
            ),
          ],
        );
      },
    );
  }
}
