// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flexiJobs/core/app_data/data/models/response/city_response_model.dart';
import 'package:flexiJobs/core/app_data/data/models/response/governorate_response_model.dart';
import 'package:flexiJobs/core/app_data/data/models/response/job_category_response_model.dart';
import 'package:flexiJobs/core/app_data/data/models/response/payment_response_model.dart';
import 'package:flexiJobs/core/app_data/data/models/response/user_response_model.dart';

import 'package:flexiJobs/features/complete_profile/data/models/response/instapay_response_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/response/wallet_response_model.dart';
import 'package:flexiJobs/features/jobs/data/models/response/attachment_dto.dart';
import 'package:json_annotation/json_annotation.dart';

class AppUserEntity extends Equatable {
  const AppUserEntity({
    this.gender,
    this.universityFaculty,
    this.universityMajor,
    this.universityId,
    this.nationalId,
    this.id,
    this.name,
    this.phoneCode,
    this.phoneNumber,
    this.birthdate,
    this.address,
    this.emailVerifiedAt,
    this.expVerificationAt,
    this.governorateId,
    this.cityId,
    this.userId,
    this.status,
    this.state,
    this.paymentableType,
    this.paymentableId,
    this.attachments,
    this.governorates,
    this.cities,
    this.users,
    this.paymentable,
    this.instapays,
    this.prePaidCards,
    this.mobileWallets,
    this.universityName,
    this.jobCategories,
    this.is_guest,
    this.code,
    this.introVideoStatus
  });

  final int? id;
  final String? name;
  @JsonKey(name: "phone_code")
  final String? phoneCode;
  @JsonKey(name: "phone_number")
  final String? phoneNumber;
  @JsonKey(name: "university_name")
  final String? universityName;
  final String? birthdate;
  final String? address;
  final String? emailVerifiedAt;
  final String? expVerificationAt;
  @JsonKey(name: "governorate_id")
  final int? governorateId;
  @JsonKey(name: "city_id")
  final int? cityId;
  @JsonKey(name: "user_id")
  final int? userId;
  final String? status;
  final String? state;
  final String? gender;

  @JsonKey(name: "paymentable_type")
  final String? paymentableType;

  @JsonKey(name: "university_faculty")
  final String? universityFaculty;
  @JsonKey(name: "university_major")
  final String? universityMajor;
  @JsonKey(name: "paymentable_id")
  final int? paymentableId;
  @JsonKey(name: "university_id")
  final int? universityId;
  @JsonKey(name: "national_id")
  final String? nationalId;
  final int? is_guest;
  final String? code;
  @JsonKey(name: "intro_video_status")
  final String? introVideoStatus;

  final List<AttachmentDto>? attachments;
  @JsonKey(name: "job_categories")
  final List<JobCategoryModel>? jobCategories;
  final GovernorateModel? governorates;
  final CityModel? cities;
  final UserModel? users;
  final PaymentModel? paymentable;
  final InstapayResponseModel? instapays;
  final WalletResponseModel? mobileWallets;
  final WalletResponseModel? prePaidCards;

  @override
  List<Object?> get props => <Object?>[];
}

