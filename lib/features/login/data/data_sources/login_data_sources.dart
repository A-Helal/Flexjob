import 'package:flexiJobs/features/login/data/models/request/login_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';

abstract class LoginRemoteDataSource {
  Future<CustomResponseType<String>> login({required LoginRequestModel loginRequestModel});
}

@Injectable(as: LoginRemoteDataSource)
class DataSourceNameRemoteDataSourceImpl implements LoginRemoteDataSource {
  DataSourceNameRemoteDataSourceImpl(this.networkHelper);
  final NetworkHelper networkHelper;

  @override
  Future<CustomResponseType<String>> login({required LoginRequestModel loginRequestModel}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.post(path: ApiConstants.login, data: loginRequestModel.toJson());

    if (result.success) {
      if (result.response['data']['users']['userable']['email_verified_at'] == null) {
        return right((result.response['data']['users']['email']));
      }

      return right((result.response['data']['token']));
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }
}
