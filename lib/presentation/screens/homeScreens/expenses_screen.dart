import 'package:flutter/material.dart';

import '../../routes/routes_name.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('Input Expenses and navigate to All goals screen')),
          TextButton(onPressed: () {
            Navigator.pushNamed(context, RoutesName.ALL_GOALS_SCREEN);
          }, child: Text('Next')),
        ],
      ),
    );
  }
}
