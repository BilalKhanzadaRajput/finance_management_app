import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fm_app/presentation/customWidgets/custom_snackbar.dart';
import 'package:fm_app/helper/extension/strings_extensions.dart';

import '../../../businessLogic/bloc/loginScreenBloc/login_screen_bloc.dart';
import '../../../helper/constants/colors_resource.dart';
import '../../../helper/constants/dimensions_resource.dart';
import '../../../helper/constants/image_resources.dart';
import '../../../helper/constants/screen_percentage.dart';
import '../../../helper/constants/string_resources.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_text_field.dart';
import '../../routes/routes_name.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: SafeArea(
        child: BlocConsumer<LoginScreenBloc, LoginScreenState>(
          listener: (context, state) {
            if (state.isloading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state.isSuccess) {
              Navigator.pop(context);

              showCustomSnackbar(
                context,
                'Welcome',
                'Login successful. Welcome to Finance Management!',
                ContentType.success,
              );

              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.DASHBOARD_SCREEN,
                (Route<dynamic> route) => false,
              );
            } else if (state.isFailure) {
              Navigator.pop(context);
              showCustomSnackbar(
                context,
                'Error',
                state.errorMessage ?? 'Login failed. Please try again.',
                ContentType.failure,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorResources.PRIMARY_COLOR,
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
                          width: Dimensions.D_200.w,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.D_91.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE.w),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        StringResources.LOGIN_HEADING,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE.sp),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_DEFAULT.w),
                            child: CustomTextFormField(
                              hintText: StringResources.EMAIL_HINT,
                              keyboardType: TextInputType.emailAddress,
                              prefixIconSvgPath: ImageResources.EMAIL_ICON,
                              onChanged: (value) {
                                context
                                    .read<LoginScreenBloc>()
                                    .add(LoginEmailChanged(value));
                              },
                              validator: (value) => value!.validateEmail(value),
                              focusNode: _focusNode,
                            ),
                          ),
                          CustomTextFormField(
                            hintText: StringResources.PASSWORD_HINT,
                            prefixIconSvgPath: ImageResources.LOCK_ICON,
                            showSuffixIcon: true,
                            onVisibilityTap: () {
                              context
                                  .read<LoginScreenBloc>()
                                  .add(PasswordVisibility());
                            },
                            obscureText: !state.passwordVisibility,
                            onChanged: (value) {
                              context
                                  .read<LoginScreenBloc>()
                                  .add(LoginPasswordChanged(value));
                            },
                            validator: (value) =>
                                value!.validatePassword(value),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: Dimensions.PADDING_SIZE_EXTRA_OVER_LARGE.h,
                                bottom: Dimensions.PADDING_SIZE_SMALL.h),
                            child: CustomElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<LoginScreenBloc>()
                                      .add(LoginSubmit());
                                }
                              },
                              text: StringResources.CONTINUE_BUTTON_TEXT,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.SIGN_UP_SCREEN);
                              },
                              child: Text(
                                StringResources.SIGNUP_BUTTON_TEXT,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                        fontSize: Dimensions
                                            .FONT_SIZE_EXTRA_SMALL.sp),
                              ),
                            ),
                          ),
                          if (state.errorMessage != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                state.errorMessage!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: Dimensions.FONT_SIZE_SMALL.sp,
                                ),
                              ),
                            ),
                          if (state.successMessage != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                state.successMessage!,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: Dimensions.FONT_SIZE_SMALL.sp,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
