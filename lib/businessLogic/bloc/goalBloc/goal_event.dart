part of 'goal_bloc.dart';

abstract class GoalEvent extends Equatable {
  const GoalEvent();

  @override
  List<Object?> get props => [];
}

// Event for updating the user type
class UpdateUserType extends GoalEvent {
  final String userType;

  const UpdateUserType(this.userType);

  @override
  List<Object?> get props => [userType];
}

// Event for updating the monthly salary
class UpdateMonthlySalary extends GoalEvent {
  final double monthlySalary;

  const UpdateMonthlySalary(this.monthlySalary);

  @override
  List<Object?> get props => [monthlySalary];
}

// Event for updating the groceries expense
class UpdateGroceries extends GoalEvent {
  final double groceries;

  const UpdateGroceries(this.groceries);

  @override
  List<Object?> get props => [groceries];
}

// Event for updating the utility bills expense
class UpdateUtilityBills extends GoalEvent {
  final double utilityBills;

  const UpdateUtilityBills(this.utilityBills);

  @override
  List<Object?> get props => [utilityBills];
}

// Event for updating the mobile recharge expense
class UpdateMobileRecharge extends GoalEvent {
  final double mobileRecharge;

  const UpdateMobileRecharge(this.mobileRecharge);

  @override
  List<Object?> get props => [mobileRecharge];
}

// Event for updating other expenses
class UpdateOtherExpenses extends GoalEvent {
  final double otherExpenses;

  const UpdateOtherExpenses(this.otherExpenses);

  @override
  List<Object?> get props => [otherExpenses];
}

// Event for updating the goal name (boolean flag)
class UpdateGoalName extends GoalEvent {
  final String goalName;

  const UpdateGoalName(this.goalName);

  @override
  List<Object?> get props => [goalName];
}

// Event for updating the goal value
class UpdateGoalValue extends GoalEvent {
  final String goalValue;

  const UpdateGoalValue(this.goalValue);

  @override
  List<Object?> get props => [goalValue];
}

class SalaryRange extends GoalEvent {
  final double salaryRange;

  const SalaryRange(this.salaryRange);

  @override
  List<Object?> get props => [salaryRange];
}

class RemainingAmount extends GoalEvent {
  final double remainingAmount;

  const RemainingAmount(this.remainingAmount);

  @override
  List<Object?> get props => [remainingAmount];
}

class GoalSelected extends GoalEvent {
  final Map<String, dynamic> goal;

  GoalSelected({required this.goal});
}


class GoalAmount extends GoalEvent {
  final double goalAmount;

  const GoalAmount(this.goalAmount);

  @override
  List<Object?> get props => [goalAmount];
}

class CalculateMonths extends GoalEvent {
  final int months;

  const CalculateMonths(this.months);

  @override
  List<Object?> get props => [months];
}


class AddMyGoal extends GoalEvent {
  final MyGoal myGoal;

  AddMyGoal(this.myGoal);
}

class FetchGoals extends GoalEvent {}



