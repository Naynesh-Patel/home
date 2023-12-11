import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/presentation/utils/utils.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/utils/k_images.dart';
import '../../../../presentation/widget/custom_images.dart';
import '../../../../presentation/widget/primary_button.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../logic/cubit/forgot_password/forgot_password_cubit.dart';
import '../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../router/route_names.dart';
import '../../widget/error_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  TextStyle textStyle() {
    return GoogleFonts.poppins(
        fontWeight: FontWeight.w700, fontSize: 24.0, color: whiteColor);
  }

  final spacer = const SizedBox(height: 20.0);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgotPasswordCubit>();
    final size = MediaQuery.of(context).size;
    final appSetting =
        context.read<AppSettingCubit>().settingModel!.mobileAppContent;
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordStateError) {
          Utils.errorSnackBar(context, state.errorMsg);
        } else if (state is ForgotPasswordStateLoaded) {
          Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.verificationScreen,
              arguments: false,
              (route) => false);
          Utils.showSnackBar(context, state.email);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: size.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomImage(
                    path: RemoteUrls.imageUrl(appSetting.loginBgImage) ??
                        KImages.verifyBackgroundImage,
                    fit: BoxFit.cover),
                Positioned.fill(
                  top: size.height * 0.14,
                  // left: size.width * 0.05,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Forget Password',
                          style: textStyle(),
                        ),
                        SizedBox(height: size.height * 0.04),
                        BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                          builder: (context, state) {
                            // ForgotPasswordFormValidateError
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: bloc.emailController,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          credentialIcon(KImages.emailIcon),
                                      hintText: "Emails"),
                                ),
                                if (state
                                    is ForgotPasswordFormValidateError) ...[
                                  if (state.errors.email.isNotEmpty)
                                    ErrorText(text: state.errors.email.first)
                                ]
                              ],
                            );
                          },
                        ),
                        spacer,
                        const SizedBox(height: 10.0),
                        BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                            builder: (context, state) {
                          if (state is ForgotPasswordStateLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return PrimaryButton(
                            onPressed: () {
                              Utils.closeKeyBoard(context);
                              bloc.forgotPassWord();
                            },
                            text: 'Send Code',
                            borderRadiusSize: 5.0,
                          );
                        }),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       "Don't get any Code? ",
                        //       style: GoogleFonts.poppins(
                        //         fontWeight: FontWeight.w600,
                        //         fontSize: 17.0,
                        //         color: whiteColor,
                        //       ),
                        //     ),
                        //     Text(
                        //       'Resend',
                        //       style: GoogleFonts.poppins(
                        //         fontWeight: FontWeight.w600,
                        //         fontSize: 17.0,
                        //         color: yellowColor,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.03,
                  right: size.width * 0.05,
                  child: Utils.defaultIcon(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
