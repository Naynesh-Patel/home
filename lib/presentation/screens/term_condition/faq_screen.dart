import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/data_provider/remote_url.dart';
import '/presentation/widget/custom_images.dart';
import '../../../../presentation/widget/custom_rounded_app_bar.dart';
import '../../../data/model/privacy/faq_model/faq_model.dart';
import '../../../logic/cubit/privacy_policy/privacy_policy_cubit.dart';
import '../../utils/constraints.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/loading_widget.dart';
import 'component/single_expansion.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final privacyCubit = context.read<PrivacyPolicyCubit>();
    privacyCubit.getFaqContent();
    return Scaffold(
      appBar: CustomRoundedAppBar(
        text: privacyCubit.faqContent!.content!.shortTitle,
      ),
      body: BlocBuilder<PrivacyPolicyCubit, PrivacyPolicyState>(
        builder: (context, state) {
          if (state is PrivacyPolicyLoading) {
            return const LoadingWidget();
          } else if (state is PrivacyPolicyError) {
            if (state.statusCode == 503) {
              return LoadedFaqContent(faqs: privacyCubit.faqContent!);
            } else {
              return Center(
                child: CustomTextStyle(
                  text: state.message,
                  color: redColor,
                  fontSize: 20.0,
                ),
              );
            }
          } else if (state is FaqContentLoaded) {
            return LoadedFaqContent(faqs: state.faqContent);
          }
          return const Center(
              child: CustomTextStyle(text: 'Something went wrong'));
        },
      ),
    );
  }
}

class LoadedFaqContent extends StatelessWidget {
  const LoadedFaqContent({Key? key, required this.faqs}) : super(key: key);
  final FaqModel faqs;

  @override
  Widget build(BuildContext context) {
    final content = faqs.content;
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
          child: Column(
            children: [
              CustomTextStyle(
                text: content!.supportTitle,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
              CustomTextStyle(
                text: content.supportTime,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        CustomImage(path: RemoteUrls.imageUrl(content.supportImage)),
        const SizedBox(height: 16.0),
        CustomTextStyle(
          text: content.longTitle,
          textAlign: TextAlign.center,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          itemCount: faqs.faqs!.length,
          itemBuilder: (context, index) => SingleExpansionTile(
            faqContent: faqs.faqs![index],
            isExpand: index == 0 ? true : false,
          ),
        ),
      ],
    );
  }
}
