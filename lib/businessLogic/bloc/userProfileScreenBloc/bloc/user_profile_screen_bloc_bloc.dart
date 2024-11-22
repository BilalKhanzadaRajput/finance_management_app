import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fm_app/businessLogic/bloc/userProfileScreenBloc/bloc/user_profile_screen_bloc_event.dart';
import 'package:fm_app/businessLogic/bloc/userProfileScreenBloc/bloc/user_profile_screen_bloc_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  UserProfileBloc() : super(const UserProfileState()) {
    on<FetchUserProfile>(_onFetchUserProfile);
    on<UpdateUserName>(_onUpdateUserName);
    on<UpdateUserPassword>(_onUpdateUserPassword);
  }

  Future<void> _onFetchUserProfile(
      FetchUserProfile event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(isFetchingProfile: true, profileFetchFailed: false));

    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        final userDoc = await _database.collection('users').doc(userId).get();
        final userData = userDoc.data() ?? {};
        emit(state.copyWith(
          fullName: userData['fullName'] ?? '',
          email: userData['email'] ?? '',
          phone: userData['phoneNumber'] ?? '',
          isFetchingProfile: false,
        ));
      } else {
        emit(state.copyWith(
            isFetchingProfile: false,
            profileFetchFailed: true,
            errorMessage: 'User not logged in'));
      }
    } catch (e) {
      emit(state.copyWith(
          isFetchingProfile: false,
          profileFetchFailed: true,
          errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateUserName(
      UpdateUserName event, Emitter<UserProfileState> emit) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        await _database.collection('users').doc(userId).update({'fullName': event.newName});
        emit(state.copyWith(nameUpdateSuccess: true, fullName: event.newName));
      }
    } catch (e) {
      emit(state.copyWith(nameUpdateSuccess: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateUserPassword(
      UpdateUserPassword event, Emitter<UserProfileState> emit) async {
    try {
      await _auth.currentUser?.updatePassword(event.newPassword);
      emit(state.copyWith(passwordUpdateSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          passwordUpdateSuccess: false, errorMessage: e.toString()));
    }
  }
}
