import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/jobs/domain/entities/home_data_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_filter_params.dart';
import 'package:flexiJobs/features/jobs/domain/entities/jobs_list_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/upcoming_shift_entity.dart';
import 'package:flexiJobs/features/jobs/domain/repositories/job_repository.dart';
import 'package:flexiJobs/features/jobs/domain/use_cases/get_home_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockJobRepository extends Mock implements JobRepository {}

void main() {
  late MockJobRepository mockRepository;
  late GetHomeDataUseCase useCase;

  const JobFilterParams params = JobFilterParams();

  setUpAll(() {
    registerFallbackValue(const JobFilterParams());
  });

  setUp(() {
    mockRepository = MockJobRepository();
    useCase = GetHomeDataUseCase(repository: mockRepository);
  });

  group('GetHomeDataUseCase', () {
    final List<JobsListEntity> tJobs = <JobsListEntity>[];
    const int tCount = 3;

    test('returns HomeDataEntity when all calls succeed for approved user', () async {
      // Arrange
      when(() => mockRepository.getAvailableJobs(any()))
          .thenAnswer((_) async => right(tJobs));
      when(() => mockRepository.getUnreadNotificationsCount())
          .thenAnswer((_) async => tCount);
      when(() => mockRepository.getUpcomingShift())
          .thenAnswer((_) async => right(null));

      // Act
      final result = await useCase(params, userStatus: 'approved');

      // Assert
      expect(result.isRight(), true);
      final HomeDataEntity entity = result.getOrElse(() => throw Exception());
      expect(entity.unreadNotificationCount, tCount);
      expect(entity.jobCategories, tJobs);
      expect(entity.upcomingShift, isNull);
    });

    test('skips getUpcomingShift when user is not approved', () async {
      // Arrange
      when(() => mockRepository.getAvailableJobs(any()))
          .thenAnswer((_) async => right(tJobs));
      when(() => mockRepository.getUnreadNotificationsCount())
          .thenAnswer((_) async => tCount);

      // Act
      final result = await useCase(params, userStatus: 'pending');

      // Assert
      expect(result.isRight(), true);
      verifyNever(() => mockRepository.getUpcomingShift());
    });

    test('returns ServerFailure when getAvailableJobs fails', () async {
      // Arrange
      const ServerFailure failure = ServerFailure(message: 'Server error');
      when(() => mockRepository.getAvailableJobs(any()))
          .thenAnswer((_) async => left(failure));
      when(() => mockRepository.getUnreadNotificationsCount())
          .thenAnswer((_) async => 0);

      // Act
      final result = await useCase(params, userStatus: null);

      // Assert
      expect(result.isLeft(), true);
    });

    test('returns HomeDataEntity even when getUpcomingShift fails', () async {
      // Arrange
      when(() => mockRepository.getAvailableJobs(any()))
          .thenAnswer((_) async => right(tJobs));
      when(() => mockRepository.getUnreadNotificationsCount())
          .thenAnswer((_) async => tCount);
      when(() => mockRepository.getUpcomingShift())
          .thenAnswer((_) async => left(const NetworkFailure()));

      // Act
      final result = await useCase(params, userStatus: 'approved');

      // Assert
      expect(result.isRight(), true);
      final HomeDataEntity entity = result.getOrElse(() => throw Exception());
      expect(entity.upcomingShift, isNull);
    });
  });
}
