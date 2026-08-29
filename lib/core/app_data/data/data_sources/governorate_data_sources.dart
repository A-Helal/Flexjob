import 'package:flexiJobs/core/app_data/data/models/response/governorate_response_model.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';

abstract class GovernorateRemoteDataSource {
  Future<CustomResponseType<GovernorateResponseModel>> getGovernorates(
      {required BaseRequestModel baseRequestModel});
}

@Injectable(as: GovernorateRemoteDataSource)
class GovernorateRemoteDataSourceImpl implements GovernorateRemoteDataSource {
  GovernorateRemoteDataSourceImpl(this.networkHelper);
  final NetworkHelper networkHelper;

  @override
  Future<CustomResponseType<GovernorateResponseModel>> getGovernorates(
      {required BaseRequestModel baseRequestModel}) async {
    ({dynamic response, bool success}) result = await networkHelper.post(
        path: ApiConstants.getGovernorates, data: baseRequestModel.toJson());

    if (result.success) {
      return right(GovernorateResponseModel.fromJson(
          result.response['data']['governorates']));
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }
}
