import 'package:dio/src/form_data.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

abstract class MoreRemoteDataSource {
  Future<CustomResponseType<bool>> uploadVideo({required FormData file});
}

@Injectable(as: MoreRemoteDataSource)
class MoreRemoteDataSourceImpl implements MoreRemoteDataSource {
  MoreRemoteDataSourceImpl(this.networkHelper);
  final NetworkHelper networkHelper;

  @override
  Future<CustomResponseType<bool>> uploadVideo({required FormData file}) async {
    ({dynamic response, bool success}) result = await networkHelper.post(path: ApiConstants.uploadVideo, data: file);

    if (result.success) {
      return right(result.success);
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }
}
