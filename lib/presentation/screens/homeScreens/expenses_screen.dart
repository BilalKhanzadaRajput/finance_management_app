import 'package:flutter/material.dart';
import '../../routes/routes_name.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  // Controllers to manage the input values for each category.
  final TextEditingController groceriesController = TextEditingController();
  final TextEditingController utilityBillsController = TextEditingController();
  final TextEditingController mobileRechargesController =
      TextEditingController();
  final TextEditingController otherExpensesController = TextEditingController();

  // Method to validate and navigate.
  void validateAndProceed() {
    if (groceriesController.text.isEmpty ||
        utilityBillsController.text.isEmpty ||
        mobileRechargesController.text.isEmpty ||
        otherExpensesController.text.isEmpty) {
      // Show a message if any field is empty.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields before proceeding'),
        ),
      );
      return;
    }

    // Parse input values.
    double groceries = double.tryParse(groceriesController.text) ?? 0.0;
    double utilityBills = double.tryParse(utilityBillsController.text) ?? 0.0;
    double mobileRecharges =
        double.tryParse(mobileRechargesController.text) ?? 0.0;
    double otherExpenses = double.tryParse(otherExpensesController.text) ?? 0.0;

    // Check if all inputs are valid numbers.
    if (groceries < 0 ||
        utilityBills < 0 ||
        mobileRecharges < 0 ||
        otherExpenses < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter valid amounts for all expenses')),
      );
      return;
    }

    // Navigate to the next screen with the entered values.
    Navigator.pushNamed(
      context,
      RoutesName.ALL_GOALS_SCREEN,
      arguments: {
        'groceries': groceries,
        'utilityBills': utilityBills,
        'mobileRecharges': mobileRecharges,
        'otherExpenses': otherExpenses,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        title: const Text('Monthly Expenses Input'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter Your Monthly Expenses',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                const SizedBox(height: 20),

                // Groceries Input Field
                TextField(
                  controller: groceriesController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Groceries',
                    hintText: 'Enter amount spent on groceries',
                    prefixIcon: const Icon(Icons.shopping_cart),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Utility Bills Input Field
                TextField(
                  controller: utilityBillsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Utility Bills',
                    hintText: 'Enter amount spent on utility bills',
                    prefixIcon: const Icon(Icons.lightbulb),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Mobile Recharges Input Field
                TextField(
                  controller: mobileRechargesController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mobile Recharges',
                    hintText: 'Enter amount spent on mobile recharges',
                    prefixIcon: const Icon(Icons.phone_android),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Other Expenses Input Field
                TextField(
                  controller: otherExpensesController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Other Expenses',
                    hintText: 'Enter amount spent on other expenses',
                    prefixIcon: const Icon(Icons.money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Proceed Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: validateAndProceed,
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    label: const Text('Next'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
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
    );
  }
}
