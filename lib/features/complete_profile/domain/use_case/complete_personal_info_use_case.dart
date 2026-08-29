import 'package:flexiJobs/core/app_data/domain/entities/app_user_entity.dart';


import 'package:flexiJobs/features/complete_profile/data/models/request/complete_personal_info_request_model.dart';
import 'package:flexiJobs/features/complete_profile/domain/repository/complete_profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';

import 'package:flexiJobs/core/network/base_handling.dart';


@injectable
class CompletePersonalInfoUseCase implements UseCase<AppUserEntity, CompletePersonalInfoRequestModel> {
  CompletePersonalInfoUseCase({required this.completeProfileRepository});
    final CompleteProfileRepository completeProfileRepository;

  @override
  Future<CustomResponseType<AppUserEntity>> call(
     CompletePersonalInfoRequestModel  completePaymentInfoRequestModel,
  ) async {
    return completeProfileRepository.completePersonalInfo(
     completePersonalInfo:completePaymentInfoRequestModel,
    );
  }
}



