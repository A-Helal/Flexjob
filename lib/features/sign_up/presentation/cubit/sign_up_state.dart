part of 'sign_up_cubit.dart';

abstract class SignUpState  {
}

class SignUpInitialState extends SignUpState {}
class SignUpLoadingState extends SignUpState {}
class SendVendorEmailReadyState extends SignUpState {}
class SignUpReadyState extends SignUpState {
  SignUpReadyState({required this.email,this.inProgress=false});

final bool inProgress;
  final String email;
}
class SignUpErrorState extends SignUpState {
SignUpErrorState({
 required this.message,
});
 final String message;
}


class VerifyReadyState extends SignUpState {
  VerifyReadyState({required this.token});


  final String token;
}
class ResendCodeReadyState extends SignUpState {
  ResendCodeReadyState();


}