part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => <Object?>[];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationLoaded extends NotificationState {
  const NotificationLoaded({
    required this.notifications,
    required this.total,
    required this.currentPage,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<NotificationEntity> notifications;
  final int total;
  final int currentPage;
  final bool isLoadingMore;

  /// Non-null when a `loadMore` request failed.  Callers should show
  /// a snack-bar and clear this after it has been consumed.
  final String? loadMoreError;

  bool get hasMore => notifications.length < total;

  NotificationLoaded copyWith({
    List<NotificationEntity>? notifications,
    int? total,
    int? currentPage,
    bool? isLoadingMore,
    String? loadMoreError,
  }) =>
      NotificationLoaded(
        notifications: notifications ?? this.notifications,
        total: total ?? this.total,
        currentPage: currentPage ?? this.currentPage,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        loadMoreError: loadMoreError,
      );

  @override
  List<Object?> get props =>
      <Object?>[notifications, total, currentPage, isLoadingMore, loadMoreError];
}

class NotificationError extends NotificationState {
  const NotificationError({required this.message});

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
