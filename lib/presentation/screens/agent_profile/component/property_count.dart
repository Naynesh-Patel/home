import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/agent/agent_details_model.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_test_style.dart';

class PropertyCount extends StatelessWidget {
  const PropertyCount({Key? key, required this.propertyCount})
      : super(key: key);
  final AgentDetailsModel propertyCount;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<Map<String, String>> propertyList = [
      {
        "number": propertyCount.totalProperty.toString(),
        "title": 'Total Property'
      },
      {"number": propertyCount.totalReview.toString(), "title": 'Total Review'},
      // {"number": '40', "title": 'Apartment'},
    ];
    return Container(
      height: 70.0,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0)
          .copyWith(top: 0.0),
      child: DottedBorder(
        color: primaryColor,
        dashPattern: const [6, 3],
        strokeCap: StrokeCap.square,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            propertyList.length,
            (index) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextStyle(
                    text: propertyList[index]['number']!.padLeft(2, '0'),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: blackColor),
                const SizedBox(height: 5.0),
                CustomTextStyle(
                    text: propertyList[index]['title']!,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: grayColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
