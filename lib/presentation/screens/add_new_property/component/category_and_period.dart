import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/category/property_category_model.dart';
import '../../../../logic/bloc/create_property/bloc/property_create_bloc.dart';
import '../../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../../core/dummy_text.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/error_text.dart';

class PropertyTypeWidget extends StatelessWidget {
  const PropertyTypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateInfoCubit>();
    final bloc = context.read<PropertyCreateBloc>();
    return BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
      builder: (context, state) {
        PropertyCategory categoryModel =
            cubit.createPropertyInfo!.types.first;
        if (state.typeId.isNotEmpty) {
          categoryModel = cubit.createPropertyInfo!
              .types
              .where((element) => element.id.toString() == state.typeId)
              .first;
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // heading('Select Category'),
            BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
              builder: (context, state) {
                final stateStatus = state.state;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<PropertyCategory>(
                      isDense: true,
                      isExpanded: true,
                      value: categoryModel,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: borderColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                      ),
                      hint: const CustomTextStyle(
                        text: 'Select Category',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_sharp,
                          color: blackColor),
                      items: cubit.createPropertyInfo.types
                          .map<DropdownMenuItem<PropertyCategory>>(
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
                        bloc.add(PropertyTypeEvent(type: val!.id.toString()));
                      },
                    ),
                    if (stateStatus is PropertyCreateInvalidError) ...[
                      if (stateStatus.errors.propertytypeId.isNotEmpty)
                        ErrorText(text: stateStatus.errors.propertytypeId.first)
                    ]
                  ],
                );
              },
            ),

          ],
        );
      },
    );
  }
}

class RentPeriodWidget extends StatelessWidget {
  const RentPeriodWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PropertyCreateBloc>();
    return BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
      builder: (context, state) {
        String value = rendPeriodList.first;
        if (state.rentPeriod.isNotEmpty) {
          value = rendPeriodList
              .where((element) => element.toLowerCase() == state.rentPeriod)
              .first;
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // heading('Select Category'),
            DropdownButtonFormField<String>(
              isDense: true,
              isExpanded: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: borderColor,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
              ),
              value: value,
              hint: const CustomTextStyle(
                text: 'Rent',
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
              icon: const Icon(Icons.keyboard_arrow_down_sharp,
                  color: blackColor),
              items: rendPeriodList
                  .map<DropdownMenuItem<String>>(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: CustomTextStyle(
                        text: e,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                bloc.add(
                    PropertyRentPeriodEvent(rentPeriod: val!.toLowerCase()));
              },
            ),
          ],
        );
      },
    );
  }
}
