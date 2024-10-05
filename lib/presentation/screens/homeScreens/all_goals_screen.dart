import 'package:flutter/material.dart';

import '../../routes/routes_name.dart';

class AllGoalsScreen extends StatefulWidget {
  const AllGoalsScreen({super.key});

  @override
  State<AllGoalsScreen> createState() => _AllGoalsScreenState();
}

class _AllGoalsScreenState extends State<AllGoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text(' Select a goal and navigate to goal result screen')),
          TextButton(onPressed: () {
            Navigator.pushNamed(context, RoutesName.GOAL_RESULT_SCREEN);
          }, child: Text('Next')),
        ],
      ),
    );
  }
}
