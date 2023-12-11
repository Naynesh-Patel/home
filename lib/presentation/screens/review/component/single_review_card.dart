import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:real_estate/data/data_provider/remote_url.dart';

import '/logic/bloc/login/login_bloc.dart';
import '../../../../data/model/review/review_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';

class SingleReviewCard extends StatelessWidget {
  const SingleReviewCard({Key? key, required this.review}) : super(key: key);
  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = context.read<LoginBloc>().userInfo!.user;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              review.rating,
              (index) => const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: CustomImage(path: KImages.starIcon),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          ReadMoreText(
            review.review,
            trimLines: 1,
            trimLength: 100,
            trimExpandedText: 'Show Less',
            trimCollapsedText: 'Show More',
            moreStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: primaryColor,
            ),
            lessStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: primaryColor,
            ),
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: grayColor,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              ClipOval(
                child: CustomImage(
                  //path: KImages.profilePicture,
                  path: RemoteUrls.imageUrl(review.property!.thumbnailImage),
                  height: size.height * 0.06,
                  width: size.height * 0.06,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextStyle(
                    text: user.name,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: blackColor,
                  ),
                  CustomTextStyle(
                    text: user.designation,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                    color: grayColor,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
