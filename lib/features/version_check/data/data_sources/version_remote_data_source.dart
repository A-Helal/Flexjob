import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/version_check/data/models/app_version_model.dart';

abstract class VersionRemoteDataSource {
  Future<CustomResponseType<AppVersionModel>> getAppVersion();
}

@Injectable(as: VersionRemoteDataSource)
class VersionRemoteDataSourceImpl implements VersionRemoteDataSource {
  VersionRemoteDataSourceImpl(this.networkHelper);
  final NetworkHelper networkHelper;

  @override
  Future<CustomResponseType<AppVersionModel>> getAppVersion() async {
    ({dynamic response, bool success}) result =
        await networkHelper.get(path: ApiConstants.getAppVersion);

    if (result.success) {
      return right(AppVersionModel.fromJson(result.response['data']));
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }
}
