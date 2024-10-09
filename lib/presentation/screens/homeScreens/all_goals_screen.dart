import 'package:flutter/material.dart';
import '../../routes/routes_name.dart';

class GoalsScreen extends StatefulWidget {
  final String? salaryRange;
  final double? remainingAmount;

  const GoalsScreen({Key? key, this.salaryRange, this.remainingAmount}) : super(key: key);

  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final List<Map<String, dynamic>> goals = [
    {'goalName': 'Buy a Bike'},
    {'goalName': 'Buy a Car'},
    {'goalName': 'Travel Tickets'},
    {'goalName': 'Buy Gold'},
  ];

  Map<String, dynamic>? selectedGoal;
  final TextEditingController goalAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double salary = _convertSalaryRangeToAmount(widget.salaryRange ?? '');
    final double remainingAmount = widget.remainingAmount ?? salary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Remaining Amount and Salary Range
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Remaining Amount After Expenses',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$${remainingAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Salary Range: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.salaryRange ?? 'Not Provided',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Select a Goal to Achieve',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 20),

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

            const SizedBox(height: 20),

            // TextField for entering goal amount
            TextField(
              controller: goalAmountController,
              decoration: InputDecoration(
                hintText: 'Enter Goal Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.teal, width: 1.5),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (selectedGoal != null && goalAmountController.text.isNotEmpty) {
                    double goalAmount = double.tryParse(goalAmountController.text) ?? 0.0;

                    // Use the calculateMonthsToSave function
                    int monthsNeeded = calculateMonthsToSave(remainingAmount, goalAmount);

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
  },
);

                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a goal and enter an amount to proceed.')),
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

    return monthsNeeded +1;
  }
}
