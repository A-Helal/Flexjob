import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/notification/domain/entities/notification_entity.dart';
import 'package:flexiJobs/features/notification/domain/entities/paginated_result.dart';
import 'package:flexiJobs/features/notification/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllNotificationsUseCase {
  const GetAllNotificationsUseCase({required this.repository});

  final NotificationRepository repository;

  Future<Either<Failure, PaginatedResult<NotificationEntity>>> call({
    required int page,
    int pageSize = 10,
  }) =>
      repository.getAllNotifications(page: page, pageSize: pageSize);
}