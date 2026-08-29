part of 'user_cubit.dart';

abstract class UserState  {
}

class UserInitialState extends UserState {}
class UserLoadingState extends UserState {}
class UserReadyState extends UserState {}
class UserDeletedState extends UserState {}
class UserErrorState extends UserState {
  UserErrorState({
 required this.message,
});
 final String message;

}
