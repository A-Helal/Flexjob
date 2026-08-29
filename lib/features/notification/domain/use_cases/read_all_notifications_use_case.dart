import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/notification/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReadAllNotificationsUseCase {
  const ReadAllNotificationsUseCase({required this.repository});

  final NotificationRepository repository;

  Future<Either<Failure, bool>> call() => repository.readAllNotifications();
}