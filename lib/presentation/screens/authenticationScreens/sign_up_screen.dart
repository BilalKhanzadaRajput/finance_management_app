import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/helper/extension/strings_extensions.dart';
import 'package:fm_app/presentation/routes/routes_name.dart';

import '../../../businessLogic/bloc/signUpScreenBloc/sign_up_screen_bloc.dart';
import '../../../helper/constants/colors_resource.dart';
import '../../../helper/constants/dimensions_resource.dart';
import '../../../helper/constants/image_resources.dart';
import '../../../helper/constants/screen_percentage.dart';
import '../../../helper/constants/string_resources.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: BlocBuilder<SignUpScreenBloc, SignUpScreenState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4849BF),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenPercentage.SCREEN_SIZE_5.sw),
                          child: Image(
                            image:
                                const AssetImage(ImageResources.APP_LOGO_IMAGE),
                            width: Dimensions.D_150.w,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.D_15.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE
                              .h, // Adjusted vertical padding
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE.w,
                        ),
                        child: Text(
                          StringResources.SIGNUP_HEADING,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                  fontSize:
                                      Dimensions.FONT_SIZE_EXTRA_LARGE.sp),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                            child: CustomTextFormField(
                              hintText: StringResources.FULL_NAME_HINT,
                              onChanged: (value) {
                                context
                                    .read<SignUpScreenBloc>()
                                    .add(SignUpFullNameChanged(value));
                              },
                              validator: (value) =>
                                  value.isEmpty ? "Enter your full name" : null,
                              prefixIconSvgPath: ImageResources.USER_ICON,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                            child: CustomTextFormField(
                              hintText: StringResources.EMAIL_HINT,
                              onChanged: (value) {
                                context
                                    .read<SignUpScreenBloc>()
                                    .add(SignUpEmailChanged(value));
                              },
                              validator: (value) =>
                                  value.validatePassword(value),
                              prefixIconSvgPath: ImageResources.USER_ICON,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                            child: CustomTextFormField(
                              hintText: StringResources.PHONE_HINT,
                              onChanged: (value) {
                                context
                                    .read<SignUpScreenBloc>()
                                    .add(SignUpPhoneChanged(value));
                              },
                              validator: (value) =>
                                  value.validatePhoneNumber(value),
                              prefixIconSvgPath: ImageResources.PHONE_ICON,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                            child: CustomTextFormField(
                              hintText: StringResources.PASSWORD_HINT,
                              obscureText: !state.passwordVisibility,
                              onChanged: (value) {
                                context
                                    .read<SignUpScreenBloc>()
                                    .add(SignUpPasswordChanged(value));
                              },
                              validator: (value) =>
                                  value.validatePassword(value),
                              prefixIconSvgPath: ImageResources.LOCK_ICON,
                              showSuffixIcon: true,
                              onVisibilityTap: () {
                                context
                                    .read<SignUpScreenBloc>()
                                    .add(const PasswordVisibility());
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                            child: CustomTextFormField(
                              hintText: StringResources.CONFIRM_PASSWORD_HINT,
                              obscureText: !state.passwordVisibility,
                              onChanged: (value) {
                                context
                                    .read<SignUpScreenBloc>()
                                    .add(SignUpConfirmPasswordChanged(value));
                              },
                              validator: (value) =>
                                  value.validateConfirmPassword(value),
                              prefixIconSvgPath: ImageResources.LOCK_ICON,
                              showSuffixIcon: true,
                              onVisibilityTap: () {
                                context
                                    .read<SignUpScreenBloc>()
                                    .add(const PasswordVisibility());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.PADDING_SIZE_DEFAULT.h,
                          ),
                      child: BlocListener<SignUpScreenBloc, SignUpScreenState>(
                        listener: (context, state) {
                          if (state.isSubmitting) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state.isSubmitted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutesName.HOME_SCREEN,
                              (Route<dynamic> route) => false,
                            );
                          } else if (state.submissionFailed) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.errorMessage),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          // Added padding for the button
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE.w,
                              vertical: Dimensions.PADDING_SIZE_DEFAULT
                                  .h), // Adjust the vertical padding as needed
                          child: CustomElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<SignUpScreenBloc>()
                                    .add(const SignUpSubmit());
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please correct the errors in the form'),
                                  ),
                                );
                              }
                            },
                            text: StringResources.SIGNUP_BUTTON_TEXT,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
