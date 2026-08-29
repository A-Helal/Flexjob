import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';
import 'package:flexiJobs/core/app_data/domain/repositories/governorate_repository.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/core/network/base_handling.dart';

@injectable
class GetGovernoratsUseCase implements UseCase<BaseEntity<List<GovernorateEntity>>, BaseRequestModel> {
  GetGovernoratsUseCase({required this.governorateRepository});
  final GovernorateRepository governorateRepository;

  @override
  Future<CustomResponseType<BaseEntity<List<GovernorateEntity>>>> call(
    BaseRequestModel baseRequestModel,
  ) async {
    return governorateRepository.getGovernorates(
      baseRequestModel: baseRequestModel,
    );
  }
}
