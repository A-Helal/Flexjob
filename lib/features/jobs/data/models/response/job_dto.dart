import 'package:flexiJobs/features/job_details/data/models/response/job_attendance_resposne_model.dart';
import 'package:flexiJobs/features/jobs/data/models/response/job_applicant_dto.dart';
import 'package:flexiJobs/features/jobs/data/models/response/vendor_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';

part 'job_dto.g.dart';

@JsonSerializable(createToJson: false)
class JobDto {

    factory JobDto.fromJson(Map<String, dynamic> json) => _$JobDtoFromJson(json);
    const JobDto({
        required this.id,
        required this.title,
        this.code,
        this.status,
        this.state,
        this.description,
        this.latitude,
        this.longitude,
        this.vendorPayTotalPrice,
        this.vendorPayPricePerHour,
        this.totalPrice,
        this.pricePerHour,
        this.userTotalPrice,
        this.userPricePerHour,
        this.startDate,
        this.endDate,
        this.startTime,
        this.endTime,
        this.shiftHours,
        this.numOfApplicants,
        this.vendorBranch,
        this.vendorId,
        this.vendorBranchId,
        this.jobCategory,
        this.jobCategoryId,
        this.cityId,
        this.vendorUserId,
        this.vendor,
        this.needIntroVideo,
        this.total,
        this.notRejectApplicants,
        this.checkInTodayShift,
        this.checkoutTodayShift,
    });

    final int id;
    final String title;
    final String? code;
    final String? status;
    final String? state;
    final String? description;
    final String? latitude;
    final String? longitude;

    @JsonKey(name: 'vendor_pay_total_price')
    final num? vendorPayTotalPrice;
    @JsonKey(name: 'vendor_pay_price_per_hour')
    final num? vendorPayPricePerHour;
    @JsonKey(name: 'total_price')
    final num? totalPrice;
    @JsonKey(name: 'price_per_hour')
    final num? pricePerHour;
    @JsonKey(name: 'user_total_price')
    final num? userTotalPrice;
    @JsonKey(name: 'user_price_per_hour')
    final num? userPricePerHour;

    @JsonKey(name: 'start_date')
    final String? startDate;
    @JsonKey(name: 'end_date')
    final String? endDate;
    @JsonKey(name: 'start_time')
    final String? startTime;
    @JsonKey(name: 'end_time')
    final String? endTime;
    @JsonKey(name: 'shift_hours')
    final int? shiftHours;
    @JsonKey(name: 'num_of_applicants')
    final int? numOfApplicants;
    @JsonKey(name: 'vendor_branch')
    final String? vendorBranch;
    @JsonKey(name: 'vendor_id')
    final int? vendorId;
    @JsonKey(name: 'vendor_branch_id')
    final int? vendorBranchId;
    @JsonKey(name: 'job_category')
    final String? jobCategory;
    @JsonKey(name: 'job_category_id')
    final int? jobCategoryId;
    @JsonKey(name: 'city_id')
    final int? cityId;
    @JsonKey(name: 'vendor_user_id')
    final int? vendorUserId;

    // 'vendors' key in JSON maps to our typed VendorDto
    @JsonKey(name: 'vendors')
    final VendorDto? vendor;

    @JsonKey(name: 'need_intro_video')
    final int? needIntroVideo;

    final int? total;

    @JsonKey(name: 'not_reject_applicants')
    final List<JobApplicantDto>? notRejectApplicants;

    @JsonKey(name: 'check_in_today_shift')
    final JobAttanedanceResponseModel? checkInTodayShift;

    @JsonKey(name: 'checkout_today_shift')
    final JobAttanedanceResponseModel? checkoutTodayShift;

    /// Single safe conversion point — no null crashes reach the UI.
    JobEntity toEntity() => JobEntity(
        id: id,
        title: title,
        code: code,
        status: status,
        state: state,
        description: description,
        latitude: latitude,
        longitude: longitude,
        vendorPayTotalPrice: vendorPayTotalPrice?.toDouble() ?? 0.0,
        vendorPayPricePerHour: vendorPayPricePerHour?.toDouble() ?? 0.0,
        totalPrice: totalPrice?.toDouble() ?? 0.0,
        pricePerHour: pricePerHour?.toDouble() ?? 0.0,
        userTotalPrice: userTotalPrice?.toDouble() ?? 0.0,
        userPricePerHour: userPricePerHour?.toDouble() ?? 0.0,
        startDate: _parseDate(startDate) ?? DateTime.now(),
        endDate: _parseDate(endDate) ?? DateTime.now(),
        startTime: startTime ?? '',
        endTime: endTime ?? '',
        shiftHours: shiftHours ?? 0,
        numOfApplicants: numOfApplicants ?? 0,
        vendorBranch: vendorBranch,
        vendorId: vendorId,
        vendorBranchId: vendorBranchId,
        jobCategory: jobCategory,
        jobCategoryId: jobCategoryId,
        cityId: cityId,
        vendor: vendor?.toEntity(),
        needsIntroVideo: (needIntroVideo ?? 0) == 1,
        total: total ?? 0,
        notRejectApplicants: notRejectApplicants
            ?.map((e) => e.toEntity())
            .toList(),
        checkInTodayShift: checkInTodayShift,
        checkoutTodayShift: checkoutTodayShift,
    );

    static DateTime? _parseDate(String? raw) {
        if (raw == null || raw.isEmpty) return null;
        return DateTime.tryParse(raw);
    }
}
