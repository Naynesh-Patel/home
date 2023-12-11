import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/model/create_property/property_location.dart';

import '../../../../data/model/create_property/cities_model.dart';
import '../../../../logic/bloc/create_property/bloc/property_create_bloc.dart';
import '../../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/error_text.dart';
import '../../../widget/form_header_title.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PropertyCreateBloc>();
    final cubit = context.read<CreateInfoCubit>();
    CitiesModel? citiesModel;
    int id = 0;
    String address = '';
    String details = '';
    String map = '';
    return BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
      builder: (context, state) {
        citiesModel = cubit.createPropertyInfo.cities.first;
        if (state.propertyLocationDto.cityId != 0) {
          id = state.propertyLocationDto.cityId;
          address = state.propertyLocationDto.address;
          details = state.propertyLocationDto.addressDescription;
          map = state.propertyLocationDto.googleMap;

          citiesModel = cubit.createPropertyInfo.cities
              .where((element) => element.id == id)
              .first;
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
              const FormHeaderTitle(title: "Property Location"),
              Utils.verticalSpace(14.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                      builder: (context, state) {
                        final stateStatus = state.state;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownButtonFormField<CitiesModel>(
                              isDense: true,
                              isExpanded: true,
                              value: citiesModel,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: borderColor,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                ),
                              ),
                              hint: const CustomTextStyle(
                                text: 'City',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down_sharp,
                                  color: blackColor),
                              items: cubit.createPropertyInfo!.cities
                                  .map<DropdownMenuItem<CitiesModel>>(
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
                                id = val!.id;
                                bloc.add(PropertyPropertyLocationEvent(
                                    propertyLocation: PropertyLocationDto(
                                      cityId: id,
                                      address: address,
                                      addressDescription: details,
                                      googleMap: map,
                                    )));
                              },
                            ),
                            if (stateStatus is PropertyCreateInvalidError) ...[
                              if (stateStatus.errors.cityId.isNotEmpty)
                                ErrorText(text: stateStatus.errors.cityId.first)
                            ]
                          ],
                        );
                      },
                    ),

                    Utils.verticalSpace(16),
                    BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                      builder: (context, state) {
                        final stateStatus = state.state;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: state.propertyLocationDto.address,
                              onChanged: (value) {
                                address = value;
                                bloc.add(PropertyPropertyLocationEvent(
                                    propertyLocation: PropertyLocationDto(
                                      cityId: id,
                                      address: address,
                                      addressDescription: details,
                                      googleMap: map,
                                    )));
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Address *',
                                  labelText: 'Address *',
                                  hintStyle: TextStyle(color: Colors.black38),
                                  labelStyle: TextStyle(
                                    color: Colors.black38,
                                  )),
                              keyboardType: TextInputType.text,
                            ),
                            if (stateStatus is PropertyCreateInvalidError) ...[
                              if (stateStatus.errors.address.isNotEmpty)
                                ErrorText(text: stateStatus.errors.address.first)
                            ]
                          ],
                        );
                      },
                    ),

                    Utils.verticalSpace(16),
                    BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                      builder: (context, state) {
                        final stateStatus = state.state;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        TextFormField(
                        initialValue:
                        state.propertyLocationDto.addressDescription,
                          onChanged: (value) {
                            details = value;

                            bloc.add(PropertyPropertyLocationEvent(
                                propertyLocation: PropertyLocationDto(
                                  cityId: id,
                                  address: address,
                                  addressDescription: details,
                                  googleMap: map,
                                )));
                          },
                          decoration: const InputDecoration(
                              hintText: 'Details *',
                              labelText: 'Details *',
                              hintStyle: TextStyle(color: Colors.black38),
                              labelStyle: TextStyle(
                                color: Colors.black38,
                              )),
                          keyboardType: TextInputType.text,
                        ),
                            if (stateStatus is PropertyCreateInvalidError) ...[
                              if (stateStatus.errors.addressDescription.isNotEmpty)
                                ErrorText(text: stateStatus.errors.addressDescription.first)
                            ]
                          ],
                        );
                      },
                    ),

                    Utils.verticalSpace(16),
                    BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                      builder: (context, state) {
                        final stateStatus = state.state;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: state.propertyLocationDto.googleMap,
                              onChanged: (value) {
                                map = value;
                                bloc.add(PropertyPropertyLocationEvent(
                                    propertyLocation: PropertyLocationDto(
                                      cityId: id,
                                      address: address,
                                      addressDescription: details,
                                      googleMap: map,
                                    )));
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Google Map *',
                                  labelText: 'Google Map *',
                                  hintStyle: TextStyle(color: Colors.black38),
                                  labelStyle: TextStyle(
                                    color: Colors.black38,
                                  )),
                              keyboardType: TextInputType.text,
                            ),
                            if (stateStatus is PropertyCreateInvalidError) ...[
                              if (stateStatus.errors.googleMap.isNotEmpty)
                                ErrorText(text: stateStatus.errors.googleMap.first)
                            ]
                          ],
                        );
                      },
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
}
