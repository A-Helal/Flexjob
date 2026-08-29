import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/notification/domain/entities/notification_entity.dart';
import 'package:flexiJobs/features/notification/domain/entities/paginated_result.dart';
import 'package:flexiJobs/features/notification/domain/use_cases/get_all_notifications_use_case.dart';
import 'package:flexiJobs/features/notification/domain/use_cases/read_all_notifications_use_case.dart';
import 'package:injectable/injectable.dart';

part 'notification_state.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({
    required this.getAllNotificationsUseCase,
    required this.readAllNotificationsUseCase,
  }) : super(const NotificationInitial());

  final GetAllNotificationsUseCase getAllNotificationsUseCase;
  final ReadAllNotificationsUseCase readAllNotificationsUseCase;

  static const int _pageSize = 10;

  Future<void> loadInitial() async {
    emit(const NotificationLoading());

    // Fan out: fetch first page and mark all read concurrently.
    // Failures from readAll are intentionally non-fatal — they do not prevent
    // notifications from loading.
    await Future.wait<dynamic>(<Future<dynamic>>[
      _fetchPage(page: 1),
      readAllNotificationsUseCase(),
    ]);
  }

  Future<void> loadMore() async {
    final NotificationState current = state;
    if (current is! NotificationLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }

    emit(current.copyWith(isLoadingMore: true));

    final int nextPage = current.currentPage + 1;
    final Either<Failure, PaginatedResult<NotificationEntity>> result =
        await getAllNotificationsUseCase(page: nextPage, pageSize: _pageSize);

    result.fold(
      (Failure failure) => emit(current.copyWith(
        isLoadingMore: false,
        loadMoreError: FailureToMessage().map(failure),
      )),
      (PaginatedResult<NotificationEntity> paginated) => emit(
        current.copyWith(
          notifications: <NotificationEntity>[
            ...current.notifications,
            ...paginated.items,
          ],
          total: paginated.total,
          currentPage: nextPage,
          isLoadingMore: false,
        ),
      ),
    );
  }

  Future<void> _fetchPage({required int page}) async {
    final Either<Failure, PaginatedResult<NotificationEntity>> result =
        await getAllNotificationsUseCase(page: page, pageSize: _pageSize);

    result.fold(
      (Failure failure) =>
          emit(NotificationError(message: FailureToMessage().map(failure))),
      (PaginatedResult<NotificationEntity> paginated) => emit(
        NotificationLoaded(
          notifications: paginated.items,
          total: paginated.total,
          currentPage: page,
        ),
      ),
    );
  }
}
