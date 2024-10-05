import 'package:flutter/material.dart';
import '../../routes/routes_name.dart';

class AllGoalsScreen extends StatefulWidget {
  const AllGoalsScreen({super.key});

  @override
  State<AllGoalsScreen> createState() => _AllGoalsScreenState();
}

class _AllGoalsScreenState extends State<AllGoalsScreen> {
  // List of predefined goals with their respective amounts.
  final List<Map<String, dynamic>> goals = [
    {'goalName': 'Buy a Bike', 'amount': 5000.0},
    {'goalName': 'Buy a Car', 'amount': 20000.0},
    {'goalName': 'Travel Tickets', 'amount': 3000.0},
    {'goalName': 'Buy Gold', 'amount': 15000.0},
  ];

  // Variable to hold the selected goal.
  Map<String, dynamic>? selectedGoal;

  @override
  Widget build(BuildContext context) {
    // Retrieve the user's salary and monthly expenses from arguments.
    final Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String? salaryRange = arguments?['salaryRange'];
    final double salary = _convertSalaryRangeToAmount(salaryRange ?? '');
    final double groceries = arguments?['groceries'] ?? 0.0;
    final double utilityBills = arguments?['utilityBills'] ?? 0.0;
    final double mobileRecharges = arguments?['mobileRecharges'] ?? 0.0;
    final double otherExpenses = arguments?['otherExpenses'] ?? 0.0;

    // Calculate total monthly expenses.
    final double totalExpenses = groceries + utilityBills + mobileRecharges + otherExpenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Goal'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Goal to Achieve',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 20),

            // Display a list of goals for selection.
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  return ListTile(
                    title: Text(
                      goal['goalName'],
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text('Amount: \$${goal['amount']}'),
                    trailing: Radio<Map<String, dynamic>>(
                      value: goal,
                      groupValue: selectedGoal,
                      onChanged: (Map<String, dynamic>? value) {
                        setState(() {
                          selectedGoal = value;
                        });
                      },
                      activeColor: Colors.teal,
                    ),
                  );
                },
              ),
            ),

            // Next Button to navigate to the Goal Result Screen.
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (selectedGoal != null) {
                    // Calculate the monthly savings amount.
                    double monthlySavings = salary - totalExpenses;

                    // If monthly savings are zero or negative, show a warning and still navigate to result.
                    if (monthlySavings <= 0) {
                      monthlySavings = 0; // Set savings to zero for the calculation.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Your expenses are higher than or equal to your salary. Monthly savings will be zero.',
                          ),
                        ),
                      );
                    }

                    // Calculate the number of months needed to reach the goal.
                    double goalAmount = selectedGoal?['amount'] ?? 0.0;
                    int monthsNeeded = (goalAmount / (monthlySavings == 0 ? 1 : monthlySavings)).ceil();

                    // Navigate to the Goal Result Screen with calculated values.
                    Navigator.pushNamed(
                      context,
                      RoutesName.GOAL_RESULT_SCREEN,
                      arguments: {
                        'goalName': selectedGoal?['goalName'],
                        'goalAmount': goalAmount,
                        'monthlySavings': monthlySavings,
                        'monthsNeeded': monthlySavings == 0 ? double.infinity : monthsNeeded,
                      },
                    );
                  } else {
                    // Show a message if no goal is selected.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a goal to proceed.')),
                    );
                  }
                },
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text('Next'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Method to convert salary range string to numeric value.
  double _convertSalaryRangeToAmount(String salaryRange) {
    switch (salaryRange) {
      case 'Below \$1,000':
        return 1000.0;
      case '\$1,000 - \$2,000':
        return 2000.0;
      case '\$2,000 - \$3,000':
        return 3000.0;
      case '\$3,000 - \$5,000':
        return 5000.0;
      case 'Above \$5,000':
        return 6000.0; // Default value for 'Above' case.
      default:
        return 0.0; // Default if no range is provided.
    }
  }
}
