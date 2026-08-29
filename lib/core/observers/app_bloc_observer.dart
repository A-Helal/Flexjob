import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flexiJobs/core/utils/log_utils.dart';
import 'package:flutter/foundation.dart';

/// Centralized BlocObserver that logs state transitions in debug mode
/// and records errors to Firebase Crashlytics in production.
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    Log.e('[${bloc.runtimeType}] error: $error\n$stackTrace');
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      Log.d(
        '[${bloc.runtimeType}] '
        '${change.currentState.runtimeType} → ${change.nextState.runtimeType}',
      );
    }
  }
}
