import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/product/property_plan_model.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';

class SingleFloorStructure extends StatelessWidget {
  const SingleFloorStructure(
      {Key? key, required this.plan, this.isExpand = false})
      : super(key: key);
  final bool isExpand;
  final PropertyPlan plan;

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFE3E3E3);
    return Container(
      width: double.infinity,
      // alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isExpand,
          childrenPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)
                  .copyWith(top: 0.0),
          iconColor: grayColor,
          collapsedIconColor: grayColor,
          title: CustomTextStyle(
              text: plan.title,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: blackColor),
          children: [
            CustomImage(path: RemoteUrls.imageUrl(plan.image)),
            const SizedBox(height: 10.0),
            ReadMoreText(
              plan.description,
              trimLines: 4,
              trimCollapsedText: 'Read More',
              trimExpandedText: 'Show Less',
              trimLength: 180,
              moreStyle: GoogleFonts.poppins(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: primaryColor),
              lessStyle: GoogleFonts.poppins(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: primaryColor),
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                  color: grayColor),
            ),
          ],
        ),
      ),
    );
  }
}
