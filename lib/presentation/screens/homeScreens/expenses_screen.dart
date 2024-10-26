import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/helper/constants/colors_resource.dart';
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
  final TextEditingController mobileRechargesController = TextEditingController();
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
                              prefixIcon: const Icon(Icons.miscellaneous_services),
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
                              onPressed: () => validateAndProceed(widget.goalBloc, state),
                              icon: const Icon(Icons.arrow_forward, color: Colors.white),
                              label: const Text(
                                'Next',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorResources.PRIMARY_COLOR,
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields with valid amounts.'),
        ),
      );
      return;
    }

    double totalExpenses = (state.groceries ?? 0) +
        (state.utilityBills ?? 0) +
        (state.mobileRecharge ?? 0) +
        (state.otherExpenses ?? 0);

    if (totalExpenses > (state.monthlySalary ?? 0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Total expenses cannot exceed your salary range.')),
      );
      return;
    }

    double remainingAmount = (state.monthlySalary ?? 0) - totalExpenses;

    bloc.add(RemainingAmount(remainingAmount));

    Navigator.pushNamed(
      context,
      RoutesName.ALL_GOALS_SCREEN,
      arguments: {'goalBloc': bloc},
    );
  }
}
