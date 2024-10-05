import 'package:flutter/material.dart';

import '../../routes/routes_name.dart';

class GoalResultScreen extends StatefulWidget {
  const GoalResultScreen({super.key});

  @override
  State<GoalResultScreen> createState() => _GoalResultScreenState();
}

class _GoalResultScreenState extends State<GoalResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text(' Goal result!')),
        ],
      ),
    );
  }
}
