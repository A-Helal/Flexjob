part of 'governorate_cubit.dart';

abstract class GovernorateState  {
}

class GovernorateInitialState extends GovernorateState {}
class GovernorateLoadingState extends GovernorateState {}
class GovernorateReadyState extends GovernorateState {}
class GovernorateErrorState extends GovernorateState {
  GovernorateErrorState({
 required this.message,
});
 final String message;

} 
  