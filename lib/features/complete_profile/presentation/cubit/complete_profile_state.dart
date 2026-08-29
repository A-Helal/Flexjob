part of 'complete_profile_cubit.dart';

abstract class CompleteProfileState {}

class CompleteProfileInitialState extends CompleteProfileState {}

class CompleteProfileLoadingState extends CompleteProfileState {}

class CompleteProfileReadyState extends CompleteProfileState {}

class CompleteProfileErrorState extends CompleteProfileState {
  CompleteProfileErrorState({
    required this.  message,
  });
  final String message;
}
