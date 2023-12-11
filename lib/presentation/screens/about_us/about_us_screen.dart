import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/logic/cubit/review/review_cubit.dart';
import '../../../data/model/about_us/about_us_model.dart';
import '../../../logic/cubit/about_us/about_us_cubit.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../widget/custom_rounded_app_bar.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/loading_widget.dart';
import '../home/component/fun_fact_section.dart';
import 'component/customer_feedback.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  final space = const SizedBox(height: 20.0);

  @override
  Widget build(BuildContext context) {
    final aboutUsCubit = context.read<AboutUsCubit>();
    //aboutUsCubit.getAboutUs();
    final list = [
      KImages.aboutUsImage01,
      KImages.aboutUsImage02,
    ];
    return Scaffold(
      appBar:
          CustomRoundedAppBar(text: aboutUsCubit.aboutUs!.seoSetting!.pageName),
      body: BlocBuilder<AboutUsCubit, AboutUsState>(
        builder: (context, state) {
          if (state is AboutUsLoading) {
            return const LoadingWidget();
          } else if (state is AboutUsError) {
            if (state.statusCode == 503) {
              return AboutUsLoadedWidget(aboutUs: aboutUsCubit.aboutUs!);
            } else {
              return Center(
                child: CustomTextStyle(
                    text: state.message, color: redColor, fontSize: 20.0),
              );
            }
          } else if (state is AboutUsLoaded) {
            return AboutUsLoadedWidget(aboutUs: state.aboutUs);
          }
          return const Center(
              child: CustomTextStyle(text: 'Something went wrong'));
        },
      ),
    );
  }
}

class AboutUsLoadedWidget extends StatelessWidget {
  const AboutUsLoadedWidget({Key? key, required this.aboutUs})
      : super(key: key);
  final AboutUsModel aboutUs;

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 20.0);
    final reviewCubit = context.read<ReviewCubit>();
    print('reviewsss ${reviewCubit.reviews.length}');
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              space,
              CustomTextStyle(
                text: aboutUs.aboutUs!.shortTitle,
                fontSize: 18.0,
                color: blackColor,
                fontWeight: FontWeight.w600,
              ),
              Text(
                aboutUs.aboutUs!.description1,
                textAlign: TextAlign.justify,
                style: GoogleFonts.dmSans(
                  fontSize: 14.0,
                  color: grayColor,
                  height: 1.8,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                aboutUs.aboutUs!.description2,
                textAlign: TextAlign.justify,
                style: GoogleFonts.dmSans(
                  fontSize: 14.0,
                  color: grayColor,
                  height: 1.8,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        FunFactSection(counter: aboutUs.counter!),
        space,
        Visibility(
            visible: reviewCubit.reviews.isNotEmpty,
            child: const CustomerFeedback()),
        const SizedBox(height: 40.0),
      ],
    );
  }
}
