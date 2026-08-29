import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/notification/data/data_sources/notification_remote_data_sources.dart';
import 'package:flexiJobs/features/notification/data/models/request/notification_request_model.dart';
import 'package:flexiJobs/features/notification/data/models/response/notification_dto.dart';
import 'package:flexiJobs/features/notification/domain/entities/notification_entity.dart';
import 'package:flexiJobs/features/notification/domain/entities/paginated_result.dart';
import 'package:flexiJobs/features/notification/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl({required this.remoteDataSource});

  final NotificationRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, PaginatedResult<NotificationEntity>>> getAllNotifications({
    required int page,
    required int pageSize,
  }) async {
    final Either<Failure, ({List<NotificationDto> items, int total})> result = await remoteDataSource.getAllNotifications(
      NotificationRequestModel(page: page, pageSize: pageSize),
    );

    return result.fold(
      left,
          (({List<NotificationDto> items, int total}) data) => right(
        PaginatedResult(
          items: data.items.map((NotificationDto dto) => dto.toEntity()).toList(),
          total: data.total,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> readAllNotifications() =>
      remoteDataSource.readAllNotifications();
}