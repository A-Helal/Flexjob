import 'package:flexiJobs/core/app_data/data/data_sources/governorate_data_sources.dart';
import 'package:flexiJobs/core/app_data/data/models/response/governorate_response_model.dart';
import 'package:flexiJobs/core/app_data/domain/repositories/governorate_repository.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
// ignore: unused_import
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

@Injectable(as: GovernorateRepository)
class GovernorateRepositoryImp implements GovernorateRepository {
  GovernorateRepositoryImp({
    required this.governorateRemoteDataSource,
  });
  final GovernorateRemoteDataSource governorateRemoteDataSource;

  Future<CustomResponseType<GovernorateResponseModel>> getGovernorates(
      {required BaseRequestModel baseRequestModel}) async {
    return governorateRemoteDataSource.getGovernorates(
        baseRequestModel: baseRequestModel);
  }
}
