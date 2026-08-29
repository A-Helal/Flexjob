import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState.initial() = _OnboardingInitial;

  const factory OnboardingState.loading() = _OnboardingLoading;

  const factory OnboardingState.completed() = _OnboardingCompleted;

  const factory OnboardingState.error() = _OnboardingError;
}
