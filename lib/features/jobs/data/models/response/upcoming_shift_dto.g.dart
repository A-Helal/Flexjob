// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_shift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingShiftDto _$UpcomingShiftDtoFromJson(Map<String, dynamic> json) =>
    UpcomingShiftDto(
      id: (json['id'] as num).toInt(),
      jobId: (json['job_id'] as num).toInt(),
      appUserId: (json['app_user_id'] as num).toInt(),
      actualCheckIn: json['actual_check_in'] as String?,
      actualCheckOut: json['actual_check_out'] as String?,
      vendorId: (json['vendor_id'] as num?)?.toInt(),
      jobApplicantId: (json['job_applicant_id'] as num?)?.toInt(),
      amountShouldPay: json['amount_should_pay'] as num?,
      upcomingShiftStartIn: json['upcoming_shift_start_in'] as String?,
    );
