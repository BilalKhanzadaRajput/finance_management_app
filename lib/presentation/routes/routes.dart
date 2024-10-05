import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fm_app/presentation/routes/routes_name.dart';
import 'package:fm_app/presentation/screens/homeScreens/home_screen.dart';

import '../../businessLogic/bloc/loginScreenBloc/login_screen_bloc.dart';
import '../../businessLogic/bloc/signUpScreenBloc/sign_up_screen_bloc.dart';
import '../screens/authenticationScreens/log_in_screen.dart';
import '../screens/authenticationScreens/sign_up_screen.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
          case RoutesName.HOME_SCREEN:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(), // Add HomeScreen route
        );
        

    }
    return null;
  }
}
