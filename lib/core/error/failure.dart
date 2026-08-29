import 'package:equatable/equatable.dart';
import 'package:flexiJobs/core/error/network_constant.dart';

/// Base class for all domain-layer failures.
abstract class Failure extends Equatable {
  const Failure();
}

class ServerFailure extends Failure {
  const ServerFailure({this.message});

  final String? message;

  @override
  List<Object?> get props => <Object?>[message];
}

class NetworkFailure extends Failure {
  const NetworkFailure();

  @override
  List<Object?> get props => <Object?>[];
}

class CacheFailure extends Failure {
  const CacheFailure();

  @override
  List<Object?> get props => <Object?>[];
}

/// Maps a [Failure] to a user-readable message.
class FailureToMessage {
  String map(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message ??
            NetworkString.serverFailureMessage;
      case CacheFailure:
        return NetworkString.cacheFailureMessage;
      case NetworkFailure:
        return NetworkString.networkFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}

/// Legacy alias — prefer [FailureToMessage] going forward.
@Deprecated('Use FailureToMessage instead')
class FailureToMassage {
  String mapFailureToMessage(Failure failure) => FailureToMessage().map(failure);
}
