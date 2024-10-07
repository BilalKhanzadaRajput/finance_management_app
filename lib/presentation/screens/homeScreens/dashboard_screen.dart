import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fm_app/businessLogic/bloc/dashboardScreenBloc/dashboard_screen_bloc.dart';
import 'package:fm_app/presentation/routes/routes_name.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helper/constants/colors_resource.dart';
import '../../../helper/constants/dimensions_resource.dart';
import '../../../helper/constants/image_resources.dart';
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
          StringResources.DASHBOARD_TITLE,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE.sp,
                color: ColorResources.WHITE_COLOR,
              ),
        ),
        backgroundColor: ColorResources.PRIMARY_COLOR,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset(
                ImageResources.MENU_ICON,
                width: Dimensions.D_24.w,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: customDrawer(context: context),
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
                      // Add the image to the top of the screen
                      Image.asset(
                        'assets/images/home.jpeg',
                        width: double.infinity,
                        height: 200.h, // Adjust height as needed
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE.h),

                      // First Card with increased height and responsive design
                      SizedBox(
                        height: 120.h, // Increased height
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '₨', // PKR Symbol
                                  style: TextStyle(
                                    fontSize: 50.sp, // Size of symbol
                                    color: ColorResources.PRIMARY_COLOR,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: Dimensions.PADDING_SIZE_LARGE.w),
                                Expanded(
                                  child: Text(
                                    'Input Budget',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward_ios,
                                      size: 24.sp, color: ColorResources.PRIMARY_COLOR),
                                  onPressed: () {
                                    Navigator.pushNamed(context, RoutesName.INPUT_SALARY_SCREEN);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE.h),

                      // Second Card with increased height and responsive design
                      SizedBox(
                        height: 120.h, // Increased height
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.flag,
                                  size: 50.sp,
                                  color: ColorResources.PRIMARY_COLOR,
                                ),
                                SizedBox(width: Dimensions.PADDING_SIZE_LARGE.w),
                                Expanded(
                                  child: Text(
                                    'My Goals',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward_ios,
                                      size: 24.sp, color: ColorResources.PRIMARY_COLOR),
                                  onPressed: () {
                                    Navigator.pushNamed(context, RoutesName.MY_GOALS_SCREEN);
                                  },
                                ),
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

  Widget customDrawer({required BuildContext context}) {
    return Drawer(
      backgroundColor: ColorResources.PRIMARY_COLOR,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: ColorResources.WHITE_COLOR),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
                left: Dimensions.PADDING_8.w,
                bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE.w),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                showLogOutDialog(context, () {
                  context.read<DashBoardScreenBloc>().add(LogOutUser());
                });
              },
              child: ListTile(
                leading: Icon(Icons.logout_outlined,
                    color: ColorResources.WHITE_COLOR),
                title: Text(
                  StringResources.LOG_OUT_TEXT,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE.sp,
                        color: ColorResources.WHITE_COLOR,
                      ),
                ),
              ),
            ),
          ),
        ],
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
