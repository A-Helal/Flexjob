import 'package:flexiJobs/core/app_data/domain/entities/app_user_entity.dart';
import 'package:flexiJobs/features/complete_profile/domain/repository/complete_profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
 
 

@injectable
class CompleteProfileUseCase implements UseCaseNoParam<AppUserEntity> {
  CompleteProfileUseCase({required this.completeProfileRepository});
  final CompleteProfileRepository completeProfileRepository;

  @override
   Future<CustomResponseType<AppUserEntity>> call() async {
    return completeProfileRepository.completeProfile();
  }
}
