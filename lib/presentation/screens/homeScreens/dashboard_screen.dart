import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/businessLogic/bloc/dashboardScreenBloc/dashboard_screen_bloc.dart';
import 'package:fm_app/presentation/customWidgets/custom_snackbar.dart';
import 'package:fm_app/presentation/routes/routes_name.dart';

import '../../../helper/constants/colors_resource.dart';
import '../../../helper/constants/dimensions_resource.dart';
import '../../../helper/constants/string_resources.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashBoardScreenBloc>().add(FetchImagesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text(
          'Finance Management',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: Dimensions.D_20.sp,
                color: ColorResources.WHITE_COLOR,
              ),
        ),
        backgroundColor: ColorResources.PRIMARY_COLOR,
        centerTitle: true,

        // Left-side icon button to navigate to Profile Screen
        leading: IconButton(
          icon: Icon(Icons.person, color: ColorResources.WHITE_COLOR),
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.PROFILE_SCREEN);
          },
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: ColorResources.WHITE_COLOR),
            onPressed: () {
              showLogOutDialog(context, () {
                context.read<DashBoardScreenBloc>().add(LogOutUser());
                showCustomSnackbar(
                  context,
                  'Logged Out',
                  'You have been successfully logged out.',
                  ContentType.success,
                );
              });
            },
          ),
        ],
      ),
      body: BlocListener<DashBoardScreenBloc, DashBoardScreenState>(
        listener: (context, state) {
          if (state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(StringResources.ERROR_FETCHING_DATA_ERROR),
                backgroundColor: ColorResources.ERROR_RED_COLOR,
              ),
            );
          }
          if (state.logOutUser) {
            Navigator.pushNamedAndRemoveUntil(
                context, RoutesName.LOG_IN_SCREEN, (route) => false);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE.w),
          child: BlocBuilder<DashBoardScreenBloc, DashBoardScreenState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.images.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/home_two.png',
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE.h),

                      // First Card with increased height and responsive design
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.INPUT_SALARY_SCREEN);
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 14.h, horizontal: 10.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 10.w),
                                Text(
                                  '₨', // PKR Symbol
                                  style: TextStyle(
                                    fontSize: 25.sp, // Size of symbol
                                    color: ColorResources.PRIMARY_COLOR,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text('Input Budget',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    size: 24.sp,
                                    color: ColorResources.PRIMARY_COLOR),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // Second Card with increased height and responsive design
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.MY_GOALS_SCREEN);
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 14.h, horizontal: 10.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 5.w),
                                Icon(
                                  Icons.flag,
                                  size: 35.h,
                                  color: ColorResources.PRIMARY_COLOR,
                                ),
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Text('My Goals',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    size: 24.sp,
                                    color: ColorResources.PRIMARY_COLOR),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  void showLogOutDialog(BuildContext context, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(StringResources.LOGOUT,
            style: TextStyle(color: ColorResources.PRIMARY_COLOR)),
        content: Text(
          StringResources.LOG_OUT_BOX_SUBTITLE,
          style: TextStyle(color: ColorResources.BLACK_COLOR),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(StringResources.CANCEL,
                style: TextStyle(color: ColorResources.BLACK_COLOR)),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(StringResources.LOGOUT,
                style: TextStyle(color: ColorResources.BLACK_COLOR)),
          ),
        ],
      ),
    );
  }
}
