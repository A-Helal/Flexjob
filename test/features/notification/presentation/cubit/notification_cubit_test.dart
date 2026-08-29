import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/notification/domain/entities/notification_entity.dart';
import 'package:flexiJobs/features/notification/domain/entities/paginated_result.dart';
import 'package:flexiJobs/features/notification/domain/use_cases/get_all_notifications_use_case.dart';
import 'package:flexiJobs/features/notification/domain/use_cases/read_all_notifications_use_case.dart';
import 'package:flexiJobs/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllNotificationsUseCase extends Mock
    implements GetAllNotificationsUseCase {}

class MockReadAllNotificationsUseCase extends Mock
    implements ReadAllNotificationsUseCase {}

void main() {
  late MockGetAllNotificationsUseCase mockGetAll;
  late MockReadAllNotificationsUseCase mockReadAll;
  late NotificationCubit cubit;

  final DateTime tDate = DateTime(2024, 1, 1);

  final List<NotificationEntity> tNotifications = <NotificationEntity>[
    NotificationEntity(
      id: 1,
      title: 'Test notification',
      description: 'Description',
      createdAt: tDate,
    ),
  ];

  final PaginatedResult<NotificationEntity> tPaginated =
      PaginatedResult<NotificationEntity>(
    items: tNotifications,
    total: 1,
  );

  setUp(() {
    mockGetAll = MockGetAllNotificationsUseCase();
    mockReadAll = MockReadAllNotificationsUseCase();
    cubit = NotificationCubit(
      getAllNotificationsUseCase: mockGetAll,
      readAllNotificationsUseCase: mockReadAll,
    );
  });

  tearDown(() => cubit.close());

  group('NotificationCubit.loadInitial', () {
    blocTest<NotificationCubit, NotificationState>(
      'emits [Loading, Loaded] when fetch succeeds',
      build: () {
        when(() => mockGetAll(page: 1, pageSize: 10))
            .thenAnswer((_) async => right(tPaginated));
        when(() => mockReadAll()).thenAnswer((_) async => right(true));
        return cubit;
      },
      act: (NotificationCubit c) => c.loadInitial(),
      expect: () => <TypeMatcher<NotificationState>>[
        isA<NotificationLoading>(),
        isA<NotificationLoaded>(),
      ],
    );

    blocTest<NotificationCubit, NotificationState>(
      'emits [Loading, Error] when fetch fails',
      build: () {
        when(() => mockGetAll(page: 1, pageSize: 10))
            .thenAnswer((_) async => left(const NetworkFailure()));
        when(() => mockReadAll()).thenAnswer((_) async => right(true));
        return cubit;
      },
      act: (NotificationCubit c) => c.loadInitial(),
      expect: () => <TypeMatcher<NotificationState>>[
        isA<NotificationLoading>(),
        isA<NotificationError>(),
      ],
    );

    blocTest<NotificationCubit, NotificationState>(
      'still loads when readAll fails',
      build: () {
        when(() => mockGetAll(page: 1, pageSize: 10))
            .thenAnswer((_) async => right(tPaginated));
        when(() => mockReadAll())
            .thenAnswer((_) async => left(const NetworkFailure()));
        return cubit;
      },
      act: (NotificationCubit c) => c.loadInitial(),
      expect: () => <TypeMatcher<NotificationState>>[
        isA<NotificationLoading>(),
        isA<NotificationLoaded>(),
      ],
    );
  });

  group('NotificationCubit.loadMore', () {
    blocTest<NotificationCubit, NotificationState>(
      'emits updated Loaded state with appended notifications',
      build: () {
        when(() => mockGetAll(page: 2, pageSize: 10))
            .thenAnswer((_) async => right(tPaginated));
        return cubit;
      },
      seed: () => NotificationLoaded(
        notifications: tNotifications,
        total: 5,
        currentPage: 1,
      ),
      act: (NotificationCubit c) => c.loadMore(),
      expect: () => <dynamic>[
        isA<NotificationLoaded>().having(
          (NotificationLoaded s) => s.isLoadingMore,
          'isLoadingMore',
          true,
        ),
        isA<NotificationLoaded>().having(
          (NotificationLoaded s) => s.notifications.length,
          'notifications.length',
          2,
        ),
      ],
    );

    blocTest<NotificationCubit, NotificationState>(
      'emits loadMoreError when page fetch fails',
      build: () {
        when(() => mockGetAll(page: 2, pageSize: 10))
            .thenAnswer((_) async => left(const NetworkFailure()));
        return cubit;
      },
      seed: () => NotificationLoaded(
        notifications: tNotifications,
        total: 5,
        currentPage: 1,
      ),
      act: (NotificationCubit c) => c.loadMore(),
      expect: () => <dynamic>[
        isA<NotificationLoaded>().having(
          (NotificationLoaded s) => s.isLoadingMore,
          'isLoadingMore',
          true,
        ),
        isA<NotificationLoaded>().having(
          (NotificationLoaded s) => s.loadMoreError,
          'loadMoreError',
          isNotNull,
        ),
      ],
    );

    blocTest<NotificationCubit, NotificationState>(
      'does nothing when already loading more',
      build: () => cubit,
      seed: () => NotificationLoaded(
        notifications: tNotifications,
        total: 5,
        currentPage: 1,
        isLoadingMore: true,
      ),
      act: (NotificationCubit c) => c.loadMore(),
      expect: () => <NotificationState>[],
    );

    blocTest<NotificationCubit, NotificationState>(
      'does nothing when there are no more pages',
      build: () => cubit,
      seed: () => NotificationLoaded(
        notifications: tNotifications,
        total: 1,
        currentPage: 1,
      ),
      act: (NotificationCubit c) => c.loadMore(),
      expect: () => <NotificationState>[],
    );
  });
}
