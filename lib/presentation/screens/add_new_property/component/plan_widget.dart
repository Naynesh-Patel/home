import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/create_property/property_plan_dto.dart';
import '../../../../logic/bloc/create_property/bloc/property_create_bloc.dart';
import '../../../../logic/cubit/create_property/cubit/update_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/form_header_title.dart';
import '../../../widget/item_add_delete_btn.dart';
import '../../profile/component/person_single_property.dart';

class PlanWidget extends StatefulWidget {
  const PlanWidget({super.key});

  @override
  State<PlanWidget> createState() => _PlanWidgetState();
}

class _PlanWidgetState extends State<PlanWidget> {
  int planItem = 1;
  final titleTextField = <TextEditingController>[TextEditingController()];
  final desTextField = <TextEditingController>[TextEditingController()];
  final planImages = <String>[];
  List<PropertyPlanDto> planList = <PropertyPlanDto>[];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PropertyCreateBloc>();

    return BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
      builder: (context, state) {
        final updateCubit = context.read<UpdateCubit>();
        if (state.propertyPlanDto.isNotEmpty) {
          planList = state.propertyPlanDto;
          planItem = state.propertyPlanDto.length;

          for (var i = 0; i < planList.length; i++) {
            titleTextField.insert(i, TextEditingController());
            desTextField.insert(i, TextEditingController());
            planImages.insert(i, planList[i].planImages);

            titleTextField[i].text = planList[i].planTitles;
            desTextField[i].text = planList[i].planDescriptions;
          }
        } else {
          planList.add(const PropertyPlanDto(
              planImages: '', planTitles: '', planDescriptions: ''));
          bloc.add(PropertyPropertyPlanEvent(propertyPlan: planList));
        }
        print('pImagesss:$planImages');
        print('pI');
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 0.5,
                color: Colors.black,
              )),
          child: Column(
            children: [
              const FormHeaderTitle(title: "Property Plan"),
              Utils.verticalSpace(14.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ...List.generate(
                      planItem,
                      (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (index != 0) ...[
                              GestureDetector(
                                onTap: () async {
                                  print("plan id: ${planList[index].id}");
                                  if (planList[index].id != 0) {
                                    final result =
                                        await updateCubit.deleteSinglePlan(
                                            planList[index].id.toString());

                                    result.fold(
                                      (failure) {
                                        Utils.errorSnackBar(
                                            context, failure.errorMessage);
                                      },
                                      (data) {
                                        Utils.showSnackBar(
                                            context, "${data.message}");
                                        planList.removeAt(index);
                                        bloc.add(PropertyPropertyPlanEvent(
                                            propertyPlan: planList));
                                      },
                                    );
                                  } else {
                                    planList.removeAt(index);
                                    bloc.add(PropertyPropertyPlanEvent(
                                        propertyPlan: planList));
                                  }
                                  setState(() {});
                                },
                                child: const DeleteIconBtn(),
                              ),
                            ],
                            buildImage(index),
                            Utils.verticalSpace(16),
                            TextFormField(
                              controller: titleTextField[index],
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                  hintText: 'Title',
                                  labelText: 'Title',
                                  hintStyle: TextStyle(color: Colors.black38),
                                  labelStyle: TextStyle(
                                    color: Colors.black38,
                                  )),
                              keyboardType: TextInputType.text,
                            ),
                            Utils.verticalSpace(16),
                            TextFormField(
                              controller: desTextField[index],
                              // textInputAction: TextInputAction.done,

                              decoration: const InputDecoration(
                                  hintText: 'Description',
                                  labelText: 'Description',
                                  hintStyle: TextStyle(color: Colors.black38),
                                  labelStyle: TextStyle(
                                    color: Colors.black38,
                                  )),
                              keyboardType: TextInputType.text,
                            ),
                          ]),
                    ),
                    Utils.verticalSpace(16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            final temp = <PropertyPlanDto>[];
                            for (var i = 0; i < planItem; i++) {
                              temp.insert(
                                  i,
                                  PropertyPlanDto(
                                    planImages: planImages[i],
                                    planTitles: titleTextField[i].text,
                                    planDescriptions: desTextField[i].text,
                                  ));
                              planList = temp;
                              bloc.add(PropertyPropertyPlanEvent(
                                  propertyPlan: planList));
                              print("check plan $planList");
                            }
                            Utils.showSnackBar(context, 'Item Saved');
                            setState(() {});
                          },
                          child: const ItemSaveBtn(),
                        ),
                        GestureDetector(
                          onTap: () {
                            planList.add(const PropertyPlanDto(
                                planImages: '',
                                planTitles: '',
                                planDescriptions: ''));
                            bloc.add(PropertyPropertyPlanEvent(
                                propertyPlan: planList));

                            setState(() {});
                          },
                          child: const ItemAddBtn(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildImage(int index) {
    return BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
      builder: (context, state) {
        final bloc = context.read<PropertyCreateBloc>();

        final imageItem = planList[index].planImages;
        String thumbImage =
            imageItem.isEmpty ? KImages.placeholderImage : imageItem;

        bool isFile = imageItem.isNotEmpty
            ? imageItem.contains('https://')
                ? false
                : true
            : false;

        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                width: 0.2,
                color: Colors.grey,
              )),
          child: Column(
            children: [
              if (imageItem.isNotEmpty) ...[
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CustomImage(
                        path: thumbImage,
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        isFile: isFile,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                            onTap: () async {
                              final imageSourcePath =
                                  await Utils.pickSingleImage();
                              planList.insert(
                                  index,
                                  PropertyPlanDto(
                                    planImages: imageSourcePath!,
                                    planTitles: titleTextField[index].text,
                                    planDescriptions: desTextField[index].text,
                                  ));
                              bloc.add(PropertyPropertyPlanEvent(
                                  propertyPlan: planList));
                              print("img $planList");

                              setState(() {});
                            },
                            child: const EditBtn())),
                  ],
                ),
              ] else ...[
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      final imageSourcePath = await Utils.pickSingleImage();
                      planList.insert(
                          index,
                          PropertyPlanDto(
                            planImages: imageSourcePath!,
                            planTitles: titleTextField[index].text,
                            planDescriptions: desTextField[index].text,
                          ));
                      bloc.add(
                          PropertyPropertyPlanEvent(propertyPlan: planList));
                      print("img $planList");

                      setState(() {});
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.upload,
                          size: 24,
                          color: primaryColor,
                        ),
                        Utils.horizontalSpace(8),
                        Text(
                          "Upload Plan Images",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
