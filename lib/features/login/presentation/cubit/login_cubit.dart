import 'package:bloc/bloc.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/login/data/models/request/login_request_model.dart';
import 'package:flexiJobs/features/login/domain/use_cases/login_use_case.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUseCase}) : super(LoginInitialState());

  final LoginUseCase loginUseCase;

  Future<void> login({required LoginRequestModel loginRequestModel}) async {
    emit(LoginLoadingState());
    final CustomResponseType<String> result =
        await loginUseCase(loginRequestModel);

    await result.fold(
      (Failure failure) async {
        emit(LoginErrorState(
            message: FailureToMessage().map(failure)));
      },
      (String response) async {
        if (!loginRequestModel.isGuest) {
          await LocalData.setSecureEmail(loginRequestModel.email);
          await LocalData.setSecurePassword(loginRequestModel.password);
          await LocalData.setFirstLoginWithInfo();
        }
        if (response.contains('@')) {
          emit(EmailVervicationNeededReadyState(response));
        } else {
          await LocalData.setToken(response);
          emit(LoginReadyState());
        }
      },
    );
  }
}
