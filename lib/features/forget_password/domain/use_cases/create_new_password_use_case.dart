import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/forget_password/data/models/request/create_new_password_request_model.dart';
import 'package:flexiJobs/features/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateNewPasswordUseCase
    implements UseCase<String, CreateNewPasswordRequestModel> {
  CreateNewPasswordUseCase({required this.forgetPasswordRepository});

  final ForgetPasswordRepository forgetPasswordRepository;

  @override
  Future<CustomResponseType<String>> call(
    CreateNewPasswordRequestModel createNewPasswordRequestModel,
  ) async {
    return forgetPasswordRepository.createNewPassword(
      createNewPasswordRequestModel: createNewPasswordRequestModel,
    );
  }
}
