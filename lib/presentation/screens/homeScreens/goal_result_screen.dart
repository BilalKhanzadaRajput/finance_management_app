import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/helper/constants/colors_resource.dart';
import 'package:fm_app/presentation/routes/routes_name.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalResultScreen extends StatefulWidget {
  final String goalName;
  final double goalAmount;
  final double monthlySavings;
  final int monthsNeeded;

  const GoalResultScreen({
    super.key,
    required this.goalName,
    required this.goalAmount,
    required this.monthlySavings,
    required this.monthsNeeded,
  });

  @override
  State<GoalResultScreen> createState() => _GoalResultScreenState();
}

class _GoalResultScreenState extends State<GoalResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Goal Result',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorResources.PRIMARY_COLOR,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Goal Added',
                  style: GoogleFonts.poppins(
                    color: ColorResources.BLACK_COLOR,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                  child: Icon(
                Icons.check_circle_rounded,
                size: 130.h,
                color: ColorResources.PRIMARY_COLOR,
              )),
              Card(
                elevation: 4,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Congratulations! Your goal ',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${widget.goalName} ',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: ColorResources.PRIMARY_COLOR,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'has been successfully added.\n\nTo achieve your goal of ',
                              style: GoogleFonts.montserrat(
                                fontSize: 18.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: '${widget.goalAmount.toInt()} ',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: ColorResources.PRIMARY_COLOR,
                              ),
                            ),
                            TextSpan(
                              text: 'you will need to save ',
                              style: GoogleFonts.montserrat(
                                fontSize: 18.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: '${widget.monthlySavings.toInt()} ',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: ColorResources.PRIMARY_COLOR,
                              ),
                            ),
                            TextSpan(
                              text: 'per month for ',
                              style: GoogleFonts.montserrat(
                                fontSize: 18.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: '${widget.monthsNeeded} months.',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: ColorResources.PRIMARY_COLOR,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign
                            .center, // Center-align to keep everything balanced
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.WHITE_COLOR,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.PRIMARY_COLOR,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, RoutesName.DASHBOARD_SCREEN, (route) => false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
