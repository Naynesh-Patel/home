import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/presentation/utils/utils.dart';
import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/product/property_item_model.dart';
import '../../../../logic/bloc/create_property/bloc/property_create_bloc.dart';
import '../../../../logic/cubit/create_property/cubit/update_cubit.dart';
import '../../../router/route_names.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/favorite_button.dart';

class PersonSingleProperty extends StatelessWidget {
  const PersonSingleProperty({Key? key, required this.properties})
      : super(key: key);
  final List<PropertyItemModel> properties;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: properties.length,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final result = properties[index];
          return GestureDetector(
            onTap: () {
              if (result.status == 'enable') {
                Navigator.pushNamed(context, RouteNames.propertyDetailsScreen,
                    arguments: result.slug);
              } else {
                Utils.showSnackBar(context,
                    "This is not Approved property so you can't see details");
              }
            },
            child: Container(
              height: 200.0.h,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 145.0.h,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: borderRadius,
                            child: Stack(
                              // fit: StackFit.expand,
                              children: [
                                CustomImage(
                                  path: RemoteUrls.imageUrl(
                                      result.thumbnailImage),
                                  height: 140.0,
                                  width: 140.0,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 8.0,
                                  left: 8.0,
                                  child:
                                      FavoriteButton(id: result.id.toString()),
                                )
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomTextStyle(
                                  text: Utils.formatPrice(
                                      context, result.price.toStringAsFixed(2)),
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                ),
                                CustomTextStyle(
                                  text: result.rentPeriod.isNotEmpty
                                      ? '/${result.rentPeriod}'
                                      : result.rentPeriod,
                                  color: grayColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                ),
                              ],
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: 40.0, maxWidth: 190.0),
                              child: CustomTextStyle(
                                text: result.title,
                                color: blackColor,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.left,
                                fontSize: 18.0,
                                maxLine: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                const CustomImage(path: KImages.locationIcon),
                                const SizedBox(width: 6.0),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxHeight: 40.0, maxWidth: 190.0),
                                  child: CustomTextStyle(
                                    text: result.address,
                                    color: grayColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                    maxLine: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            //const SizedBox(height: 4.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, bottom: 10.0, left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // CustomTextStyle(text: 'Status'),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: result.status == 'enable'
                                ? greenColor
                                : Colors.orange,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: CustomTextStyle(
                            text: result.status == 'enable'
                                ? 'Active'
                                : 'Pending',
                            color: whiteColor,
                            fontSize: 16.0,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<PropertyCreateBloc>().add(
                                      PropertyEditInfoEvent(
                                        propertyId: result.id.toString(),
                                      ),
                                    );
                                Navigator.pushNamed(
                                    context, RouteNames.updateScreen,
                                    arguments: result.id);
                              },
                              child: const EditBtn(),
                            ),
                            const SizedBox(width: 16.0),
                            DeleteBtn(
                                id: result.id.toString(),
                                status: result.status),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class EditBtn extends StatelessWidget {
  const EditBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: yellowColor,
        borderRadius: borderRadius,
      ),
      child: const CustomImage(
        path: KImages.editIcon,
      ),
    );
  }
}

class DeleteBtn extends StatelessWidget {
  const DeleteBtn({super.key, required this.id, required this.status});

  final String id;
  final String status;

  @override
  Widget build(BuildContext context) {
    final updateCubit = context.read<UpdateCubit>();
    if (status == 'enable') {}
    return BlocListener<UpdateCubit, UpdateState>(
      listenWhen: (context, state) => status == 'enable',
      listener: (context, state) {
        if (state is DeletePropertyLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (state is PropertyDeleteSuccess) {
            Navigator.of(context).pop();
            Utils.showSnackBar(context, state.message);
          } else if (state is UpdateStateError) {
            Utils.errorSnackBar(context, state.errorMessage);
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          if (status == 'enable') {
            showDialog<void>(
              context: context,
              barrierDismissible: true,
              // false = user must tap button, true = tap outside dialog
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: const CustomTextStyle(
                    text: 'Confirmation',
                    fontWeight: FontWeight.w600,
                    fontSize: 22.0,
                  ),
                  content: const CustomTextStyle(
                    text: 'Do you want to delete this property?',
                    fontSize: 16.0,
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const CustomTextStyle(
                        text: 'Cancel',
                        color: blackColor,
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext)
                            .pop(); // Dismiss alert dialog
                      },
                    ),
                    TextButton(
                      child: const CustomTextStyle(
                        text: 'Delete',
                        color: redColor,
                      ),
                      onPressed: () {
                        updateCubit.deleteProperty(id);
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            Utils.showSnackBar(
                context, "This is not Approved property so you can't Delete");
          }
        },
        child: Container(
          height: 40.0,
          width: 40.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: redColor,
            borderRadius: borderRadius,
          ),
          child: const Icon(
            Icons.delete_outline_outlined,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
