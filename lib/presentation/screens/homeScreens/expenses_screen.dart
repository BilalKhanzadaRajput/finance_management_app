import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/helper/constants/colors_resource.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/routes_name.dart';

class ExpensesScreen extends StatefulWidget {
  final String? salaryRange; // Holds the salary range

  const ExpensesScreen({super.key, this.salaryRange}); // Update constructor

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  // Controllers to manage the input values for each category.
  final TextEditingController groceriesController = TextEditingController();
  final TextEditingController utilityBillsController = TextEditingController();
  final TextEditingController mobileRechargesController = TextEditingController();
  final TextEditingController otherExpensesController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void validateAndProceed() {
    // Check if the form is valid
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields with valid amounts.'),
        ),
      );
      return;
    }

    // Parse input values.
    double groceries = double.tryParse(groceriesController.text) ?? 0.0;
    double utilityBills = double.tryParse(utilityBillsController.text) ?? 0.0;
    double mobileRecharges = double.tryParse(mobileRechargesController.text) ?? 0.0;
    double otherExpenses = double.tryParse(otherExpensesController.text) ?? 0.0;

    // Check if all inputs are valid numbers.
    if (groceries < 0 ||
        utilityBills < 0 ||
        mobileRecharges < 0 ||
        otherExpenses < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid amounts for all expenses.')),
      );
      return;
    }

    // Calculate the total of all expenses.
    double totalExpenses = groceries + utilityBills + mobileRecharges + otherExpenses;

    // Convert salary range to a double
    double salary = double.tryParse(widget.salaryRange ?? "0") ?? 0.0;

    // Check if total expenses exceed the salary range
    if (totalExpenses > salary) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Total expenses cannot exceed your salary range.')),
      );
      return; // Exit the method if expenses exceed salary
    }

    // Calculate remaining amount after expenses
    double remainingAmount = salary - totalExpenses;

    // Print values to console
    print('Salary Range: ${widget.salaryRange}');
    print('Groceries: $groceries');
    print('Utility Bills: $utilityBills');
    print('Mobile Recharges: $mobileRecharges');
    print('Other Expenses: $otherExpenses');
    print('Total Expenses: $totalExpenses');
    print('Remaining Amount after Expenses: $remainingAmount'); // Print remaining amount

    // Navigate to the next screen with the entered values.
    Navigator.pushNamed(
      context,
      RoutesName.ALL_GOALS_SCREEN,
      arguments: {
        'salaryRange': widget.salaryRange, // Pass salary range
        'remainingAmount': remainingAmount, // Pass remaining amount
        // Other parameters as necessary
      },
    );
  }


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
    // Extract the salary range from the arguments passed
    final String salaryRange = widget.salaryRange ?? "0";

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorResources.PRIMARY_COLOR,
        title: Text('Monthly Expenses Input', style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
        ),),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
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
                        controller: TextEditingController(text: salaryRange),
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
                      ),
                      const SizedBox(height: 15),

                      // Proceed Button
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: validateAndProceed,
                          icon: const Icon(
                              Icons.arrow_forward, color: Colors.white),
                          label: const Text(
                            'Next', style: TextStyle(color: Colors.white),),
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
      ),
    );
  }
}
