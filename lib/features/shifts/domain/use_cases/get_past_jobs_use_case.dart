import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:flexiJobs/features/shifts/domain/repositories/shift_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/core/network/base_handling.dart';


@injectable
class GetPastJobsUseCase implements UseCase<BaseEntity<List<JobEntity>>, BaseRequestModel> {
  GetPastJobsUseCase({required this.shiftRepository});
  final ShiftRepository shiftRepository;

  @override
  Future<CustomResponseType<BaseEntity<List<JobEntity>>>> call(
     BaseRequestModel  baseRequestModel,
  ) async {
    return shiftRepository.getPastJobs(
     baseRequestModel:baseRequestModel,
    );
  }
}
