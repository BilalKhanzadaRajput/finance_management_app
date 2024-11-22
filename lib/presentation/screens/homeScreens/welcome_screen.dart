import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/presentation/routes/routes_name.dart';

import '../../../helper/constants/colors_resource.dart';
import '../../../helper/constants/image_resources.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
              color: ColorResources.PRIMARY_COLOR,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage(ImageResources.WELCOME_LOGO),
                      width: 44.w,
                      height: 140.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Financial Management',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                // Image with flexible resizing
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Image(
                        image: const AssetImage(ImageResources.STANDING_MAN_IMAGE),
                        width: constraints.maxWidth * 0.9,
                        height: constraints.maxHeight * 0.8,
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            'Financial Management',
            style: TextStyle(
              color: ColorResources.PRIMARY_COLOR,
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              textAlign: TextAlign.center,
              'Empowering your financial journey with smart tools for budgeting, saving, and investing.',
              style: TextStyle(
                color: ColorResources.BLACK_COLOR.withOpacity(0.3),
                fontSize: 15.sp,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 105.w,
                height: 40.h,
                margin: EdgeInsets.only(right: 20.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RoutesName.LOG_IN_SCREEN);
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 105.w,
                height: 40.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RoutesName.SIGN_UP_SCREEN);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
