import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/notification/domain/entities/notification_entity.dart';
import 'package:flexiJobs/features/notification/domain/entities/paginated_result.dart';

abstract class NotificationRepository {
 Future<Either<Failure, PaginatedResult<NotificationEntity>>> getAllNotifications({
  required int page,
  required int pageSize,
 });

 Future<Either<Failure, bool>> readAllNotifications();
}