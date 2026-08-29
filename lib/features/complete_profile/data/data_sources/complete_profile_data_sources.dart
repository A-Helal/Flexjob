import 'package:dio/dio.dart';
import 'package:flexiJobs/core/app_data/data/models/response/app_user_response_model.dart';
import 'package:flexiJobs/core/app_data/data/models/response/governorate_response_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/attachment_request_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/complete_payment_info_request_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/complete_personal_info_request_model.dart';

import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';

abstract class CompleteProfileDataSources {
  Future<CustomResponseType<AppUserModel>> completePersonalInfo(
      {required CompletePersonalInfoRequestModel completePersonalInfoRequestModel});

  Future<CustomResponseType<AppUserModel>> uploadDocument({
    required List<AttachmentRequestModel> listAttachments,
  });
  Future<CustomResponseType<AppUserModel>> completePaymentInfo({
    required CompletePaymentInfoRequestModel completePaymentInfoRequestModel,
  });
  Future<CustomResponseType<AppUserModel>> completeSkillsAndExperience({
    required List<int> jobCategoriesIds,
  });
  Future<CustomResponseType<AppUserModel>> completeProfile();

  Future<CustomResponseType<List<GovernorateModel>>> getUniversites({required BaseRequestModel baseRequestModel});
}

@Injectable(as: CompleteProfileDataSources)
class CompleteProfileDataSourcesImpl implements CompleteProfileDataSources {
  CompleteProfileDataSourcesImpl(this.networkHelper);
  final NetworkHelper networkHelper;

  @override
  Future<CustomResponseType<AppUserModel>> completePersonalInfo(
      {required CompletePersonalInfoRequestModel completePersonalInfoRequestModel}) async {
    final Map<String, dynamic> jsonMap = completePersonalInfoRequestModel.toJson();

    final Map<String, dynamic> formMap = <String, dynamic>{};
    jsonMap.forEach((String key, value) {
      if (value != null) {
        formMap[key] = value;
      }
    });

    final FormData formData = FormData.fromMap(formMap);
    formData.fields.add(completePersonalInfoRequestModel.attachment!.fields.first);
    formData.files.add(completePersonalInfoRequestModel.attachment!.files.first);

    ({dynamic response, bool success}) result =
        await networkHelper.post(path: ApiConstants.completePersonalInfo, data: formData);

    if (result.success) {
      return right(AppUserModel.fromJson(result.response));
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<AppUserModel>> uploadDocument({
    required List<AttachmentRequestModel> listAttachments,  
  }) async {
    final FormData formData = FormData();

    for (int i = 0; i < listAttachments.length; i++) {
      final String filePath = listAttachments[i].filePath;
      final String fileType = listAttachments[i].type;
      formData.fields.addAll(<MapEntry<String, String>>[
        MapEntry("attachments[$i][type]", fileType),
      ]);
      formData.files.add(
        MapEntry(
          "attachments[$i][file]",
          await MultipartFile.fromFile(filePath, filename: filePath.split('/').last),
        ),
      );
    }

    ({dynamic response, bool success}) result =
        await networkHelper.post(path: ApiConstants.completeDocuments, data: formData);

    if (result.success) {
      return right(AppUserModel.fromJson(result.response));
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<AppUserModel>> completePaymentInfo({
    required CompletePaymentInfoRequestModel completePaymentInfoRequestModel,
  }) async {
    ({dynamic response, bool success}) result = await networkHelper.post(
        path: ApiConstants.completePaymentInfo, data: completePaymentInfoRequestModel.toJson());

    if (result.success) {
      return right(AppUserModel.fromJson(result.response));
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<AppUserModel>> completeSkillsAndExperience({
    required List<int> jobCategoriesIds,
  }) async {
    ({dynamic response, bool success}) result = await networkHelper.post(
        path: ApiConstants.setJobCategoryHistories, data: <String, List<int>>{"job_category_ids": jobCategoriesIds});

    if (result.success) {
      return right(AppUserModel.fromJson(result.response));
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<AppUserModel>> completeProfile() async {
    ({dynamic response, bool success}) result = await networkHelper.post(path: ApiConstants.completeProfile);

    if (result.success) {
      return right(AppUserModel.fromJson(result.response));
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<List<GovernorateModel>>> getUniversites(
      {required BaseRequestModel baseRequestModel}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.post(path: ApiConstants.getUniversities, data: baseRequestModel.toJson());

    if (result.success) {
      return right((result.response['data']['universities']['data'] as List<dynamic>)
          .map((dynamic nestedJson) => GovernorateModel.fromJson(nestedJson))
          .toList());
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }
}

