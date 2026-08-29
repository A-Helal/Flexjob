import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/jobs/data/data_sources/job_data_source.dart';
import 'package:flexiJobs/features/jobs/data/models/request/jobs_request_model.dart';
import 'package:flexiJobs/features/jobs/data/models/response/jobs_list_dto.dart';
import 'package:flexiJobs/features/jobs/data/models/response/upcoming_shift_dto.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_filter_params.dart';
import 'package:flexiJobs/features/jobs/domain/entities/jobs_list_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/upcoming_shift_entity.dart';
import 'package:flexiJobs/features/jobs/domain/repositories/job_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: JobRepository)
class JobRepositoryImpl implements JobRepository {
  const JobRepositoryImpl({required this.remoteDataSource});

  final JobRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<JobsListEntity>>> getAvailableJobs(
    JobFilterParams params,
  ) async {
    final Either<Failure, List<JobsListDto>> result = await remoteDataSource
        .getAvailableJobs(
          JobsRequestModel(
            page: params.page,
            pageSize: params.pageSize,
            governorateId: params.governorateId,
            jobCategoryId: params.jobCategoryId,
          ),
        );

    return result.fold(
      left,
      (List<JobsListDto> DTOs) =>
          right(DTOs.map((JobsListDto DTO) => DTO.toEntity()).toList()),
    );
  }

  @override
  Future<int> getUnreadNotificationsCount() =>
      remoteDataSource.getUnreadNotificationsCount();

  @override
  Future<Either<Failure, UpcomingShiftEntity?>> getUpcomingShift() async {
    final Either<Failure, UpcomingShiftDto?> result = await remoteDataSource
        .getUpcomingShift();
    return result.fold(left, (UpcomingShiftDto? DTO) => right(DTO?.toEntity()));
  }
}
