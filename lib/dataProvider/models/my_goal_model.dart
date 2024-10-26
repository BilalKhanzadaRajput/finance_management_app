class MyGoal {
  final String goalName;
  final String goalAmount;
  final String monthsNeeded;
  final String salary;
  final String userType;
  final String userId;
  final String date;

  MyGoal({
    required this.goalName,
    required this.goalAmount,
    required this.monthsNeeded,
    required this.salary,
    required this.userType,
    required this.userId,
    required this.date,
  });

  factory MyGoal.fromMap(Map<String, dynamic> map) {
    return MyGoal(
      goalName: map['goalName'] ?? 'No goal name provided',
      goalAmount: map['goalAmount'] ?? 'No goal amount provided',
      monthsNeeded: map['monthsNeeded'] ?? 'No months needed provided',
      salary: map['salary'] ?? 'No salary provided',
      userType: map['userType'] ?? 'No user type provided',
      userId: map['userId'] ?? 'No user ID provided',
      date: map['date'] ?? 'No date provided',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'goalName': goalName,
      'goalAmount': goalAmount,
      'monthsNeeded': monthsNeeded,
      'salary': salary,
      'userType': userType,
      'userId': userId,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'MyGoal(goalName: $goalName, goalAmount: $goalAmount, monthsNeeded: $monthsNeeded, salary: $salary, userType: $userType, userId: $userId, date: $date)';
  }
}
