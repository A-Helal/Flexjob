 import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/login/data/models/request/login_request_model.dart';
import 'package:flexiJobs/features/login/domain/repositories/login_repository.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/sign_up_request_model.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/verify_code_request_model.dart';
import 'package:flexiJobs/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:injectable/injectable.dart';
 


@injectable
class VerifyCodeUseCase implements UseCase<String, VerifyCodeRequestModel> {
  VerifyCodeUseCase({required this.signUpRepository});
  final SignUpRepository signUpRepository;

  @override
  Future<CustomResponseType<String>> call(
     VerifyCodeRequestModel verifyCodeRequestModel,
  ) async {
    return signUpRepository.verifyCode(
     verifyCodeRequestModel:verifyCodeRequestModel,
    );
  }
}
