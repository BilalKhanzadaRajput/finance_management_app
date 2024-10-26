part of 'goal_bloc.dart';

class GoalState extends Equatable {
  final String? userType;
  final double? monthlySalary;
  final double? groceries;
  final double? utilityBills;
  final double? mobileRecharge;
  final double? otherExpenses;
  final String? goalName;
  final String? goalValue;
  final double? salaryRange;
  final double? remainingAmount;
  final List<Map<String, dynamic>>? goals;
  final Map<String, dynamic>? selectedGoal;
  final double? goalAmount;
  final int? monthsNeeded;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final String? errorMessage;
  final String? successMessage;
  final List<MyGoal>? myGoals;

  const GoalState({
    this.userType,
    this.monthlySalary,
    this.groceries,
    this.utilityBills,
    this.mobileRecharge,
    this.otherExpenses,
    this.goalName,
    this.goalValue,
    this.salaryRange,
    this.remainingAmount,
    this.goals = const [
      {'goalName': 'Buy a Bike', 'icon': ImageResources.BIKE_ICON},
      {'goalName': 'Buy a Car', 'icon': ImageResources.CAR_ICON},
      {'goalName': 'Travel Tickets', 'icon': ImageResources.TICKET_ICON},
      {'goalName': 'Buy Gold', 'icon': ImageResources.GOLD_ICON},
    ],
    this.selectedGoal,
    this.goalAmount,
    this.monthsNeeded,
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.errorMessage,
    this.successMessage,
    this.myGoals = const [],
  });

  GoalState copyWith({
    String? userType,
    double? monthlySalary,
    double? groceries,
    double? utilityBills,
    double? mobileRecharge,
    double? otherExpenses,
    String? goalName,
    String? goalValue,
    double? salaryRange,
    double? remainingAmount,
    List<Map<String, dynamic>>? goals,
    Map<String, dynamic>? selectedGoal,
    double? goalAmount,
    int? monthsNeeded,
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    String? successMessage,
    List<MyGoal>? myGoals,
  }) {
    return GoalState(
      userType: userType ?? this.userType,
      monthlySalary: monthlySalary ?? this.monthlySalary,
      groceries: groceries ?? this.groceries,
      utilityBills: utilityBills ?? this.utilityBills,
      mobileRecharge: mobileRecharge ?? this.mobileRecharge,
      otherExpenses: otherExpenses ?? this.otherExpenses,
      goalName: goalName ?? this.goalName,
      goalValue: goalValue ?? this.goalValue,
      salaryRange: salaryRange ?? this.salaryRange,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      goals: goals ?? this.goals,
      selectedGoal: selectedGoal ?? this.selectedGoal,
      goalAmount: goalAmount ?? this.goalAmount,
      monthsNeeded: monthsNeeded ?? this.monthsNeeded,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      myGoals: myGoals ?? this.myGoals,
    );
  }

  @override
  List<Object?> get props => [
    userType,
    monthlySalary,
    groceries,
    utilityBills,
    mobileRecharge,
    otherExpenses,
    goalName,
    goalValue,
    salaryRange,
    remainingAmount,
    goals,
    selectedGoal,
    goalAmount,
    monthsNeeded,
    isLoading,
    isSuccess,
    isFailure,
    errorMessage,
    successMessage,
    myGoals,
  ];
}