import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:real_estate/data/data_provider/remote_url.dart';
import 'package:real_estate/logic/cubit/home/cubit/property_details_cubit.dart';
import 'package:real_estate/presentation/utils/utils.dart';
import 'package:real_estate/presentation/widget/empty_widget.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../widget/custom_images.dart';
import '../../../../widget/custom_test_style.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<PropertyDetailsCubit, PropertyDetailsState>(
      builder: (context, state) {
        if (state is PropertyDetailsLoaded) {
          final review = state.singlePropertyModel.reviews;
          if (review!.isNotEmpty) {
            return ListView.builder(
                itemCount: review!.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 20.0),
                itemBuilder: (context, index) {
                  final item = review[index];
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 20.0),
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    decoration: BoxDecoration(
                      color: borderColor,
                      borderRadius: borderRadius,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: List.generate(
                                item.rating,
                                (index) => const Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: CustomImage(path: KImages.starIcon),
                                ),
                              ),
                            ),
                            CustomTextStyle(
                              text: Utils.convertToAgo(item.createdAt),
                              //text: Utils.timeAgo(item.createdAt),
                              color: primaryColor,
                              fontSize: 16.0,
                            )
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        ReadMoreText(
                          item.review,
                          trimLines: 1,
                          trimLength: 60,
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
                          textAlign: TextAlign.start,
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
                                path: RemoteUrls.imageUrl(item.user!.image),
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
                                  text: item.user!.name,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  color: blackColor,
                                ),
                                CustomTextStyle(
                                  text: item.user!.designation,
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
                });
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: Center(
                child: EmptyWidget(
                    icon: KImages.emptyReview, title: 'No Review Found!'),
              ),
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
