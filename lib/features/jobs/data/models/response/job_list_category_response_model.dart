import 'package:flexiJobs/features/jobs/data/models/response/job_dto.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

class JobListCategoryResponseModel extends BaseEntity<List<JobEntity>> {
  JobListCategoryResponseModel({
    super.data,
    super.totalRecords,
    super.message,
    super.statusCode,
    super.hasMorePages,
  });

  factory JobListCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> items =
        json['data'] as List<dynamic>? ?? <dynamic>[];
    return JobListCategoryResponseModel(
      data: items
          .whereType<Map<String, dynamic>>()
          .map(JobDto.fromJson)
          .map((JobDto dto) => dto.toEntity())
          .toList(),
      totalRecords: (json['total'] as num?)?.toInt(),
    );
  }
}
