import 'package:flexiJobs/core/app_data/domain/entities/app_user_entity.dart';
import 'package:flexiJobs/core/app_data/domain/repositories/user_repository.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/core/network/base_handling.dart';


@injectable
class GetUserInfoUseCase implements UseCase<AppUserEntity, BaseRequestModel> {
  GetUserInfoUseCase({required this.userRepository});
  final UserRepository userRepository;

  @override
  Future<CustomResponseType< AppUserEntity>> call(
     BaseRequestModel  baseRequestModel,
  ) async {
    return userRepository.getUserInfo(
     baseRequestModel:baseRequestModel,
    );
  }
}
