import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/notification/data/models/request/notification_request_model.dart';
import 'package:flexiJobs/features/notification/data/models/response/notification_dto.dart';
import 'package:injectable/injectable.dart';

typedef _ApiResult = ({dynamic response, bool success});

abstract class NotificationRemoteDataSource {
  Future<Either<Failure, ({List<NotificationDto> items, int total})>> getAllNotifications(
      NotificationRequestModel request,
      );

  Future<Either<Failure, bool>> readAllNotifications();
}

@Injectable(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  const NotificationRemoteDataSourceImpl(this._networkHelper);

  final NetworkHelper _networkHelper;

  @override
  Future<Either<Failure, ({List<NotificationDto> items, int total})>> getAllNotifications(
      NotificationRequestModel request,
      ) async {
    final _ApiResult result = await _networkHelper.get(
      path: ApiConstants.notifications,
      queryParams: request.toJson(),
    );

    if (!result.success) {
      return left(ServerFailure(message: result.response as String));
    }

    final notifData = result.response['data']?['notifications'];
    if (notifData == null) {
      return right((items: const <NotificationDto>[], total: 0));
    }

    final rawList = notifData['data'];
    final int total = (notifData['total'] as num?)?.toInt() ?? 0;

    if (rawList is! List) {
      return right((items: const <NotificationDto>[], total: 0));
    }

    final List<NotificationDto> items = rawList
        .whereType<Map<String, dynamic>>()
        .map(NotificationDto.fromJson)
        .toList();

    return right((items: items, total: total));
  }

  @override
  Future<Either<Failure, bool>> readAllNotifications() async {
    final _ApiResult result = await _networkHelper.post(
      path: ApiConstants.readAllNotifications,
    );

    return result.success
        ? right(true)
        : left(ServerFailure(message: result.response as String));
  }
}