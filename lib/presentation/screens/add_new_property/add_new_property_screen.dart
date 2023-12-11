import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_app_bar.dart';
import '../../../../presentation/widget/custom_test_style.dart';
import '../../../logic/bloc/create_property/bloc/property_create_bloc.dart';
import '../../utils/utils.dart';
import '../../widget/create_update_button.dart';
import '../../widget/error_text.dart';
import 'component/additional_widget.dart';
import 'component/aminities_widget.dart';
import 'component/category_and_period.dart';
import 'component/location_widget.dart';
import 'component/nearest_widget.dart';
import 'component/plan_widget.dart';
import 'component/property_image_section.dart';
import 'component/property_video_widget.dart';
import 'component/seo_widget.dart';

class AddNewPropertyScreen extends StatefulWidget {
  final String purpose;

  const AddNewPropertyScreen({Key? key, required this.purpose})
      : super(key: key);

  @override
  State<AddNewPropertyScreen> createState() => _AddNewPropertyScreenState();
}

class _AddNewPropertyScreenState extends State<AddNewPropertyScreen> {
  CustomTextStyle heading(String text) {
    return CustomTextStyle(
      text: text,
      color: blackColor,
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = context.read<PropertyCreateBloc>();
    bloc.add(PropertyPurposeEvent(purpose: widget.purpose));
    print(widget.purpose);
    final defaultVerticalSpaace = Utils.verticalSpace(16);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(
        title: 'Add New Property',
        bgColor: whiteColor,
      ),
      body: BlocListener<PropertyCreateBloc, PropertyCreateModel>(
        listener: (context, state) {
          final stateStatus = state.state;
          if (stateStatus is PropertyCreateLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (stateStatus is PropertyCreateError) {
              Utils.errorSnackBar(context, stateStatus.errorMsg);
            } else if (stateStatus is PropertyCreateSuccess) {
              Navigator.of(context).pop();
              Utils.showSnackBar(context, stateStatus.message);
            }
          }
        },
        child: Form(
          key: bloc.createForm,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              const CustomTextStyle(
                text: 'Property Information',
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
              defaultVerticalSpaace,
              const PropertyTypeWidget(),
              if (widget.purpose == 'rent') ...[
                defaultVerticalSpaace,
                const RentPeriodWidget(),
              ],
              defaultVerticalSpaace,
              BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                // buildWhen: (previous, current) =>
                //     previous.title != current.title,
                builder: (context, state) {
                  final stateStatus = state.state;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.title,
                        onChanged: (value) {
                          bloc.add(PropertyTitleEvent(title: value));
                        },
                        decoration: const InputDecoration(
                            hintText: 'Title *',
                            labelText: 'Title *',
                            hintStyle: TextStyle(color: Colors.black38),
                            labelStyle: TextStyle(
                              color: Colors.black38,
                            )),
                        keyboardType: TextInputType.text,
                      ),
                      if (stateStatus is PropertyCreateInvalidError) ...[
                        if (stateStatus.errors.title.isNotEmpty)
                          ErrorText(text: stateStatus.errors.title.first)
                      ]
                    ],
                  );
                },
              ),
              defaultVerticalSpaace,
              BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                // buildWhen: (previous, current) => previous.slug != current.slug,
                builder: (context, state) {
                  final stateStatus = state.state;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.slug,
                        onChanged: (value) {
                          final ss =
                              value.replaceAll(' ', '-').toLowerCase().trim();
                          bloc.add(PropertySlugEvent(slug: ss));
                          //print('ss $ss');
                        },
                        decoration: const InputDecoration(
                            hintText: 'Slug *',
                            labelText: 'Slug *',
                            hintStyle: TextStyle(color: Colors.black38),
                            labelStyle: TextStyle(
                              color: Colors.black38,
                            )),
                        keyboardType: TextInputType.text,
                      ),
                      if (stateStatus is PropertyCreateInvalidError) ...[
                        if (stateStatus.errors.slug.isNotEmpty)
                          ErrorText(text: stateStatus.errors.slug.first)
                      ]
                    ],
                  );
                },
              ),
              defaultVerticalSpaace,
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                      // buildWhen: (previous, current) =>
                      //     previous.price != current.price,
                      builder: (context, state) {
                        final stateStatus = state.state;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: state.price.toString(),
                              onChanged: (value) =>
                                  bloc.add(PropertyPriceEvent(price: value)),
                              decoration: const InputDecoration(
                                  hintText: 'Total Price *',
                                  labelText: 'Total Price *',
                                  hintStyle: TextStyle(color: Colors.black38),
                                  labelStyle: TextStyle(
                                    color: Colors.black38,
                                  )),
                              keyboardType: TextInputType.number,
                            ),
                            if (stateStatus is PropertyCreateInvalidError) ...[
                              if (stateStatus.errors.price.isNotEmpty)
                                ErrorText(text: stateStatus.errors.price.first)
                            ]
                          ],
                        );
                      },
                    ),
                  ),
                  Utils.horizontalSpace(8),
                  Expanded(
                    child: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                      builder: (context, state) {
                        final stateStatus = state.state;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: state.totalArea,
                              onChanged: (value) => bloc.add(
                                  PropertyTotalAreaEvent(totalArea: value)),
                              decoration: const InputDecoration(
                                  hintText: 'Total Area *',
                                  labelText: 'Total Area *',
                                  hintStyle: TextStyle(color: Colors.black38),
                                  labelStyle: TextStyle(
                                    color: Colors.black38,
                                  )),
                              keyboardType: TextInputType.text,
                            ),
                            if (stateStatus is PropertyCreateInvalidError) ...[
                              if (stateStatus.errors.totalArea.isNotEmpty)
                                ErrorText(
                                    text: stateStatus.errors.totalArea.first)
                            ]
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              defaultVerticalSpaace,
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                      builder: (context, state) {
                        final stateStatus = state.state;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: state.totalUnit,
                              onChanged: (value) => bloc.add(
                                  PropertyTotalUnitEvent(totalUnit: value)),
                              decoration: const InputDecoration(
                                  hintText: 'Total Unit *',
                                  labelText: 'Total Unit *',
                                  hintStyle: TextStyle(color: Colors.black38),
                                  labelStyle: TextStyle(
                                    color: Colors.black38,
                                  )),
                              keyboardType: TextInputType.text,
                            ),
                            if (stateStatus is PropertyCreateInvalidError) ...[
                              if (stateStatus.errors.totalUnit.isNotEmpty)
                                ErrorText(
                                    text: stateStatus.errors.totalUnit.first)
                            ]
                          ],
                        );
                      },
                    ),
                  ),
                  Utils.horizontalSpace(8),
                  Expanded(
                    child: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                      builder: (context, state) {
                        final stateStatus = state.state;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: state.totalBedroom,
                              onChanged: (value) => bloc.add(
                                  PropertyTotalBedroomEvent(
                                      totalBedroom: value)),
                              decoration: const InputDecoration(
                                  hintText: 'Total Bedroom *',
                                  labelText: 'Total Bedroom *',
                                  hintStyle: TextStyle(color: Colors.black38),
                                  labelStyle: TextStyle(
                                    color: Colors.black38,
                                  )),
                              keyboardType: TextInputType.text,
                            ),
                            if (stateStatus is PropertyCreateInvalidError) ...[
                              if (stateStatus.errors.totalBedroom.isNotEmpty)
                                ErrorText(
                                    text: stateStatus.errors.totalBedroom.first)
                            ]
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              defaultVerticalSpaace,
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                      builder: (context, state) {
                        final stateStatus = state.state;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: state.totalGarage,
                              onChanged: (value) => bloc.add(
                                  PropertyTotalGarageEvent(totalGarage: value)),
                              decoration: const InputDecoration(
                                  hintText: 'Total Garage *',
                                  labelText: 'Total Garage *',
                                  hintStyle: TextStyle(color: Colors.black38),
                                  labelStyle: TextStyle(
                                    color: Colors.black38,
                                  )),
                              keyboardType: TextInputType.text,
                            ),
                            if (stateStatus is PropertyCreateInvalidError) ...[
                              if (stateStatus.errors.totalGarage.isNotEmpty)
                                ErrorText(
                                    text: stateStatus.errors.totalGarage.first)
                            ]
                          ],
                        );
                      },
                    ),
                  ),
                  Utils.horizontalSpace(8),
                  Expanded(
                    child: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                      builder: (context, state) {
                        final stateStatus = state.state;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: state.totalBathroom,
                              onChanged: (value) => bloc.add(
                                  PropertyTotalBathroomEvent(
                                      totalBathroom: value)),
                              decoration: const InputDecoration(
                                  hintText: 'Total Bathroom *',
                                  labelText: 'Total Bathroom *',
                                  hintStyle: TextStyle(color: Colors.black38),
                                  labelStyle: TextStyle(
                                    color: Colors.black38,
                                  )),
                              keyboardType: TextInputType.text,
                            ),
                            if (stateStatus is PropertyCreateInvalidError) ...[
                              if (stateStatus.errors.slug.isNotEmpty)
                                ErrorText(text: stateStatus.errors.slug.first)
                            ]
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              defaultVerticalSpaace,
              BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                builder: (context, state) {
                  final stateStatus = state.state;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.totalKitchen,
                        onChanged: (value) => bloc.add(
                            PropertyTotalKitchenEvent(totalKitchen: value)),
                        decoration: const InputDecoration(
                            hintText: 'Total Kitchen *',
                            labelText: 'Total Kitchen *',
                            hintStyle: TextStyle(color: Colors.black38),
                            labelStyle: TextStyle(
                              color: Colors.black38,
                            )),
                        keyboardType: TextInputType.text,
                      ),
                      if (stateStatus is PropertyCreateInvalidError) ...[
                        if (stateStatus.errors.totalKitchen.isNotEmpty)
                          ErrorText(text: stateStatus.errors.totalKitchen.first)
                      ]
                    ],
                  );
                },
              ),
              defaultVerticalSpaace,
              BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                builder: (context, state) {
                  final stateStatus = state.state;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.description,
                        onChanged: (value) => bloc
                            .add(PropertyDescriptionEvent(description: value)),
                        decoration: const InputDecoration(
                          hintText: 'Description',
                        ),
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                      ),
                      if (stateStatus is PropertyCreateInvalidError) ...[
                        if (stateStatus.errors.description.isNotEmpty)
                          ErrorText(text: stateStatus.errors.description.first)
                      ]
                    ],
                  );
                },
              ),
              defaultVerticalSpaace,
              const PropertyImageSection(),
              defaultVerticalSpaace,
              const PropertyVideoWidget(),
              defaultVerticalSpaace,
              const LocationWidget(),
              defaultVerticalSpaace,
              const AminitiesWidget(),
              defaultVerticalSpaace,
              const NearestWidget(),
              defaultVerticalSpaace,
              const AdditionalWidget(),
              defaultVerticalSpaace,
              const PlanWidget(),
              defaultVerticalSpaace,
              const SeoWidget(),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CreateUpdateSubmitButton(
        title: 'Submit Property',
        press: () {
          bloc.add(SubmitCreateProperty());
        },
      ),
    );
  }
}
