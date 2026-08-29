part of 'more_cubit.dart';

abstract class MoreState extends Equatable {
  const MoreState();

  @override
  List<Object> get props => <Object>[];
}

class MoreLoadingState extends MoreState {}

class MoreReadyState extends MoreState {}

class MoreErrorState extends MoreState {
  const MoreErrorState({required this.message});
  final String message;
}

class MoreInitial extends MoreState {}
