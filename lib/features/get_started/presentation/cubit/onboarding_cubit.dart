import 'package:bloc/bloc.dart';
import 'package:flexiJobs/features/get_started/presentation/cubit/onboarding_state.dart';

export 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {

  OnboardingCubit() : super(const OnboardingState.initial());

  Future<void> completeOnboarding() async {
    emit(const OnboardingState.completed());
  }
}
