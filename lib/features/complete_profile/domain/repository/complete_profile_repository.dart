
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/app_data/domain/entities/app_user_entity.dart';
import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';

import 'package:flexiJobs/features/complete_profile/data/models/request/attachment_request_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/complete_payment_info_request_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/complete_personal_info_request_model.dart';


import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';

abstract class CompleteProfileRepository {

 
Future<CustomResponseType<AppUserEntity>> completePersonalInfo({ 
 required CompletePersonalInfoRequestModel completePersonalInfo });
Future<CustomResponseType<AppUserEntity>> uploadDocument({ 
 required  List<AttachmentRequestModel>  listAttachments, });
Future<CustomResponseType<AppUserEntity>> completePaymentInfo({ 
 required  CompletePaymentInfoRequestModel  completePaymentInfoRequestModel, });
Future<CustomResponseType<AppUserEntity>> completeSkillsAndExperienceInfo({ 
 required  List<int>    jobCategoriesIds, });

 Future<CustomResponseType<AppUserEntity>> completeProfile( 
  );
  Future<CustomResponseType<List<GovernorateEntity>>> getUniversities({ 
 required BaseRequestModel baseRequestModel });
  
}


