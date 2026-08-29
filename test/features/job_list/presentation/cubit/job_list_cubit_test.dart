import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/features/job_list/domain/use_cases/get_jobs_list_for_category.dart';
import 'package:flexiJobs/features/job_list/presentation/cubit/job_list_cubit.dart';
import 'package:flexiJobs/features/jobs/data/models/request/jobs_request_model.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAvailableJobsForCategoryUseCase extends Mock
    implements GetAvailableJobsForCategoryUseCase {}

class _TestJobsPageEntity extends BaseEntity<List<JobEntity>> {
  _TestJobsPageEntity({super.data, super.totalRecords}) : super();
}

void main() {
  late MockGetAvailableJobsForCategoryUseCase mockUseCase;
  late JobListCubit cubit;

  final List<JobEntity> tJobs = <JobEntity>[];

  /// Minimal concrete [BaseEntity] for testing — base type is abstract.
  final BaseEntity<List<JobEntity>> tResponse = _TestJobsPageEntity(
    data: tJobs,
    totalRecords: 10,
  );

  setUp(() {
    mockUseCase = MockGetAvailableJobsForCategoryUseCase();
    cubit = JobListCubit(getAvailableJobsForCategoryUseCase: mockUseCase);
    registerFallbackValue(JobsRequestModel(page: 1, pageSize: 5));
  });

  tearDown(() => cubit.close());

  group('JobListCubit.getAvailableJobs', () {
    blocTest<JobListCubit, JobListState>(
      'emits [Loading, Ready] when use case succeeds',
      build: () {
        when(() => mockUseCase(any()))
            .thenAnswer((_) async => right(tResponse));
        return cubit;
      },
      act: (JobListCubit c) => c.getAvailableJobs(categoryId: 1),
      expect: () => <TypeMatcher<JobListState>>[
        isA<JobListLoadingState>(),
        isA<JobListReadyState>(),
      ],
    );

    blocTest<JobListCubit, JobListState>(
      'emits [Loading, Error] when use case fails',
      build: () {
        when(() => mockUseCase(any()))
            .thenAnswer((_) async => left(const NetworkFailure()));
        return cubit;
      },
      act: (JobListCubit c) => c.getAvailableJobs(categoryId: 1),
      expect: () => <TypeMatcher<JobListState>>[
        isA<JobListLoadingState>(),
        isA<JobListErrorState>(),
      ],
    );

    blocTest<JobListCubit, JobListState>(
      'Ready state has correct total and job list',
      build: () {
        when(() => mockUseCase(any()))
            .thenAnswer((_) async => right(tResponse));
        return cubit;
      },
      act: (JobListCubit c) => c.getAvailableJobs(categoryId: 2),
      expect: () => <dynamic>[
        isA<JobListLoadingState>(),
        isA<JobListReadyState>().having(
          (JobListReadyState s) => s.total,
          'total',
          10,
        ),
      ],
    );
  });

  group('JobListCubit.loadMoreJobs', () {
    blocTest<JobListCubit, JobListState>(
      'appends jobs and increments page',
      build: () {
        when(() => mockUseCase(any()))
            .thenAnswer((_) async => right(tResponse));
        return cubit;
      },
      seed: () => JobListReadyState(
        jobList: tJobs,
        total: 10,
        catgoryId: 1,
        pageNumber: 1,
      ),
      act: (JobListCubit c) => c.loadMoreJobs(),
      expect: () => <dynamic>[
        isA<JobListReadyState>().having(
          (JobListReadyState s) => s.inProgress,
          'inProgress',
          true,
        ),
        isA<JobListReadyState>().having(
          (JobListReadyState s) => s.pageNumber,
          'pageNumber',
          2,
        ),
      ],
    );

    blocTest<JobListCubit, JobListState>(
      'does nothing when state is not Ready',
      build: () => cubit,
      act: (JobListCubit c) => c.loadMoreJobs(),
      expect: () => <JobListState>[],
    );
  });
}
