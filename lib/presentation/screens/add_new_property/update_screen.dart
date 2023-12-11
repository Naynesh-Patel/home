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

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<UpdateScreen> createState() => _AddNewPropertyScreenState();
}

class _AddNewPropertyScreenState extends State<UpdateScreen> {
  CustomTextStyle heading(String text) {
    return CustomTextStyle(
      text: text,
      color: blackColor,
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   context.read<PropertyCreateBloc>().add(PropertyStateReset());
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   context.read<PropertyCreateBloc>().add(PropertyStateReset());
  // }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PropertyCreateBloc>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(
        title: 'Update Property',
        bgColor: whiteColor,
      ),
      body: BlocConsumer<PropertyCreateBloc, PropertyCreateModel>(
        listener: (context, listenState) {
          final listenStatus = listenState.state;
          if (listenStatus is PropertyUpdateLoading) {
            Utils.loadingDialog(context);
          } else {
            print("state $listenStatus");
            Utils.closeDialog(context);
            if (listenStatus is PropertyUpdateSuccess) {
              Utils.showSnackBar(context, listenStatus.message);
              Navigator.pop(context);
            }
            if (listenStatus is PropertyUpdateError) {
              Utils.errorSnackBar(context, listenStatus.errorMsg);
            }
          }
        },
        builder: (context, state) {
          return BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
            builder: (context, state) {
              final stateStatus = state.state;
              // if (stateStatus is PropertyEditInfoData) {
              return const LoadedWidget();
              // }
              // return const Center(child: Text("Something went wrong!"));
            },
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
        builder: (context, state) {
          return CreateUpdateSubmitButton(
              title: 'Update Now',
              press: () {
                bloc.add(
                    SubmitUpdateProperty(propertyId: widget.id.toString()));
              });
        },
      ),
    );
  }
}

class LoadedWidget extends StatefulWidget {
  const LoadedWidget({Key? key}) : super(key: key);

  @override
  State<LoadedWidget> createState() => _LoadedWidgetState();
}

class _LoadedWidgetState extends State<LoadedWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PropertyCreateBloc>();
    final defaultVerticalSpace = Utils.verticalSpace(16);

    return Form(
      key: bloc.createForm,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shrinkWrap: true,
        children: [
          const CustomTextStyle(
            text: 'Property Information',
            color: primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          ),
          defaultVerticalSpace,
          const PropertyTypeWidget(),
          defaultVerticalSpace,
          const RentPeriodWidget(),
          defaultVerticalSpace,
          // const UpdatePurposeSection(),
          //defaultVerticalSpace,
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
                    onChanged: (value) =>
                        bloc.add(PropertyTitleEvent(title: value)),
                    decoration: const InputDecoration(
                        hintText: 'Title *',
                        labelText: 'Title *',
                        hintStyle: TextStyle(color: Colors.black38),
                        labelStyle: TextStyle(
                          color: Colors.black38,
                        )),
                    keyboardType: TextInputType.text,
                  ),
                  if (stateStatus is PropertyUpdateInvalidError) ...[
                    if (stateStatus.errors.title.isNotEmpty)
                      ErrorText(text: stateStatus.errors.title.first)
                  ]
                ],
              );
            },
          ),
          defaultVerticalSpace,
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
                    onChanged: (value) =>
                        bloc.add(PropertySlugEvent(slug: value)),
                    decoration: const InputDecoration(
                        hintText: 'Slug *',
                        labelText: 'Slug *',
                        hintStyle: TextStyle(color: Colors.black38),
                        labelStyle: TextStyle(
                          color: Colors.black38,
                        )),
                    keyboardType: TextInputType.text,
                  ),
                  if (stateStatus is PropertyUpdateInvalidError) ...[
                    if (stateStatus.errors.slug.isNotEmpty)
                      ErrorText(text: stateStatus.errors.slug.first)
                  ]
                ],
              );
            },
          ),
          defaultVerticalSpace,
          Row(
            children: [
              Expanded(
                child: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                  // buildWhen: (previous, current) =>
                  //     previous.price != current.price,
                  builder: (context, state) {
                    return TextFormField(
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
                    );
                  },
                ),
              ),
              Utils.horizontalSpace(8),
              Expanded(
                child: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                  builder: (context, state) {
                    return TextFormField(
                      initialValue: state.totalArea,
                      onChanged: (value) =>
                          bloc.add(PropertyTotalAreaEvent(totalArea: value)),
                      decoration: const InputDecoration(
                          hintText: 'Total Area *',
                          labelText: 'Total Area *',
                          hintStyle: TextStyle(color: Colors.black38),
                          labelStyle: TextStyle(
                            color: Colors.black38,
                          )),
                      keyboardType: TextInputType.text,
                    );
                  },
                ),
              ),
            ],
          ),
          defaultVerticalSpace,
          Row(
            children: [
              Expanded(
                child: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                  builder: (context, state) {
                    return TextFormField(
                      initialValue: state.totalUnit,
                      onChanged: (value) =>
                          bloc.add(PropertyTotalUnitEvent(totalUnit: value)),
                      decoration: const InputDecoration(
                          hintText: 'Total Unit *',
                          labelText: 'Total Unit *',
                          hintStyle: TextStyle(color: Colors.black38),
                          labelStyle: TextStyle(
                            color: Colors.black38,
                          )),
                      keyboardType: TextInputType.text,
                    );
                  },
                ),
              ),
              Utils.horizontalSpace(8),
              Expanded(
                child: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                  builder: (context, state) {
                    return TextFormField(
                      initialValue: state.totalBedroom,
                      onChanged: (value) => bloc
                          .add(PropertyTotalBedroomEvent(totalBedroom: value)),
                      decoration: const InputDecoration(
                          hintText: 'Total Bedroom *',
                          labelText: 'Total Bedroom *',
                          hintStyle: TextStyle(color: Colors.black38),
                          labelStyle: TextStyle(
                            color: Colors.black38,
                          )),
                      keyboardType: TextInputType.text,
                    );
                  },
                ),
              ),
            ],
          ),
          defaultVerticalSpace,
          Row(
            children: [
              Expanded(
                child: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                  builder: (context, state) {
                    return TextFormField(
                      initialValue: state.totalGarage,
                      onChanged: (value) => bloc
                          .add(PropertyTotalGarageEvent(totalGarage: value)),
                      decoration: const InputDecoration(
                          hintText: 'Total Garage *',
                          labelText: 'Total Garage *',
                          hintStyle: TextStyle(color: Colors.black38),
                          labelStyle: TextStyle(
                            color: Colors.black38,
                          )),
                      keyboardType: TextInputType.text,
                    );
                  },
                ),
              ),
              Utils.horizontalSpace(8),
              Expanded(
                child: BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                  builder: (context, state) {
                    return TextFormField(
                      initialValue: state.totalBathroom,
                      onChanged: (value) => bloc.add(
                          PropertyTotalBathroomEvent(totalBathroom: value)),
                      decoration: const InputDecoration(
                          hintText: 'Total Bathroom *',
                          labelText: 'Total Bathroom *',
                          hintStyle: TextStyle(color: Colors.black38),
                          labelStyle: TextStyle(
                            color: Colors.black38,
                          )),
                      keyboardType: TextInputType.text,
                    );
                  },
                ),
              ),
            ],
          ),
          defaultVerticalSpace,
          BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
            builder: (context, state) {
              return TextFormField(
                initialValue: state.totalKitchen,
                onChanged: (value) =>
                    bloc.add(PropertyTotalKitchenEvent(totalKitchen: value)),
                decoration: const InputDecoration(
                    hintText: 'Total Kitchen *',
                    labelText: 'Total Kitchen *',
                    hintStyle: TextStyle(color: Colors.black38),
                    labelStyle: TextStyle(
                      color: Colors.black38,
                    )),
                keyboardType: TextInputType.text,
              );
            },
          ),
          defaultVerticalSpace,
          BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
            builder: (context, state) {
              return TextFormField(
                initialValue: state.description,
                onChanged: (value) =>
                    bloc.add(PropertyDescriptionEvent(description: value)),
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
                keyboardType: TextInputType.text,
                maxLines: 5,
              );
            },
          ),
          defaultVerticalSpace,
          const PropertyImageSection(),
          defaultVerticalSpace,
          const PropertyVideoWidget(),
          defaultVerticalSpace,
          const LocationWidget(),
          defaultVerticalSpace,
          const AminitiesWidget(),
          defaultVerticalSpace,
          const NearestWidget(),
          defaultVerticalSpace,
          const AdditionalWidget(),
          defaultVerticalSpace,
          const PlanWidget(),
          defaultVerticalSpace,
          const SeoWidget(),
          Utils.verticalSpace(50),
        ],
      ),
    );
  }
}
