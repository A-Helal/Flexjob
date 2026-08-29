part of 'login_cubit.dart';

abstract class LoginState {
  const LoginState();

 
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginReadyState extends LoginState {
  LoginReadyState();
}

class EmailVervicationNeededReadyState extends LoginState {
  EmailVervicationNeededReadyState(this.email);
 final  String email;
}

class LoginErrorState extends LoginState {
  LoginErrorState({required this.message});
  final String message;
}
