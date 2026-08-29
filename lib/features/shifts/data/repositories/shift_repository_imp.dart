import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:flexiJobs/features/shifts/data/data_sources/shift_data_sources.dart';
import 'package:flexiJobs/features/shifts/domain/repositories/shift_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ShiftRepository)
class ShiftRepositoryImp implements ShiftRepository {
  ShiftRepositoryImp({
    required this.shiftRemoteDataSource,
  });
  final ShiftRemoteDataSource shiftRemoteDataSource;

  @override
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getUpcomingJobs(
      {required BaseRequestModel baseRequestModel}) async {
    return shiftRemoteDataSource.getUpcomingJobs(baseRequestModel: baseRequestModel);
  }

  @override
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getPastJobs(
      {required BaseRequestModel baseRequestModel}) async {
    return shiftRemoteDataSource.getPastJobs(baseRequestModel: baseRequestModel);
  }

  @override
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> getAppliedJobs(
      {required BaseRequestModel baseRequestModel}) async {
    return shiftRemoteDataSource.getAppliedJobs(baseRequestModel: baseRequestModel);
  }
}
