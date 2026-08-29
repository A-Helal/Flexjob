import 'package:equatable/equatable.dart';

class JobFilterParams extends Equatable {
  const JobFilterParams({
    this.governorateId,
    this.jobCategoryId,
    this.page = 1,
    this.pageSize = 100,
  });

  final int? governorateId;
  final int? jobCategoryId;
  final int page;
  final int pageSize;

  JobFilterParams copyWith({int? governorateId, int? jobCategoryId}) =>
      JobFilterParams(
        governorateId: governorateId,
        jobCategoryId: jobCategoryId,
        page: page,
        pageSize: pageSize,
      );

  @override
  List<Object?> get props => [governorateId, jobCategoryId, page, pageSize];
}