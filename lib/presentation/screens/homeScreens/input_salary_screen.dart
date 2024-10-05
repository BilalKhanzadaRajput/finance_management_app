import 'package:flutter/material.dart';
import 'package:fm_app/presentation/routes/routes_name.dart';

class InputSalaryScreen extends StatefulWidget {
  const InputSalaryScreen({super.key});

  @override
  State<InputSalaryScreen> createState() => _InputSalaryScreenState();
}

class _InputSalaryScreenState extends State<InputSalaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('Input Salary and navigate to expenses screen')),
          TextButton(onPressed: () {
            Navigator.pushNamed(context, RoutesName.EXPENSES_SCREEN);
          }, child: Text('Next')),
        ],
      ),
    );
  }
}
