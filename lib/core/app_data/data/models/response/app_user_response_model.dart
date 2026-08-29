import 'package:flexiJobs/core/app_data/data/models/response/city_response_model.dart';
import 'package:flexiJobs/core/app_data/data/models/response/governorate_response_model.dart';
import 'package:flexiJobs/core/app_data/data/models/response/job_category_response_model.dart';
import 'package:flexiJobs/core/app_data/data/models/response/payment_response_model.dart';
import 'package:flexiJobs/core/app_data/data/models/response/user_response_model.dart';
import 'package:flexiJobs/core/app_data/domain/entities/app_user_entity.dart';
import 'package:flexiJobs/features/complete_profile/data/models/response/instapay_response_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/response/wallet_response_model.dart';
import 'package:flexiJobs/features/jobs/data/models/response/attachment_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

part 'app_user_response_model.g.dart';

@JsonSerializable()
class AppUserModel extends AppUserEntity {
  AppUserModel(
      {super.id,
      super.name,
      super.phoneCode,
      super.phoneNumber,
      super.birthdate,
      super.address,
      super.emailVerifiedAt,
      super.expVerificationAt,
      super.governorateId,
      super.cityId,
      super.userId,
      super.status,
      super.code,
      super.state,
      super.paymentableType,
      super.paymentableId,
      super.attachments,
      super.governorates,
      super.cities,
      super.users,
      super.paymentable,
      super.instapays,
      super.universityName,
      super.jobCategories,
      super.mobileWallets,
      super.is_guest,
      super.gender,
      super.nationalId,
      super.universityFaculty,
      super.universityMajor,
      super.universityId,
      super.introVideoStatus,
      super.prePaidCards});
  factory AppUserModel.fromJson(Map<String, dynamic> json) => _$AppUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserModelToJson(this);
}

@JsonSerializable()
class AppUserResponseModel extends BaseEntity<AppUserModel> {
  AppUserResponseModel({
    super.statusCode,
    super.data,
    super.message,
    super.totalRecords,
    super.hasMorePages,
  });
  factory AppUserResponseModel.fromJson(Map<String, dynamic> json) => _$AppUserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserResponseModelToJson(this);
}
