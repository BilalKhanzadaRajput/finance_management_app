import 'package:equatable/equatable.dart';

// Define Profile State
class UserProfileState extends Equatable {
  final String fullName;
  final String email;
  final String phone;
  final bool isFetchingProfile;
  final bool profileFetchFailed;
  final bool nameUpdateSuccess;
  final bool passwordUpdateSuccess;
  final String errorMessage;

  const UserProfileState({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.isFetchingProfile = false,
    this.profileFetchFailed = false,
    this.nameUpdateSuccess = false,
    this.passwordUpdateSuccess = false,
    this.errorMessage = '',
  });

  UserProfileState copyWith({
    String? fullName,
    String? email,
    String? phone,
    bool? isFetchingProfile,
    bool? profileFetchFailed,
    bool? nameUpdateSuccess,
    bool? passwordUpdateSuccess,
    String? errorMessage,
  }) {
    return UserProfileState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isFetchingProfile: isFetchingProfile ?? this.isFetchingProfile,
      profileFetchFailed: profileFetchFailed ?? this.profileFetchFailed,
      nameUpdateSuccess: nameUpdateSuccess ?? this.nameUpdateSuccess,
      passwordUpdateSuccess: passwordUpdateSuccess ?? this.passwordUpdateSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        fullName,
        email,
        phone,
        isFetchingProfile,
        profileFetchFailed,
        nameUpdateSuccess,
        passwordUpdateSuccess,
        errorMessage,
      ];
}
