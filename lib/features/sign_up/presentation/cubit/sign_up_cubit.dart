import 'package:bloc/bloc.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/sign_up_request_model.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/vendor_requet_model.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/verify_code_request_model.dart';
import 'package:flexiJobs/features/sign_up/domain/use_cases/resend_code_use_case.dart';
import 'package:flexiJobs/features/sign_up/domain/use_cases/send_vendor_email_use_case.dart';
import 'package:flexiJobs/features/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:flexiJobs/features/sign_up/domain/use_cases/verify_code_use_case.dart';
import 'package:injectable/injectable.dart';

part 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required this.signUpUseCase,
    required this.verifyCodeUseCase,
    required this.resendCodeUseCase,
    required this.sendVendorEmailUseCase
  }) : super(SignUpInitialState());

  final SignUpUseCase signUpUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;
  final ResendCodeUseCase resendCodeUseCase;
  final SendVendorEmailUseCase sendVendorEmailUseCase;

  Future<void> signUp({required SignUpRequestModel signUpRequestModel}) async {
    emit(SignUpLoadingState());
    final CustomResponseType<String> eitherPackagesOrFailure = await signUpUseCase(signUpRequestModel);

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(SignUpErrorState(message: FailureToMessage().map(failure)));
    }, (String response) {
      emit(SignUpReadyState(email: response));
    });
  }

  Future<void> verifyCode({required VerifyCodeRequestModel verifyCodeRequestModel}) async {
    emit(
      SignUpReadyState(email: verifyCodeRequestModel.email, inProgress: true),
    );
    final CustomResponseType<String> eitherPackagesOrFailure = await verifyCodeUseCase(verifyCodeRequestModel);

    await eitherPackagesOrFailure.fold(
      (Failure failure) async {
        emit(SignUpErrorState(message: FailureToMessage().map(failure)));
      },
      (String response) async {
        await LocalData.setToken(response);
        emit(VerifyReadyState(token: response));
      },
    );
  }

  Future<void> resendCode({required String email}) async {
    emit(
      SignUpReadyState(email: email, inProgress: true),
    );

    final CustomResponseType<String> eitherPackagesOrFailure = await resendCodeUseCase(email);

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(SignUpErrorState(message: FailureToMessage().map(failure)));
    }, (String response) {
      emit(ResendCodeReadyState());
    });
  }

  Future<void> sendVendorEmail({required VendorRequestModel vendorRequestModel}) async {
    emit(
     SignUpLoadingState()
    );

    final CustomResponseType<String> eitherPackagesOrFailure = await sendVendorEmailUseCase(vendorRequestModel);

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(SignUpErrorState(message: FailureToMessage().map(failure)));
    }, (String response) {
      emit(SendVendorEmailReadyState());
    });
  }
}
