import 'package:flexiJobs/core/app_data/data/models/response/app_user_response_model.dart';
import 'package:flexiJobs/core/app_data/data/models/response/governorate_response_model.dart';


import 'package:flexiJobs/features/complete_profile/data/data_sources/complete_profile_data_sources.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/attachment_request_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/complete_payment_info_request_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/complete_personal_info_request_model.dart';
import 'package:flexiJobs/features/complete_profile/domain/repository/complete_profile_repository.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/network/base_handling.dart';


@Injectable(as: CompleteProfileRepository)
class CompleteProfileRepositoryImp implements CompleteProfileRepository {
  CompleteProfileRepositoryImp({
    required this.completeProfileDataSources,
  });
  final CompleteProfileDataSources completeProfileDataSources;

  Future<CustomResponseType<AppUserModel>> completePersonalInfo(
      {required CompletePersonalInfoRequestModel completePersonalInfo}) async {
    return completeProfileDataSources.completePersonalInfo(completePersonalInfoRequestModel: completePersonalInfo);
  }

  Future<CustomResponseType<AppUserModel>> uploadDocument({
    required List<AttachmentRequestModel> listAttachments,
  }) async {
    return completeProfileDataSources.uploadDocument(listAttachments: listAttachments);
  }

  Future<CustomResponseType<AppUserModel>> completePaymentInfo({
    required CompletePaymentInfoRequestModel completePaymentInfoRequestModel,
  }) async {
    return completeProfileDataSources.completePaymentInfo(
        completePaymentInfoRequestModel: completePaymentInfoRequestModel);
  }

  Future<CustomResponseType<AppUserModel>> completeSkillsAndExperienceInfo({
    required List<int> jobCategoriesIds,
  }) async {
    return completeProfileDataSources.completeSkillsAndExperience(jobCategoriesIds: jobCategoriesIds);
  }

  Future<CustomResponseType<AppUserModel>> completeProfile() async {
    return completeProfileDataSources.completeProfile();
  }

  Future<CustomResponseType<List<GovernorateModel>>> getUniversities(
      {required BaseRequestModel baseRequestModel}) async {
    return completeProfileDataSources.getUniversites(baseRequestModel: baseRequestModel);
  }
}



