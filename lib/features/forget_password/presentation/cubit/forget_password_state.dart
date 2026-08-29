// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forget_password_cubit.dart';

abstract class ForgetPasswordState {}

class ForgetPasswordInitialState extends ForgetPasswordState {}

class ForgetPasswordLoadingState extends ForgetPasswordState {}

class ForgetPasswordReadyState extends ForgetPasswordState {
  ForgetPasswordReadyState({
    this.inProgress = false,
    this.email,
    this.verifyStep = false,
    this.enterEmailStep = false,
    this.passwordChanged = false,
    this.createNewPasswordStep = false,
    this.errorMessage,
    this.token,
    this.fromVerify = false,
  });

  final bool? verifyStep;
  final bool? enterEmailStep;
  final bool? fromVerify;
  final bool? createNewPasswordStep;
  final bool? inProgress;
  final bool? passwordChanged;
  final String? email;
  final String? errorMessage;
  final String? token;
}

class ForgetPasswordErrorState extends ForgetPasswordState {
  ForgetPasswordErrorState({required this.message});

  final String message;
}

class ResendCodeReadyState extends ForgetPasswordState {}
