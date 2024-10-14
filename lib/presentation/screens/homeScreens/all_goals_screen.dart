import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_app/helper/constants/image_resources.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helper/constants/colors_resource.dart';
import '../../routes/routes_name.dart';

class GoalsScreen extends StatefulWidget {
  final String? salaryRange;
  final double? remainingAmount;

  const GoalsScreen({Key? key, this.salaryRange, this.remainingAmount})
      : super(key: key);

  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final List<Map<String, dynamic>> goals = [
    {'goalName': 'Buy a Bike', 'icon': ImageResources.BIKE_ICON},
    {'goalName': 'Buy a Car', 'icon': ImageResources.CAR_ICON},
    {'goalName': 'Travel Tickets', 'icon': ImageResources.TICKET_ICON},
    {'goalName': 'Buy Gold', 'icon': ImageResources.GOLD_ICON},
  ];

  Map<String, dynamic>? selectedGoal;
  final TextEditingController goalAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double salary = _convertSalaryRangeToAmount(widget.salaryRange ?? '');
    final double remainingAmount = widget.remainingAmount ?? salary;

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
      body: SingleChildScrollView(
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
              ),),
               SizedBox(height: 10.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  bool isSelected = selectedGoal == goal;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedGoal = goal;
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: isSelected
                            ? const BorderSide(
                                color: ColorResources.PRIMARY_COLOR, width: 2)
                            : BorderSide.none,
                      ),
                      child: ListTile(
                        title: Text(
                          goal['goalName'],
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                        ),
                        leading: SvgPicture.asset(
                          goal['icon'],
                          width: 25.w,
                          height: 25.h,
                        ),
                        trailing: Radio<Map<String, dynamic>>(
                          value: goal,
                          groupValue: selectedGoal,
                          onChanged: (Map<String, dynamic>? value) {
                            setState(() {
                              selectedGoal = value;
                            });
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
              selectedGoal != null
                  ? TextField(
                      controller: goalAmountController,
                      decoration: InputDecoration(
                        hintText: 'Enter Goal Amount',
                        hintStyle:  GoogleFonts.poppins(
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
                    )
                  : const SizedBox.shrink(),
              // Hide TextField when no goal is selected

              const SizedBox(height: 20),

              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (selectedGoal != null &&
                        goalAmountController.text.isNotEmpty) {
                      double goalAmount =
                          double.tryParse(goalAmountController.text) ?? 0.0;

                      // Use the calculateMonthsToSave function
                      int monthsNeeded =
                          calculateMonthsToSave(remainingAmount, goalAmount);

                      // Print values to the console
                      print('Selected Goal: ${selectedGoal?['goalName']}');
                      print('Goal Amount: $goalAmount');
                      print('Monthly Savings: $remainingAmount');
                      print('Months Needed: $monthsNeeded');

                      Navigator.pushNamed(
                        context,
                        RoutesName.GOAL_RESULT_SCREEN,
                        arguments: {
                          'goalName': selectedGoal?['goalName'],
                          'goalAmount': goalAmount,
                          'monthlySavings': remainingAmount,
                          'monthsNeeded': monthsNeeded,
                          'remainingAmount': remainingAmount,
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Please select a goal and enter an amount to proceed.')),
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label:  Text('Next', style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorResources.WHITE_COLOR,
                  ),),
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
