import 'package:equatable/equatable.dart';

// Define Profile Events
abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfile extends UserProfileEvent {}

class UpdateUserName extends UserProfileEvent {
  final String newName;

  const UpdateUserName(this.newName);

  @override
  List<Object> get props => [newName];
}

class UpdateUserPassword extends UserProfileEvent {
  final String newPassword;

  const UpdateUserPassword(this.newPassword);

  @override
  List<Object> get props => [newPassword];
}
