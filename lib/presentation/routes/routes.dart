import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fm_app/businessLogic/bloc/dashboardScreenBloc/dashboard_screen_bloc.dart';
import 'package:fm_app/presentation/routes/routes_name.dart';
import 'package:fm_app/presentation/screens/homeScreens/all_goals_screen.dart';
import 'package:fm_app/presentation/screens/homeScreens/dashboard_screen.dart';
import 'package:fm_app/presentation/screens/homeScreens/expenses_screen.dart';
import 'package:fm_app/presentation/screens/homeScreens/goal_result_screen.dart';
import 'package:fm_app/presentation/screens/homeScreens/input_salary_screen.dart';
import 'package:fm_app/presentation/screens/homeScreens/my_goals_screen.dart';
import 'package:fm_app/presentation/screens/homeScreens/welcome_screen.dart';

import '../../businessLogic/bloc/goalBloc/goal_bloc.dart';
import '../../businessLogic/bloc/loginScreenBloc/login_screen_bloc.dart';
import '../../businessLogic/bloc/signUpScreenBloc/sign_up_screen_bloc.dart';
import '../screens/authenticationScreens/log_in_screen.dart';
import '../screens/authenticationScreens/sign_up_screen.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.WELCOME_SCREEN:
        return MaterialPageRoute(
          builder: (BuildContext context) => const WelcomeScreen(),
        );
      case RoutesName.LOG_IN_SCREEN:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider<LoginScreenBloc>(
            create: (context) => LoginScreenBloc(),
            child: const LogInScreen(),
          ),
        );
      case RoutesName.SIGN_UP_SCREEN:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider<SignUpScreenBloc>(
            create: (context) => SignUpScreenBloc(),
            child: const SignUpScreen(),
          ),
        );

      case RoutesName.DASHBOARD_SCREEN:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider<DashBoardScreenBloc>(
            create: (context) => DashBoardScreenBloc(),
            child: const DashBoardScreen(),
          ),
        );

      case RoutesName.INPUT_SALARY_SCREEN:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider<GoalBloc>(
            create: (context) => GoalBloc(),
            child: const InputSalaryScreen(),
          ),
        );

      case RoutesName.EXPENSES_SCREEN:
        final args = settings.arguments as Map<String, dynamic>;
        final goalBloc = args['goalBloc'] as GoalBloc;
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return BlocProvider.value(
              value: goalBloc,
              child: ExpensesScreen(
                goalBloc: goalBloc,
              ),
            );
          },
        );

      case RoutesName.ALL_GOALS_SCREEN:
        final args = settings.arguments as Map<String, dynamic>;
        final goalBloc = args['goalBloc'] as GoalBloc;

        return MaterialPageRoute(builder: (BuildContext context) {
          return BlocProvider.value(
            value: goalBloc,
            child: GoalsScreen(
              goalBloc: goalBloc,
            ),
          );
        });

      case RoutesName.GOAL_RESULT_SCREEN:
        final args = settings.arguments as Map<String, dynamic>;
        final goalBloc = args['goalBloc'] as GoalBloc;

        return MaterialPageRoute(
          builder: (BuildContext context) {
            return BlocProvider.value(
              value: goalBloc,
              child: GoalResultScreen(
                goalBloc: goalBloc,
              ),
            );
          },
        );
      case RoutesName.MY_GOALS_SCREEN:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider<DashBoardScreenBloc>(
            create: (context) => DashBoardScreenBloc(),
            child: const MyGoalsScreen(),
          ),
        );
    }
    return null;
  }
}
