 import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/login/data/models/request/login_request_model.dart';
import 'package:flexiJobs/features/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';
 


@injectable
class LoginUseCase implements UseCase<String, LoginRequestModel> {
  LoginUseCase({required this.loginRepository});
  final LoginRepository loginRepository;

  @override
  Future<CustomResponseType<String>> call(
     LoginRequestModel  loginRequestModel,
  ) async {
    return loginRepository.login(
     loginRequestModel:loginRequestModel,
    );
  }
}
