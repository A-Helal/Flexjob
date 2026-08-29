import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/forget_password/data/data_sources/forget_password_data_sources.dart';
import 'package:flexiJobs/features/forget_password/data/models/request/create_new_password_request_model.dart';
import 'package:flexiJobs/features/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRepository)
class ForgetPasswordRepositoryImp implements ForgetPasswordRepository {
  ForgetPasswordRepositoryImp({
    required this.forgetPasswordDataSources,
  });

  final ForgetPasswordDataSources forgetPasswordDataSources;

  @override
  Future<CustomResponseType<String>> createNewPassword({
    required CreateNewPasswordRequestModel createNewPasswordRequestModel,
  }) async {
    return forgetPasswordDataSources.createNewPassword(
      createNewPasswordRequestModel: createNewPasswordRequestModel,
    );
  }
}
