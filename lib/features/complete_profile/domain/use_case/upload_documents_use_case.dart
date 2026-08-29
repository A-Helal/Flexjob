import 'package:flexiJobs/core/app_data/domain/entities/app_user_entity.dart';
import 'package:flexiJobs/core/app_data/domain/entities/user_entity.dart';
import 'package:flexiJobs/core/app_data/domain/repositories/user_repository.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/attachment_request_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/complete_personal_info_request_model.dart';
import 'package:flexiJobs/features/complete_profile/domain/repository/complete_profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/core/network/base_handling.dart';


@injectable
class UploadDocumentsUseCase implements UseCase<AppUserEntity, List<AttachmentRequestModel>> {
  UploadDocumentsUseCase({required this.completeProfileRepository});
  final CompleteProfileRepository completeProfileRepository;

  @override
  Future<CustomResponseType<AppUserEntity>> call(
     List<AttachmentRequestModel>  listAttachments,
  ) async {
    return completeProfileRepository.uploadDocument(
     listAttachments:listAttachments,
    );
  }
}
