import 'package:flutter/material.dart';

class GoalResultScreen extends StatefulWidget {
  const GoalResultScreen({super.key});

  @override
  State<GoalResultScreen> createState() => _GoalResultScreenState();
}

class _GoalResultScreenState extends State<GoalResultScreen> {
  // Sample data for demonstration
  String goalName = '';
  double goalAmount = 0.0;
  double monthlySavings = 0.0;
  int monthsNeeded = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve arguments passed from AllGoalsScreen
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      goalName = arguments['goalName'];
      goalAmount = arguments['goalAmount'];
      monthlySavings = arguments['monthlySavings'];
      monthsNeeded = arguments['monthsNeeded'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Result'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Goal: $goalName',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Amount Needed: \$${goalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Monthly Savings: \$${monthlySavings.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Months Needed to Achieve Goal: $monthsNeeded',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            const Text(
              'Action Plan:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '- Create a budget prioritizing your goal.\n'
              '- Track your expenses to maximize savings.\n'
              '- Set up a separate savings account for this goal.\n'
              '- Automate your savings transfers each month.\n'
              '- Review your progress monthly and adjust as needed.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
