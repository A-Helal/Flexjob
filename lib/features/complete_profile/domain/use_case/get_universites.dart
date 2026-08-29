import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';
import 'package:flexiJobs/core/app_data/domain/repositories/governorate_repository.dart';
import 'package:flexiJobs/features/complete_profile/domain/repository/complete_profile_repository.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/core/network/base_handling.dart';

@injectable
class GetUniversitesUseCase implements UseCase<List<GovernorateEntity>, BaseRequestModel> {
  GetUniversitesUseCase({required this.completeProfileRepository});
  final CompleteProfileRepository completeProfileRepository;

  @override
  Future<CustomResponseType<List<GovernorateEntity>>> call(
    BaseRequestModel baseRequestModel,
  ) async {
    return completeProfileRepository.getUniversities(
      baseRequestModel: baseRequestModel,
    );
  }
}
