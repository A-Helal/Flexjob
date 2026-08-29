// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_attendance_resposne_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobAttanedanceResponseModel _$JobAttanedanceResponseModelFromJson(
  Map<String, dynamic> json,
) => JobAttanedanceResponseModel(
  actualCheckIn: json['actualCheckIn'] as String?,
  actualCheckOut: json['actualCheckOut'] as String?,
  checkIn: json['checkIn'] as String?,
  checkOut: json['checkOut'] as String?,
  appUserId: (json['appUserId'] as num?)?.toInt(),
  jobId: (json['jobId'] as num?)?.toInt(),
  appUsers: json['appUsers'] == null
      ? null
      : AppUserModel.fromJson(json['appUsers'] as Map<String, dynamic>),
  amountShouldPay: (json['amountShouldPay'] as num?)?.toInt(),
  jobApplicantId: (json['jobApplicantId'] as num?)?.toInt(),
  vendorId: (json['vendorId'] as num?)?.toInt(),
);

Map<String, dynamic> _$JobAttanedanceResponseModelToJson(
  JobAttanedanceResponseModel instance,
) => <String, dynamic>{
  'actualCheckIn': instance.actualCheckIn,
  'checkIn': instance.checkIn,
  'actualCheckOut': instance.actualCheckOut,
  'checkOut': instance.checkOut,
  'appUserId': instance.appUserId,
  'jobId': instance.jobId,
  'vendorId': instance.vendorId,
  'jobApplicantId': instance.jobApplicantId,
  'amountShouldPay': instance.amountShouldPay,
  'appUsers': instance.appUsers,
};
