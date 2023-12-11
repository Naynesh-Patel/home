import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/presentation/utils/utils.dart';
import '../../../../logic/bloc/login/login_bloc.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/utils/k_images.dart';
import '../../../../presentation/widget/custom_images.dart';
import '../../../../presentation/widget/custom_test_style.dart';
import '../../../../presentation/widget/primary_button.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../router/route_names.dart';
import '../../widget/error_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String subTitle =
      "I am happy to see you again\nContinue when you left off by login in";
  bool isShow = true;

  void showPassword() {
    setState(() {
      isShow = !isShow;
    });
  }

  final spacer = const SizedBox(height: 20.0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginBloc = context.read<LoginBloc>();
    final appSetting =
        context.read<AppSettingCubit>().settingModel!.mobileAppContent;
    //print(appSetting.loginBgImage);
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginModelState>(
          listenWhen: (previous, current) => previous.state != current.state,
          listener: (context, state) {
            if (state.state is LoginStateError) {
              final status = state.state as LoginStateError;

              if (status.statusCode == 402) {
                Utils.showSnackBarWithAction(
                  context,
                  status.errorMsg,
                  () {
                    // context
                    //     .read<LoginBloc>()
                    //     .add(const SentAccountActivateCodeSubmit());
                    // Navigator.pushNamed(
                    //     context, RouteNames.verificationCodeScreen);
                  },
                );
              } else {
                Utils.errorSnackBar(context, status.errorMsg);
              }
            } else if (state.state is LoginStateLoaded) {
              Navigator.pushReplacementNamed(
                  context, RouteNames.mainPageScreen);
            } else if (state.state is SendAccountCodeSuccess) {
              final messageState = state.state as SendAccountCodeSuccess;
              Utils.showSnackBar(context, messageState.msg);
            }
          },
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomImage(
                  path: RemoteUrls.imageUrl(appSetting.loginBgImage) ??
                      KImages.loginBackgroundImage,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  top: size.height * 0.14,
                  // left: size.width * 0.05,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextStyle(
                          text: 'Welcome Back!',
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                          color: whiteColor,
                        ),
                        const SizedBox(height: 5.0),
                        CustomTextStyle(
                          text: subTitle,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          height: 1.8,
                          color: whiteColor,
                        ),
                        SizedBox(height: size.height * 0.04),
                        BlocBuilder<LoginBloc, LoginModelState>(
                          builder: (context, state) {
                            final login = state.state;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  initialValue: state.text,
                                  onChanged: (value) => loginBloc
                                      .add(LoginEvenEmailOrPhone(value)),
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        credentialIcon(KImages.emailIcon),
                                    hintText: 'your email address',
                                  ),
                                ),
                                if (login is LoginStateFormInvalid) ...[
                                  if (login.error.email.isNotEmpty)
                                    ErrorText(text: login.error.email.first)
                                ]
                              ],
                            );
                          },
                        ),
                        spacer,
                        BlocBuilder<LoginBloc, LoginModelState>(
                          builder: (context, state) {
                            final login = state.state;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  initialValue: state.password,
                                  onChanged: (value) =>
                                      loginBloc.add(LoginEventPassword(value)),
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        credentialIcon(KImages.lockIcon),
                                    hintText: 'your password',
                                    suffixIcon: IconButton(
                                      splashRadius: 20.0,
                                      onPressed: showPassword,
                                      icon: Icon(
                                        isShow
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: grayColor,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                  obscureText: isShow,
                                ),
                                if (state.text.isNotEmpty)
                                  if (login is LoginStateFormInvalid) ...[
                                    if (login.error.password.isNotEmpty)
                                      ErrorText(
                                          text: login.error.password.first)
                                  ]
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, RouteNames.forgotPasswordScreen),
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor,
                                    decoration: TextDecoration.underline,
                                    fontSize: 15.0),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        BlocBuilder<LoginBloc, LoginModelState>(
                          buildWhen: (previous, current) =>
                              previous.state != current.state,
                          builder: (context, state) {
                            if (state.state is LoginStateLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return PrimaryButton(
                              onPressed: () {
                                Utils.closeKeyBoard(context);
                                loginBloc.add(const LoginEventSubmit());
                              },
                              text: 'Login',
                              borderRadiusSize: 5.0,
                            );
                          },
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomTextStyle(
                              text: "Don't have an account? ",
                              fontWeight: FontWeight.w600,
                              fontSize: 17.0,
                              color: whiteColor,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, RouteNames.signUpScreen),
                              child: const CustomTextStyle(
                                text: 'Sign Up',
                                fontWeight: FontWeight.w600,
                                fontSize: 17.0,
                                color: yellowColor,
                              ),
                            ),
                          ],
                        ),
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
