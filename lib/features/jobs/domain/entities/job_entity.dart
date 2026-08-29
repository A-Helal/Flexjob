import 'package:equatable/equatable.dart';
import 'package:flexiJobs/features/job_details/domain/entity/job_attendance_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_applicant_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/vendor_entity.dart';

class JobEntity extends Equatable {
  const JobEntity({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.shiftHours,
    this.code,
    this.status,
    this.state,
    this.description,
    this.latitude,
    this.longitude,
    this.vendorPayTotalPrice = 0,
    this.vendorPayPricePerHour = 0,
    this.totalPrice = 0,
    this.pricePerHour = 0,
    this.userTotalPrice = 0,
    this.userPricePerHour = 0,
    this.numOfApplicants = 0,
    this.vendorBranch,
    this.vendorId,
    this.vendorBranchId,
    this.jobCategory,
    this.jobCategoryId,
    this.cityId,
    this.vendor,
    this.needsIntroVideo = false,
    this.total = 0,
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
  final double vendorPayTotalPrice;
  final double vendorPayPricePerHour;
  final double totalPrice;
  final double pricePerHour;
  final double userTotalPrice;
  final double userPricePerHour;
  final DateTime startDate;
  final DateTime endDate;
  final String startTime;
  final String endTime;
  final int shiftHours;
  final int numOfApplicants;
  final String? vendorBranch;
  final int? vendorId;
  final int? vendorBranchId;
  final String? jobCategory;
  final int? jobCategoryId;
  final int? cityId;
  final VendorEntity? vendor;
  final bool needsIntroVideo;
  final int total;
  final List<JobApplicantEntity>? notRejectApplicants;
  final JobAttendanceEntity? checkInTodayShift;
  final JobAttendanceEntity? checkoutTodayShift;

  bool get isMultiDay => endDate.difference(startDate).inDays > 0;

  @override
  List<Object?> get props => <Object?>[
    id,
    title,
    startDate,
    endDate,
    status,
    vendorId,
  ];
}
