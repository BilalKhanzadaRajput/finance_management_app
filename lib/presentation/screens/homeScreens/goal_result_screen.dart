import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/helper/constants/colors_resource.dart';
import 'package:fm_app/presentation/routes/routes_name.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../businessLogic/bloc/goalBloc/goal_bloc.dart';
import '../../../dataProvider/models/my_goal_model.dart';

class GoalResultScreen extends StatefulWidget {
  final GoalBloc goalBloc;

  const GoalResultScreen({super.key, required this.goalBloc});

  @override
  State<GoalResultScreen> createState() => _GoalResultScreenState();
}

class _GoalResultScreenState extends State<GoalResultScreen> {
  String userId = FirebaseAuth.instance.currentUser!.uid;

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
          child: BlocConsumer<GoalBloc, GoalState>(
            bloc: widget.goalBloc,
            listener: (context, state) {
              if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Goal added successfully'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.pushNamedAndRemoveUntil(
                    context, RoutesName.DASHBOARD_SCREEN, (route) => false);
              } else if (state.isFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'Error adding goal'),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
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
                                  text: state.goalName,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                    color: ColorResources.PRIMARY_COLOR,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' has been successfully added.\n\nTo achieve your goal of ',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18.sp,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${state.goalAmount?.toStringAsFixed(0)} ',
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
                                  text:
                                      state.remainingAmount?.toStringAsFixed(0),
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                    color: ColorResources.PRIMARY_COLOR,
                                  ),
                                ),
                                TextSpan(
                                  text: ' per month for ',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18.sp,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: '${state.monthsNeeded} months.',
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      icon:  const Icon(Icons.arrow_forward,
                              color: Colors.white),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        // Print each state property individually for debugging
                        print('Goal Name: ${state.goalName}');
                        print('Goal Amount: ${state.goalAmount}');
                        print('Months Needed: ${state.monthsNeeded}');
                        print('Salary Range: ${state.salaryRange}');
                        print('User Type: ${state.userType}');
                        print('User ID: $userId');

                        // Check if any value is unexpectedly null or formatted incorrectly
                        widget.goalBloc.add(AddMyGoal(MyGoal(
                          goalName: state.goalName ?? '',
                          goalAmount: state.goalAmount?.toString() ?? '0',
                          monthsNeeded: state.monthsNeeded?.toString() ?? '0',
                          salary: state.salaryRange?.toString() ?? '0',
                          userType: state.userType ?? '',
                          userId: userId,
                          date: DateTime.now().toString().split(' ').first,
                        )));
                      },

                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
