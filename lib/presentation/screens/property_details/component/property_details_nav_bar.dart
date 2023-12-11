import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../logic/cubit/home/cubit/property_details_cubit.dart';
import '../../../router/route_names.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/contact_button.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/primary_button.dart';

class PropertyDetailNavBar extends StatelessWidget {
  const PropertyDetailNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<PropertyDetailsCubit, PropertyDetailsState>(
      builder: (context, state) {
        if (state is PropertyDetailsLoaded) {
          final agent = state.singlePropertyModel.propertyAgent;
          return Container(
            width: size.width,
            height: size.height * 0.3,
            padding: const EdgeInsets.only(bottom: 10.0),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: CustomImage(
                          path: RemoteUrls.imageUrl(agent!.image),
                          height: size.height * 0.08,
                          width: size.height * 0.08,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextStyle(
                            text: agent.name,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          ),
                          CustomTextStyle(
                            text: agent.designation,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: whiteColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 0.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ContactButton(
                      onPressed: () => Navigator.pushNamed(
                          context, RouteNames.sendMessageScreen,
                          arguments: agent.email),
                      bgColor: yellowColor,
                      text: 'Message',
                      icon: KImages.messageIcon,
                      iconTextColor: blackColor,
                    ),
                    ContactButton(
                      onPressed: () async {
                        Uri uri = Uri(
                            scheme: 'mailto',
                            path: agent.email,
                            queryParameters: {'subject': 'Example'});
                        try {
                          if (agent.email.isNotEmpty) {
                            await launchUrl(uri);
                            print(uri);
                          } else {
                            Utils.showSnackBar(context, 'Email is Empty');
                          }
                        } catch (e) {
                          Utils.showSnackBar(context, e.toString());
                        }
                      },
                      bgColor: blackColor,
                      text: 'Email',
                      icon: KImages.emailIcon,
                      iconTextColor: whiteColor,
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  messageDialog(BuildContext context) {
    const spacer = SizedBox(height: 12.0);
    Utils.showCustomDialog(
      context,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTextStyle(
                    text: 'Write Message',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: blackColor,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const CustomImage(path: KImages.cancelIcon))
                ],
              ),
              const SizedBox(height: 14.0),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                keyboardType: TextInputType.name,
              ),
              spacer,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              spacer,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              spacer,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
              ),
              const SizedBox(height: 20.0),
              PrimaryButton(
                  text: 'Send Message',
                  onPressed: () => Navigator.of(context).pop(),
                  textColor: blackColor,
                  fontSize: 20.0,
                  borderRadiusSize: radius,
                  bgColor: yellowColor)
            ],
          ),
        ),
      ),
    );
  }
}
