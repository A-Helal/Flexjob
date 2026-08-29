// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDto _$JobDtoFromJson(Map<String, dynamic> json) => JobDto(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  code: json['code'] as String?,
  status: json['status'] as String?,
  state: json['state'] as String?,
  description: json['description'] as String?,
  latitude: json['latitude'] as String?,
  longitude: json['longitude'] as String?,
  vendorPayTotalPrice: json['vendor_pay_total_price'] as num?,
  vendorPayPricePerHour: json['vendor_pay_price_per_hour'] as num?,
  totalPrice: json['total_price'] as num?,
  pricePerHour: json['price_per_hour'] as num?,
  userTotalPrice: json['user_total_price'] as num?,
  userPricePerHour: json['user_price_per_hour'] as num?,
  startDate: json['start_date'] as String?,
  endDate: json['end_date'] as String?,
  startTime: json['start_time'] as String?,
  endTime: json['end_time'] as String?,
  shiftHours: (json['shift_hours'] as num?)?.toInt(),
  numOfApplicants: (json['num_of_applicants'] as num?)?.toInt(),
  vendorBranch: json['vendor_branch'] as String?,
  vendorId: (json['vendor_id'] as num?)?.toInt(),
  vendorBranchId: (json['vendor_branch_id'] as num?)?.toInt(),
  jobCategory: json['job_category'] as String?,
  jobCategoryId: (json['job_category_id'] as num?)?.toInt(),
  cityId: (json['city_id'] as num?)?.toInt(),
  vendorUserId: (json['vendor_user_id'] as num?)?.toInt(),
  vendor: json['vendors'] == null
      ? null
      : VendorDto.fromJson(json['vendors'] as Map<String, dynamic>),
  needIntroVideo: (json['need_intro_video'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  notRejectApplicants: (json['not_reject_applicants'] as List<dynamic>?)
      ?.map((e) => JobApplicantDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  checkInTodayShift: json['check_in_today_shift'] == null
      ? null
      : JobAttanedanceResponseModel.fromJson(
          json['check_in_today_shift'] as Map<String, dynamic>,
        ),
  checkoutTodayShift: json['checkout_today_shift'] == null
      ? null
      : JobAttanedanceResponseModel.fromJson(
          json['checkout_today_shift'] as Map<String, dynamic>,
        ),
);
