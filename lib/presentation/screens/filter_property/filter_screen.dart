import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/utils/k_images.dart';
import '/presentation/widget/empty_widget.dart';
import '../../../data/model/filter/filter_property_list_model.dart';
import '../../../logic/cubit/filter_property/filter_property_cubit.dart';
import '../../../logic/cubit/filter_property/filter_property_state_model.dart';
import '../../router/route_names.dart';
import '../../utils/constraints.dart';
import '../../widget/custom_images.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/loading_widget.dart';
import 'component/drawer_menu.dart';
import 'component/single_filter_properties.dart';

class FilterPropertyScreen extends StatelessWidget {
  FilterPropertyScreen({Key? key, required this.type}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final String type;

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.read<FilterPropertyCubit>();

    print('filterString: $type');
    if (type.isEmpty) {
      print('empty');
      filterCubit.getAllProperty();
    } else {
      filterCubit.getFilterPropertyByType(type);
      print('not empty');
    }
    //print('lenght: ${filterCubit.property!.propertyType!.length}');

    return Scaffold(
      key: _key,
      endDrawerEnableOpenDragGesture: false,
      appBar: const FilterAppBar(),
      //appBar: const CustomAppBar(title: 'Filter Property'),
      body: BlocBuilder<FilterPropertyCubit, FilterPropertyStateModel>(
        builder: (context, state) {
          final filter = state.filterState;
          if (filter is FilterPropertyLoading) {
            return const LoadingWidget();
          } else if (filter is FilterPropertyError) {
            if (filter.statusCode == 503) {
              return LoadedFilterWidget(filterProperty: filterCubit.property!);
            } else {
              return Center(
                  child:
                      CustomTextStyle(text: filter.message, color: redColor));
            }
          } else if (filter is FilterPropertyLoaded) {
            return LoadedFilterWidget(filterProperty: filter.property);
          }
          return LoadedFilterWidget(filterProperty: filterCubit.property!);
        },
      ),
      endDrawer: DrawerFilter(propertyList: filterCubit.property!),
    );
  }
}

class LoadedFilterWidget extends StatelessWidget {
  const LoadedFilterWidget({Key? key, required this.filterProperty})
      : super(key: key);
  final FilterPropertyListModel filterProperty;

  @override
  Widget build(BuildContext context) {
    final property = filterProperty.properties!.data!;
    if (property.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0)
            .copyWith(bottom: 20.0),
        itemCount: property.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.pushNamed(
              context, RouteNames.propertyDetailsScreen,
              arguments: property[index].slug),
          child: SingleFilterProperties(
            property: property[index],
          ),
        ),
      );
    } else {
      return const Center(
        child:
            EmptyWidget(icon: KImages.emptyFilter, title: 'No Property Found!'),
      );
    }
  }
}

class FilterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FilterAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: scaffoldBackground,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actionsIconTheme:
          const IconThemeData(color: primaryColor, size: 30.0, fill: 0.6),
      actions: const [SizedBox()],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const CircleAvatar(
                  backgroundColor: primaryColor,
                  minRadius: 18.0,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: whiteColor,
                      size: 22.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              const CustomTextStyle(
                text: 'Filter Property',
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ],
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 16.0)),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFFEFC64F)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
              shadowColor: MaterialStateProperty.all(transparent),
              elevation: MaterialStateProperty.all(0.0),
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.all(transparent),
            ),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            label: const CustomTextStyle(
              text: 'Filter',
              color: blackColor,
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
            icon: const CustomImage(
              path: KImages.filterIcon,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
