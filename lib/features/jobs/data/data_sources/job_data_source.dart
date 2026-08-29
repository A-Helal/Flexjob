import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/jobs/data/models/request/jobs_request_model.dart';
import 'package:flexiJobs/features/jobs/data/models/response/jobs_list_dto.dart';
import 'package:flexiJobs/features/jobs/data/models/response/upcoming_shift_dto.dart';
import 'package:injectable/injectable.dart';

typedef _ApiResult = ({dynamic response, bool success});

abstract class JobRemoteDataSource {
  Future<Either<Failure, List<JobsListDto>>> getAvailableJobs(
    JobsRequestModel request,
  );

  Future<int> getUnreadNotificationsCount();

  Future<Either<Failure, UpcomingShiftDto?>> getUpcomingShift();
}

@Injectable(as: JobRemoteDataSource)
class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  const JobRemoteDataSourceImpl(this._networkHelper);

  final NetworkHelper _networkHelper;

  @override
  Future<Either<Failure, List<JobsListDto>>> getAvailableJobs(
    JobsRequestModel request,
  ) async {
    final _ApiResult result = await _networkHelper.get(
      path: ApiConstants.getAvailableJobs,
      queryParams: request.toJson(),
    );

    if (!result.success) {
      return left(ServerFailure(message: result.response as String));
    }

    final dynamic raw = result.response['data']?['job_categories'];
    if (raw == null) return right(const <JobsListDto>[]);

    final List<dynamic> list = raw is List
        ? raw
        : (raw['data'] as List<dynamic>? ?? <dynamic>[]);

    return right(
      list.whereType<Map<String, dynamic>>().map(JobsListDto.fromJson).toList(),
    );
  }

  @override
  Future<int> getUnreadNotificationsCount() async {
    final _ApiResult result = await _networkHelper.get(
      path: ApiConstants.getUnReadNotificationCount,
    );

    if (!result.success) return 0;
    return (result.response['data']?['notifications_count'] as num?)?.toInt() ??
        0;
  }

  @override
  Future<Either<Failure, UpcomingShiftDto?>> getUpcomingShift() async {
    final _ApiResult result = await _networkHelper.get(
      path: ApiConstants.getUpcomingShift,
    );

    if (!result.success) {
      return left(ServerFailure(message: result.response as String));
    }

    final dynamic raw = result.response['data']?['job_attendances'];
    if (raw == null) return right(null);

    return right(UpcomingShiftDto.fromJson(raw as Map<String, dynamic>));
  }
}
