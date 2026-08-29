import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/core/app_data/data/models/response/app_user_response_model.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';

abstract class UserRemoteDataSource {
  Future<CustomResponseType<AppUserModel>> getUserInfo(
      {required BaseRequestModel baseRequestModel});
  Future<CustomResponseType<String>> deleteUser(
    );

      
}

@Injectable(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl(this.networkHelper);
  final NetworkHelper networkHelper;

  @override
  Future<CustomResponseType<AppUserModel>> getUserInfo(
      {required BaseRequestModel baseRequestModel}) async {
      Map<String, dynamic>? queryParams = <String, dynamic>{};
    for (int i = 0; i < baseRequestModel.relatedObjects!.length; i++) {
      queryParams["related_objects[$i]"] = baseRequestModel.relatedObjects![i];
    }
    ({dynamic response, bool success}) result = await networkHelper.get(
        path: ApiConstants.getAppUserInfo, queryParams: queryParams);

    if (result.success) {
      return right(AppUserModel.fromJson(result.response['data']['app_users']));
    } else {
      return left(ServerFailure(message: result.response as String));
    }

    
  }

   
    @override
    Future<CustomResponseType<String>> deleteUser() async {
      ({dynamic response, bool success}) result =
          await networkHelper.post(path: ApiConstants.deleteUser);
  
      if (result.success) {
        return right("Success");
      } else {
        return left(ServerFailure(message: result.response as String));
      }
    }
  
}
