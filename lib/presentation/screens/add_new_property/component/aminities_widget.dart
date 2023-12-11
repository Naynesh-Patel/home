import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/bloc/create_property/bloc/property_create_bloc.dart';
import '../../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/form_header_title.dart';

class AminitiesWidget extends StatefulWidget {
  const AminitiesWidget({super.key});

  @override
  State<AminitiesWidget> createState() => _AminitiesWidgetState();
}

class _AminitiesWidgetState extends State<AminitiesWidget> {
  bool isChecked = false;

  // final tempAminityList = <int>[];
  List<int> aminityList = <int>[];

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PropertyCreateBloc>();
    final cubit = context.read<CreateInfoCubit>();
    return BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
      builder: (context, state) {
        if (state.aminities.isNotEmpty) {
          aminityList = state.aminities;
        }
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 0.5,
                color: Colors.black,
              )),
          child: Column(
            children: [
              const FormHeaderTitle(title: "Aminities"),
              Utils.verticalSpace(14.0),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  ...List.generate(cubit.createPropertyInfo.aminities.length,
                      (index) {
                    final element = cubit.createPropertyInfo.aminities[index];
                    return SizedBox(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.grey,
                          ),
                          child: Checkbox(
                              value: aminityList.contains(element.id),
                              activeColor: primaryColor,
                              onChanged: (v) {
                                setState(() {
                                  if (aminityList.contains(element.id)) {
                                    print("remove ${element.id}");
                                    final findIndex = aminityList
                                        .indexWhere((e) => e == element.id);
                                    aminityList.removeAt(findIndex);
                                    // tempAminityList.removeWhere(
                                    //     (e) => e == element.id);
                                  } else {
                                    aminityList.add(element.id);
                                  }
                                });

                                // aminityList.add(aminityList[index]);
                                bloc.add(PropertyPropertyAminitiesEvent(
                                    propertyAminities: aminityList));
                              }),
                        ),
                        Text(element.aminity),
                      ],
                    ));
                  })
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
