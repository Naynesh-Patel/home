import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/cubit/filter_property/filter_property_cubit.dart';

import '../../../core/dummy_text.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_test_style.dart';

class PurposeSection extends StatelessWidget {
  const PurposeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.read<FilterPropertyCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTextStyle(
          text: 'Purpose',
          fontSize: 20.0,
        ),
        const SizedBox(height: 10.0),
        DropdownButtonFormField<DummyPurpose>(
          isDense: true,
          isExpanded: true,
          decoration: const InputDecoration(
            filled: true,
            fillColor: borderColor,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
            ),
          ),
          value: dummyPurpose.first,
          hint: const CustomTextStyle(
            text: 'Select Purpose',
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
          ),
          icon: const Icon(Icons.keyboard_arrow_down_sharp, color: blackColor),
          items: dummyPurpose
              .map<DropdownMenuItem<DummyPurpose>>(
                (e) => DropdownMenuItem(
                  value: e,
                  child: CustomTextStyle(
                    text: e.title,
                    fontSize: 16.0,
                  ),
                ),
              )
              .toList(),
          onChanged: (val) {
            if (val == null) return;
            String title = val.title
                .toLowerCase()
                .replaceAll(' ', '')
                .replaceAll('for', '');
            //print(title);
            filterCubit.purposeChange(title);
          },
        ),
      ],
    );
  }
}
