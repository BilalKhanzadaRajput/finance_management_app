import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/businessLogic/bloc/goalBloc/goal_bloc.dart';
import 'package:fm_app/dataProvider/models/my_goal_model.dart';
import 'package:fm_app/helper/constants/colors_resource.dart';
import 'package:fm_app/helper/constants/dimensions_resource.dart';
import 'package:fm_app/helper/constants/image_resources.dart';
import 'package:google_fonts/google_fonts.dart';

class MyGoalsScreen extends StatefulWidget {
  const MyGoalsScreen({super.key});

  @override
  State<MyGoalsScreen> createState() => _MyGoalsScreenState();
}

class _MyGoalsScreenState extends State<MyGoalsScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger fetching of goals
    context.read<GoalBloc>().add(FetchGoals());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Goals',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: Dimensions.D_20.sp,
                color: ColorResources.WHITE_COLOR,
              ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: ColorResources.PRIMARY_COLOR,
      ),
      body: BlocBuilder<GoalBloc, GoalState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.isFailure) {
            return Center(
                child: Text(state.errorMessage ?? 'Failed to load goals'));
          } else if (state.myGoals != null && state.myGoals!.isNotEmpty) {
            return ListView.builder(
              itemCount: state.myGoals!.length,
              itemBuilder: (context, index) {
                final goal = state.myGoals![index];
                return GoalCard(goal: goal);
              },
            );
          } else {
            return const Center(child: Text('No goals available.'));
          }
        },
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  final MyGoal goal;

  const GoalCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 6.0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: 140, // Ensures uniform height for all cards
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ImageResources.PERSONS_ICON,
                width: 48,
                height: 48,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      goal.goalName ?? 'Unknown Goal',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Goal Value: ${goal.goalAmount}',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Monthly Contribution: ${goal.amountNeeded ?? 'N/A'}',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Months Needed: ${goal.monthsNeeded ?? 'N/A'}',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
