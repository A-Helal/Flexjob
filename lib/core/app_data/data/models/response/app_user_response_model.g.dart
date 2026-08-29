// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUserModel _$AppUserModelFromJson(Map<String, dynamic> json) => AppUserModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  phoneCode: json['phone_code'] as String?,
  phoneNumber: json['phone_number'] as String?,
  birthdate: json['birthdate'] as String?,
  address: json['address'] as String?,
  emailVerifiedAt: json['emailVerifiedAt'] as String?,
  expVerificationAt: json['expVerificationAt'] as String?,
  governorateId: (json['governorate_id'] as num?)?.toInt(),
  cityId: (json['city_id'] as num?)?.toInt(),
  userId: (json['user_id'] as num?)?.toInt(),
  status: json['status'] as String?,
  code: json['code'] as String?,
  state: json['state'] as String?,
  paymentableType: json['paymentable_type'] as String?,
  paymentableId: (json['paymentable_id'] as num?)?.toInt(),
  attachments: (json['attachments'] as List<dynamic>?)
      ?.map((e) => AttachmentDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  governorates: json['governorates'] == null
      ? null
      : GovernorateModel.fromJson(json['governorates'] as Map<String, dynamic>),
  cities: json['cities'] == null
      ? null
      : CityModel.fromJson(json['cities'] as Map<String, dynamic>),
  users: json['users'] == null
      ? null
      : UserModel.fromJson(json['users'] as Map<String, dynamic>),
  paymentable: json['paymentable'] == null
      ? null
      : PaymentModel.fromJson(json['paymentable'] as Map<String, dynamic>),
  instapays: json['instapays'] == null
      ? null
      : InstapayResponseModel.fromJson(
          json['instapays'] as Map<String, dynamic>,
        ),
  universityName: json['university_name'] as String?,
  jobCategories: (json['job_categories'] as List<dynamic>?)
      ?.map((e) => JobCategoryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  mobileWallets: json['mobileWallets'] == null
      ? null
      : WalletResponseModel.fromJson(
          json['mobileWallets'] as Map<String, dynamic>,
        ),
  is_guest: (json['is_guest'] as num?)?.toInt(),
  gender: json['gender'] as String?,
  nationalId: json['national_id'] as String?,
  universityFaculty: json['university_faculty'] as String?,
  universityMajor: json['university_major'] as String?,
  universityId: (json['university_id'] as num?)?.toInt(),
  introVideoStatus: json['intro_video_status'] as String?,
  prePaidCards: json['prePaidCards'] == null
      ? null
      : WalletResponseModel.fromJson(
          json['prePaidCards'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AppUserModelToJson(AppUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone_code': instance.phoneCode,
      'phone_number': instance.phoneNumber,
      'university_name': instance.universityName,
      'birthdate': instance.birthdate,
      'address': instance.address,
      'emailVerifiedAt': instance.emailVerifiedAt,
      'expVerificationAt': instance.expVerificationAt,
      'governorate_id': instance.governorateId,
      'city_id': instance.cityId,
      'user_id': instance.userId,
      'status': instance.status,
      'state': instance.state,
      'gender': instance.gender,
      'paymentable_type': instance.paymentableType,
      'university_faculty': instance.universityFaculty,
      'university_major': instance.universityMajor,
      'paymentable_id': instance.paymentableId,
      'university_id': instance.universityId,
      'national_id': instance.nationalId,
      'is_guest': instance.is_guest,
      'code': instance.code,
      'intro_video_status': instance.introVideoStatus,
      'attachments': instance.attachments,
      'job_categories': instance.jobCategories,
      'governorates': instance.governorates,
      'cities': instance.cities,
      'users': instance.users,
      'paymentable': instance.paymentable,
      'instapays': instance.instapays,
      'mobileWallets': instance.mobileWallets,
      'prePaidCards': instance.prePaidCards,
    };

AppUserResponseModel _$AppUserResponseModelFromJson(
  Map<String, dynamic> json,
) => AppUserResponseModel(
  statusCode: (json['statusCode'] as num?)?.toInt(),
  data: json['data'] == null
      ? null
      : AppUserModel.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
  totalRecords: (json['totalRecords'] as num?)?.toInt(),
  hasMorePages: json['hasMorePages'] as bool?,
);

Map<String, dynamic> _$AppUserResponseModelToJson(
  AppUserResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'statusCode': instance.statusCode,
  'data': instance.data,
  'totalRecords': instance.totalRecords,
  'hasMorePages': instance.hasMorePages,
};
