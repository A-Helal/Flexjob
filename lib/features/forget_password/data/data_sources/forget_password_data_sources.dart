import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/forget_password/data/models/request/create_new_password_request_model.dart';
import 'package:injectable/injectable.dart';

abstract class ForgetPasswordDataSources {
  Future<CustomResponseType<String>> createNewPassword({
    required CreateNewPasswordRequestModel createNewPasswordRequestModel,
  });
}

@Injectable(as: ForgetPasswordDataSources)
class ForgetPasswordDataSourcesImpl implements ForgetPasswordDataSources {
  ForgetPasswordDataSourcesImpl(this.networkHelper);

  final NetworkHelper networkHelper;

  @override
  Future<CustomResponseType<String>> createNewPassword({
    required CreateNewPasswordRequestModel createNewPasswordRequestModel,
  }) async {
    final ({bool success, dynamic response}) result =
        await networkHelper.post(
      path: ApiConstants.changePassword,
      data: createNewPasswordRequestModel.toJson(),
    );

    if (result.success) {
      return right('Success');
    }
    return left(ServerFailure(message: result.response as String));
  }
}
