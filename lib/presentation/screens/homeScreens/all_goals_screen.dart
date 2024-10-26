import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display Remaining Amount and Salary Range
                  // Card(
                  //   elevation: 4,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16.0),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Text(
                  //           'Remaining Amount After Expenses',
                  //           style: TextStyle(
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //         const SizedBox(height: 10),
                  //         Text(
                  //           '\$${remainingAmount.toStringAsFixed(2)}',
                  //           style: const TextStyle(
                  //             fontSize: 24,
                  //             color: Colors.green,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //         const SizedBox(height: 10),
                  //         const Text(
                  //           'Salary Range: ',
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //         Text(
                  //           widget.salaryRange ?? 'Not Provided',
                  //           style: const TextStyle(fontSize: 18),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
                          widget.goalBloc.add(GoalSelected(goal: goal));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: state.selectedGoal == goal
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
                              groupValue: state.selectedGoal,
                              onChanged: (Map<String, dynamic>? value) {
                                widget.goalBloc.add(GoalSelected(goal: goal));
                              },
                              activeColor: ColorResources.PRIMARY_COLOR,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  // TextField for entering goal amount
                  state.selectedGoal != null
                      ? TextField(
                          controller: goalAmountController,
                          decoration: InputDecoration(
                            hintText: 'Enter Goal Amount',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.teal, width: 1.5),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            final doubleValue = double.parse(value);
                            widget.goalBloc.add(GoalAmount(doubleValue));
                          },
                        )
                      : const SizedBox.shrink(),
                  // Hide TextField when no goal is selected

                  const SizedBox(height: 20),

                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (state.selectedGoal != null &&
                            state.goalAmount != null) {
                          widget.goalBloc.add(
                              UpdateGoalName(state.selectedGoal?['goalName']));

                          // Use the calculateMonthsToSave function
                          int monthsNeeded = calculateMonthsToSave(
                              (state.remainingAmount ?? 0),
                              (state.goalAmount ?? 0));

                          widget.goalBloc.add(CalculateMonths(monthsNeeded));

                          // Print values to the console
                          print(
                              'Selected Goal: ${state.selectedGoal?['goalName']}');
                          print('Goal Amount: $state.goalAmount');
                          print('Monthly Savings: $state.remainingAmount');
                          print('Months Needed: $monthsNeeded');

                          Navigator.pushNamed(context,
                              RoutesName.GOAL_RESULT_SCREEN,
                              arguments: {'goalBloc': widget.goalBloc});
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please select a goal and enter an amount to proceed.')),
                          );
                        }
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
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Convert the salary range string to a double amount
  double _convertSalaryRangeToAmount(String salaryRange) {
    switch (salaryRange) {
      case '1000 - 2000':
        return 1500.0;
      case '2000 - 3000':
        return 2500.0;
      case '3000 - 4000':
        return 3500.0;
      case '4000 - 5000':
        return 4500.0;
      default:
        return 0.0; // Default case if no match found
    }
  }

  // Function to calculate months needed to save for the goal
  int calculateMonthsToSave(double remainingAmount, double itemCost) {
    if (remainingAmount <= 0) {
      // If there are no remaining savings, it would take forever to save.
      return double.infinity.toInt();
    }

    // Calculate the shortfall
    double shortfall = itemCost - remainingAmount;

    // If remaining amount is greater than or equal to item cost, no additional months are needed
    if (shortfall <= 0) {
      return 0;
    }

    // Calculate the number of months needed
    int monthsNeeded = (shortfall / remainingAmount).ceil();

    return monthsNeeded + 1;
  }
}
