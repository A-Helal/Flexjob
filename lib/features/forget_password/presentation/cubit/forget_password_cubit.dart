// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/forget_password/data/models/request/create_new_password_request_model.dart';
import 'package:flexiJobs/features/forget_password/domain/use_cases/create_new_password_use_case.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/verify_code_request_model.dart';
import 'package:flexiJobs/features/sign_up/domain/use_cases/resend_code_use_case.dart';
import 'package:flexiJobs/features/sign_up/domain/use_cases/verify_code_use_case.dart';
import 'package:injectable/injectable.dart';

part 'forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit({
    required this.resendCodeUseCase,
    required this.createNewPasswordUseCase,
    required this.verifyCodeUseCase,
  }) : super(ForgetPasswordInitialState());

  final ResendCodeUseCase resendCodeUseCase;
  final CreateNewPasswordUseCase createNewPasswordUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;

  Future<void> forgetPassword({required String email}) async {
    // Alias for resendCode (sends initial reset email)
    await resendCode(email: email);
  }

  Future<void> showVerification(String email) async {
    emit(ForgetPasswordReadyState(verifyStep: true, email: email));
  }

  Future<void> resendCode({
    required String email,
    bool fromVerify = false,
  }) async {
    emit(ForgetPasswordReadyState(
      email: email,
      inProgress: true,
      enterEmailStep: fromVerify ? false : true,
      fromVerify: fromVerify,
    ));

    final CustomResponseType<String> result = await resendCodeUseCase(email);

    result.fold(
      (Failure failure) => emit(ForgetPasswordReadyState(
        email: email,
        errorMessage: FailureToMessage().map(failure),
        enterEmailStep: true,
      )),
      (String response) =>
          emit(ForgetPasswordReadyState(verifyStep: true, email: email)),
    );
  }

  Future<void> changePassword({
    required CreateNewPasswordRequestModel createNewPasswordRequestModel,
  }) async {
    emit(ForgetPasswordReadyState(
      inProgress: true,
      createNewPasswordStep: true,
      token: createNewPasswordRequestModel.token,
    ));

    final CustomResponseType<String> result =
        await createNewPasswordUseCase(createNewPasswordRequestModel);

    result.fold(
      (Failure failure) => emit(ForgetPasswordReadyState(
        errorMessage: FailureToMessage().map(failure),
        createNewPasswordStep: true,
      )),
      (String response) => emit(ForgetPasswordReadyState(
        passwordChanged: true,
        token: createNewPasswordRequestModel.token,
      )),
    );
  }

  Future<void> verifyCode({
    required VerifyCodeRequestModel verifyCodeRequestModel,
  }) async {
    emit(ForgetPasswordReadyState(
      email: verifyCodeRequestModel.email,
      verifyStep: true,
      inProgress: true,
    ));

    final CustomResponseType<String> result =
        await verifyCodeUseCase(verifyCodeRequestModel);

    result.fold(
      (Failure failure) => emit(ForgetPasswordReadyState(
        email: verifyCodeRequestModel.email,
        errorMessage: FailureToMessage().map(failure),
        verifyStep: true,
      )),
      (String response) => emit(ForgetPasswordReadyState(
        token: response,
        verifyStep: false,
        createNewPasswordStep: true,
      )),
    );
  }
}
