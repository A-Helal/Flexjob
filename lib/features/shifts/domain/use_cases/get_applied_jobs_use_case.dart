import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:flexiJobs/features/shifts/domain/repositories/shift_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAppliedJobsUseCase
    implements UseCase<BaseEntity<List<JobEntity>>, BaseRequestModel> {
  GetAppliedJobsUseCase({required this.shiftRepository});

  final ShiftRepository shiftRepository;

  @override
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> call(
    BaseRequestModel baseRequestModel,
  ) async {
    return shiftRepository.getAppliedJobs(
      baseRequestModel: baseRequestModel,
    );
  }
}
