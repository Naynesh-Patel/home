import 'package:flutter/material.dart';

import '../../../../data/model/category/home_category_model.dart';
import '../../../router/route_names.dart';
import 'headline_text.dart';
import 'single_category_circle.dart';

class HorizontalCategoryView extends StatelessWidget {
  const HorizontalCategoryView({Key? key, required this.category})
      : super(key: key);
  final HomeCategory category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadlineText(
          text: 'All Category',
          onTap: () =>
              Navigator.pushNamed(context, RouteNames.allCategoryScreen),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              category.propertyTypes.length > 5
                  ? 5
                  : category.propertyTypes.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? 10.0 : 0.0,
                    right: index == category.propertyTypes.length - 1
                        ? 10.0
                        : 0.0),
                child: GestureDetector(
                  onTap: () {
                    final type = category.propertyTypes[index].name
                        .replaceAll(' ', '-')
                        .toLowerCase();
                    print(type);
                    Navigator.pushNamed(
                        context, RouteNames.filterPropertyScreen,
                        arguments: type);
                  },
                  child: SingleCategoryCircle(
                      category: category.propertyTypes[index]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
