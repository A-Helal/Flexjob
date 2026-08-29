import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/forget_password/data/models/request/create_new_password_request_model.dart';

abstract class ForgetPasswordRepository {
  Future<CustomResponseType<String>> createNewPassword({
    required CreateNewPasswordRequestModel createNewPasswordRequestModel,
  });
}
