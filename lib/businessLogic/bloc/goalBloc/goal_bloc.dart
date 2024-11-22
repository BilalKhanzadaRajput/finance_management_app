import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../dataProvider/models/my_goal_model.dart';
import '../../../helper/constants/image_resources.dart';

part 'goal_event.dart';
part 'goal_state.dart';



class GoalBloc extends Bloc<GoalEvent, GoalState> {
  GoalBloc() : super(const GoalState()) {
    final FirebaseFirestore _database = FirebaseFirestore.instance;

    // Handler for user type update
    on<UpdateUserType>((event, emit) {
      emit(state.copyWith(userType: event.userType));
    });

    // Handler for monthly salary update
    on<UpdateMonthlySalary>((event, emit) {
      emit(state.copyWith(monthlySalary: event.monthlySalary));
    });

    // Handler for groceries update
    on<UpdateGroceries>((event, emit) {
      emit(state.copyWith(groceries: event.groceries));
    });

    // Handler for utility bills update
    on<UpdateUtilityBills>((event, emit) {
      emit(state.copyWith(utilityBills: event.utilityBills));
    });

    // Handler for mobile recharge update
    on<UpdateMobileRecharge>((event, emit) {
      emit(state.copyWith(mobileRecharge: event.mobileRecharge));
    });

    // Handler for other expenses update
    on<UpdateOtherExpenses>((event, emit) {
      emit(state.copyWith(otherExpenses: event.otherExpenses));
    });

    // Handler for goal name (boolean) update
    on<UpdateGoalName>((event, emit) {
      emit(state.copyWith(goalName: event.goalName));
    });

    // Handler for goal value update
    on<UpdateGoalValue>((event, emit) {
      emit(state.copyWith(goalValue: event.goalValue));
    });

    on<SalaryRange>((event, emit) {
      emit(state.copyWith(salaryRange: event.salaryRange));
    });

    on<RemainingAmount>((event, emit) {
      emit(state.copyWith(remainingAmount: event.remainingAmount));
    });

    on<GoalSelected>((event, emit) {
      emit(state.copyWith(selectedGoal: event.goal));
    });

    on<GoalAmount>((event, emit) {
      emit(state.copyWith(goalAmount: event.goalAmount));
    });

    on<CalculateMonths>((event, emit) {
      emit(state.copyWith(monthsNeeded: event.months));
    });

    on<AddMyGoal>((event, emit) async {
      try {
        // Start loading state
        emit(state.copyWith(isLoading: true));

        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          throw FirebaseAuthException(
            code: 'user-not-logged-in',
            message: 'User is not logged in.',
          );
        }

        // Perform the async database operation
        await _database.collection('myGoals').add(event.myGoal.toMap());

        // Emit success state
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } on FirebaseException catch (e) {
        // Emit failure state
        emit(state.copyWith(
          isLoading: false,
          isFailure: true,
          errorMessage: e.message,
        ));
      }
    });

    Future<List<MyGoal>> _fetchMyGoalsFromFirestore(String userId,
        bool isAdmin,) async {
      final query = _database.collection('myGoals');

      final snapshot = isAdmin
          ? await query.get()
          : await query.where('userId', isEqualTo: userId).get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return MyGoal.fromMap(data);
      }).toList();
    }

    on<FetchGoals>((event, emit) async {
      try {
        // Start loading state
        emit(state.copyWith(isLoading: true));

        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          throw FirebaseAuthException(
            code: 'user-not-logged-in',
            message: 'User is not logged in.',
          );
        }

        final userDoc = await _database.collection('users').doc(user.uid).get();
final isAdmin = userDoc.data()?['isAdmin']?.toString().toLowerCase() == 'true';

        final myGoals = await _fetchMyGoalsFromFirestore(user.uid, isAdmin);

        // Emit success state
        emit(state.copyWith(
          myGoals: myGoals,
          isLoading: false,
          isSuccess: true,
        ));
      } on FirebaseException catch (e) {
        // Emit failure state
        emit(state.copyWith(
          isLoading: false,
          isFailure: true,
          errorMessage: e.message,
        ));
      }
    });
  }
}
