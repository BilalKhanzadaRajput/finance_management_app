import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_app/presentation/customWidgets/custom_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../businessLogic/bloc/goalBloc/goal_bloc.dart';
import '../../../helper/constants/colors_resource.dart';
import '../../routes/routes_name.dart';

class GoalsScreen extends StatefulWidget {
  final GoalBloc goalBloc;

  const GoalsScreen({Key? key, required this.goalBloc}) : super(key: key);

  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final TextEditingController goalAmountController = TextEditingController();
  final TextEditingController customGoalController = TextEditingController();
  bool isCustomGoal = false;

  // Method to calculate progress percentage
  double calculateProgressPercentage(
      double remainingAmount, double goalAmount) {
    if (goalAmount <= 0) return 0.0; // Avoid division by zero
    double progress = (remainingAmount / goalAmount) * 100; // Percentage
    return progress.clamp(0, 100); // Clamp between 0 and 100
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorResources.PRIMARY_COLOR,
        title: Text(
          'Goals Screen',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<GoalBloc, GoalState>(
        bloc: widget.goalBloc,
        builder: (context, state) {
          double progressPercentage = calculateProgressPercentage(
            state.remainingAmount ?? 0,
            state.goalAmount ?? 0,
          );

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Indicator Section
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Progress towards Goal',
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CircularProgressIndicator(
                          value: progressPercentage / 100,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ColorResources.PRIMARY_COLOR,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          '${progressPercentage.toStringAsFixed(1)}%',
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Select a Goal to Achieve',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.PRIMARY_COLOR,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.goals?.length,
                    itemBuilder: (context, index) {
                      final goal = state.goals?[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            isCustomGoal = false;
                          });
                          widget.goalBloc.add(GoalSelected(goal: goal));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: (!isCustomGoal && state.selectedGoal == goal)
                                ? const BorderSide(
                                    color: ColorResources.PRIMARY_COLOR,
                                    width: 2)
                                : BorderSide.none,
                          ),
                          child: ListTile(
                            title: Text(goal?['goalName'],
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            leading: SvgPicture.asset(
                              goal?['icon'],
                              width: 25.w,
                              height: 25.h,
                            ),
                            trailing: Radio<Map<String, dynamic>>(
                              value: goal!,
                              groupValue: !isCustomGoal ? state.selectedGoal : null,
                              onChanged: (Map<String, dynamic>? value) {
                                setState(() {
                                  isCustomGoal = false;
                                });
                                widget.goalBloc.add(GoalSelected(goal: goal));
                              },
                              activeColor: ColorResources.PRIMARY_COLOR,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Custom Goal Option
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: isCustomGoal
                          ? const BorderSide(
                              color: ColorResources.PRIMARY_COLOR, width: 2)
                          : BorderSide.none,
                    ),
                    child: ListTile(
                      title: Text('Other',
                          style: Theme.of(context).textTheme.displaySmall),
                      leading: Icon(Icons.add_circle_outline,
                          color: ColorResources.PRIMARY_COLOR, size: 25.w),
                      trailing: Radio<bool>(
                        value: true,
                        groupValue: isCustomGoal,
                        onChanged: (bool? value) {
                          setState(() {
                            isCustomGoal = true;
                          });
                          widget.goalBloc.add(GoalSelected(goal: {
                            'goalName': 'Custom Goal',
                            'icon': 'assets/icons/custom-goal-icon.svg'
                          }));
                        },
                        activeColor: ColorResources.PRIMARY_COLOR,
                      ),
                    ),
                  ),
                  // Custom Goal Name TextField
                  if (isCustomGoal) ...[
                    SizedBox(height: 20.h),
                    TextField(
                      controller: customGoalController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Goal Name',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.teal, width: 1.5),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          widget.goalBloc.add(GoalSelected(goal: {
                            'goalName': value,
                            'icon': 'assets/icons/custom-goal-icon.svg'
                          }));
                        }
                      },
                    ),
                  ],
                  SizedBox(height: 20.h),
                  // Goal Amount TextField
                  if ((state.selectedGoal != null || isCustomGoal) &&
                      (isCustomGoal ? customGoalController.text.isNotEmpty : true))
                    TextField(
                      controller: goalAmountController,
                      decoration: InputDecoration(
                        hintText: 'Enter Goal Amount in PKR',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.teal, width: 1.5),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final doubleValue = double.tryParse(value) ?? 0;
                        widget.goalBloc.add(GoalAmount(doubleValue));
                      },
                    ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (state.selectedGoal != null &&
                            state.goalAmount != null) {
                          widget.goalBloc.add(
                              UpdateGoalName(state.selectedGoal?['goalName']));

                          // Calculate months needed
                          int monthsNeeded = calculateMonthsToSave(
                              (state.remainingAmount ?? 0),
                              (state.goalAmount ?? 0));

                          widget.goalBloc.add(CalculateMonths(monthsNeeded));

                          // Print values to the console
                          print(
                              'Selected Goal: ${state.selectedGoal?['goalName']}');
                          print('Goal Amount: ${state.goalAmount}');
                          print('Monthly Savings: ${state.remainingAmount}');
                          print('Months Needed: $monthsNeeded');

                          Navigator.pushNamed(
                              context, RoutesName.GOAL_RESULT_SCREEN,
                              arguments: {'goalBloc': widget.goalBloc});
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please select a goal and enter an amount to proceed.')),
                          );
                        }

                        showCustomSnackbar(
                          context,
                          'Congratulations!',
                          'Goal recorded successfully!',
                          ContentType.success,
                        );
                      },
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                      label: Text(
                        'Next',
                        style: GoogleFonts.poppins(
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
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Function to calculate months needed to save for the goal
  int calculateMonthsToSave(double remainingAmount, double itemCost) {
    if (remainingAmount <= 0) {
      return double.infinity.toInt();
    }

    double shortfall = itemCost - remainingAmount;

    if (shortfall <= 0) {
      return 0;
    }

    int monthsNeeded = (shortfall / remainingAmount).ceil();

    return monthsNeeded + 1;
  }
}
