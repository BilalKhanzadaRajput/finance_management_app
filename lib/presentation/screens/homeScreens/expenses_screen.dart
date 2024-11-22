import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/helper/constants/colors_resource.dart';
import 'package:fm_app/presentation/customWidgets/custom_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../businessLogic/bloc/goalBloc/goal_bloc.dart';
import '../../routes/routes_name.dart';

class ExpensesScreen extends StatefulWidget {
  final GoalBloc goalBloc;

  const ExpensesScreen({
    super.key,
    required this.goalBloc,
  });

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final TextEditingController groceriesController = TextEditingController();
  final TextEditingController utilityBillsController = TextEditingController();
  final TextEditingController mobileRechargesController =
      TextEditingController();
  final TextEditingController otherExpensesController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    groceriesController.dispose();
    utilityBillsController.dispose();
    mobileRechargesController.dispose();
    otherExpensesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorResources.PRIMARY_COLOR,
        title: Text(
          'Monthly Expenses Input',
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter Your Monthly Expenses',
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorResources.PRIMARY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Display Salary Range
                          TextFormField(
                            controller: TextEditingController(
                              text: state.monthlySalary?.toStringAsFixed(0),
                            ),
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Salary Range',
                              hintText: 'Selected Salary Range',
                              prefixIcon: const Icon(Icons.monetization_on),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Groceries Input Field
                          TextFormField(
                            controller: groceriesController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Groceries',
                              prefixIcon: const Icon(Icons.shopping_cart),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter groceries expense.';
                              }
                              final regex = RegExp(r'^\d+$');
                              if (!regex.hasMatch(value)) {
                                return 'Please enter numbers only';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              final doubleValue = double.tryParse(value) ?? 0.0;
                              context
                                  .read<GoalBloc>()
                                  .add(UpdateGroceries(doubleValue));
                            },
                          ),
                          const SizedBox(height: 15),

                          // Utility Bills Input Field
                          TextFormField(
                            controller: utilityBillsController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Utility Bills',
                              prefixIcon: const Icon(Icons.lightbulb),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter utility bills expenses.';
                              }
                              final regex = RegExp(r'^\d+$');
                              if (!regex.hasMatch(value)) {
                                return 'Please enter numbers only';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              final doubleValue = double.tryParse(value) ?? 0.0;
                              context
                                  .read<GoalBloc>()
                                  .add(UpdateUtilityBills(doubleValue));
                            },
                          ),
                          const SizedBox(height: 15),

                          // Mobile Recharges Input Field
                          TextFormField(
                            controller: mobileRechargesController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Mobile Recharges',
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter recharge expenses.';
                              }
                              final regex = RegExp(r'^\d+$');
                              if (!regex.hasMatch(value)) {
                                return 'Please enter numbers only';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              final doubleValue = double.tryParse(value) ?? 0.0;
                              context
                                  .read<GoalBloc>()
                                  .add(UpdateMobileRecharge(doubleValue));
                            },
                          ),
                          const SizedBox(height: 15),

                          // Other Expenses Input Field
                          TextFormField(
                            controller: otherExpensesController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Other Expenses',
                              prefixIcon:
                                  const Icon(Icons.miscellaneous_services),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter other expenses.';
                              }
                              final regex = RegExp(r'^\d+$');
                              if (!regex.hasMatch(value)) {
                                return 'Please enter numbers only';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              final doubleValue = double.tryParse(value) ?? 0.0;
                              context
                                  .read<GoalBloc>()
                                  .add(UpdateOtherExpenses(doubleValue));
                            },
                          ),
                          const SizedBox(height: 15),

                          // Proceed Button
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  validateAndProceed(widget.goalBloc, state),
                              icon: const Icon(Icons.arrow_forward,
                                  color: Colors.white),
                              label: const Text(
                                'Next',
                                style: TextStyle(color: Colors.white),
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
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void validateAndProceed(GoalBloc bloc, GoalState state) {
    // Count how many fields are filled
    int filledFieldsCount = 0;
    
    if (groceriesController.text.isNotEmpty) filledFieldsCount++;
    if (utilityBillsController.text.isNotEmpty) filledFieldsCount++;
    if (mobileRechargesController.text.isNotEmpty) filledFieldsCount++;
    if (otherExpensesController.text.isNotEmpty) filledFieldsCount++;

    // Check if at least 2 fields are filled
    if (filledFieldsCount < 2) {
      showCustomSnackbar(
        context,
        'Note',
        'Please fill at least 2 expense fields.',
        ContentType.failure,
      );
      return;
    }

    // Validate that filled fields contain valid numbers
    bool hasInvalidInput = false;
    final regex = RegExp(r'^\d+$');

    if (groceriesController.text.isNotEmpty && !regex.hasMatch(groceriesController.text)) {
      hasInvalidInput = true;
    }
    if (utilityBillsController.text.isNotEmpty && !regex.hasMatch(utilityBillsController.text)) {
      hasInvalidInput = true;
    }
    if (mobileRechargesController.text.isNotEmpty && !regex.hasMatch(mobileRechargesController.text)) {
      hasInvalidInput = true;
    }
    if (otherExpensesController.text.isNotEmpty && !regex.hasMatch(otherExpensesController.text)) {
      hasInvalidInput = true;
    }

    if (hasInvalidInput) {
      showCustomSnackbar(
        context,
        'Note',
        'Please enter valid numbers in filled fields.',
        ContentType.failure,
      );
      return;
    }

    // Calculate total expenses from filled fields
    double totalExpenses = 0;
    if (groceriesController.text.isNotEmpty) {
      totalExpenses += double.parse(groceriesController.text);
    }
    if (utilityBillsController.text.isNotEmpty) {
      totalExpenses += double.parse(utilityBillsController.text);
    }
    if (mobileRechargesController.text.isNotEmpty) {
      totalExpenses += double.parse(mobileRechargesController.text);
    }
    if (otherExpensesController.text.isNotEmpty) {
      totalExpenses += double.parse(otherExpensesController.text);
    }

    if (totalExpenses > (state.monthlySalary ?? 0)) {
      showCustomSnackbar(
        context,
        'Note',
        'Total expenses cannot exceed your salary range.',
        ContentType.failure,
      );
      return;
    }

    // Update the bloc with the values (use 0.0 for empty fields)
    bloc.add(UpdateGroceries(groceriesController.text.isEmpty ? 0.0 : double.parse(groceriesController.text)));
    bloc.add(UpdateUtilityBills(utilityBillsController.text.isEmpty ? 0.0 : double.parse(utilityBillsController.text)));
    bloc.add(UpdateMobileRecharge(mobileRechargesController.text.isEmpty ? 0.0 : double.parse(mobileRechargesController.text)));
    bloc.add(UpdateOtherExpenses(otherExpensesController.text.isEmpty ? 0.0 : double.parse(otherExpensesController.text)));

    double remainingAmount = (state.monthlySalary ?? 0) - totalExpenses;
    bloc.add(RemainingAmount(remainingAmount));

    showCustomSnackbar(
      context,
      'Successful',
      'Expenses recorded successfully!',
      ContentType.success,
    );

    Navigator.pushNamed(
      context,
      RoutesName.ALL_GOALS_SCREEN,
      arguments: {'goalBloc': bloc},
    );
  }
}
