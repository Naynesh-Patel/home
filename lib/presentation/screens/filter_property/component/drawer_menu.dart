import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/logic/cubit/setting/app_setting_cubit.dart';
import '/presentation/utils/constraints.dart';
import '/presentation/widget/custom_test_style.dart';
import '/presentation/widget/primary_button.dart';
import '../../../../data/model/filter/filter_property_list_model.dart';
import '../../../../logic/cubit/filter_property/filter_property_cubit.dart';
import '../../../utils/utils.dart';
import 'area_section.dart';
import 'bath_room_section.dart';
import 'bed_room_section.dart';
import 'location_section.dart';
import 'price_section.dart';
import 'property_type_section.dart';
import 'purpose_section.dart';

class DrawerFilter extends StatefulWidget {
  const DrawerFilter({Key? key, required this.propertyList}) : super(key: key);
  final FilterPropertyListModel propertyList;

  @override
  State<DrawerFilter> createState() => _DrawerFilterState();
}

class _DrawerFilterState extends State<DrawerFilter> {
  Widget headingText(String text) {
    return CustomTextStyle(
      text: text,
      fontSize: 20.0,
    );
  }

  //final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final icon =
        context.read<AppSettingCubit>().settingModel!.setting.currencyIcon;
    final filterCubit = context.read<FilterPropertyCubit>();
    //print(icon);
    return SafeArea(
      child: Drawer(
        backgroundColor: whiteColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    IconButton(
                        onPressed: () => Scaffold.of(context).closeEndDrawer(),
                        icon: const Icon(Icons.clear,
                            size: 28.0, color: redColor)),
                  ],
                ),
                Utils.verticalSpace(10.0),
                const PurposeSection(),
                Utils.verticalSpace(20.0),
                LocationSection(location: widget.propertyList.location!),
                Utils.verticalSpace(20.0),
                PropertyTypeSection(
                    propertyType: widget.propertyList.propertyType!),
                Utils.verticalSpace(20.0),
                headingText('Bed Rooms'),
                const SizedBox(height: 10.0),
                BedRoomSection(totalBedRoom: widget.propertyList.maxBedRooms),
                Utils.verticalSpace(20.0),
                headingText('Bath Rooms'),
                const SizedBox(height: 10.0),
                BathRoomSection(
                    totalBathRoom: widget.propertyList.maxBathRooms),
                headingText('Area'),
                AreaSection(totalArea: widget.propertyList.maxArea),
                headingText('Price'),
                PriceSection(totalPrice: widget.propertyList.maxPrice),
                Utils.verticalSpace(20.0),
                PrimaryButton(
                    text: 'Search',
                    onPressed: () {
                      Scaffold.of(context).closeEndDrawer();
                      filterCubit.getFilterProperty();
                      filterCubit.clear();
                      // filterCubit.roomChange([]);
                      // filterCubit.bathRoomChange([]);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
