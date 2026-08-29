// import 'package:flexiJobs/features/jobs/data/models/response/vendor_dto.dart';
// import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:flexiJobs/features/shared/entity/base_entity.dart';
//
// part 'jobs_shift_response_model.g.dart';
//
// @JsonSerializable()
// class JobShiftModel extends JobEntity {
//   JobShiftModel({
//     super.id,
//     super.title,
//     super.code,
//     super.status,
//     super.state,
//     super.description,
//     super.latitude,
//     super.longitude,
//     super.vendorPayTotalPrice,
//     super.vendorPayPricePerHour,
//     super.totalPrice,
//     super.pricePerHour,
//     super.userTotalPrice,
//     super.userPricePerHour,
//     super.startDate,
//     super.endDate,
//     super.startTime,
//     super.endTime,
//     super.shiftHours,
//     super.numOfApplicants,
//     super.vendorBranch,
//     super.vendorId,
//     super.vendorBranchId,
//     super.jobCategory,
//     super.jobCategoryId,
//     super.cityId,
//     super.vendorUserId,
//     super.vendors,
//     super.total
//   });
//   factory JobShiftModel.fromJson(Map<String, dynamic> json) =>
//       _$JobShiftModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$JobShiftModelToJson(this);
// }
//
// @JsonSerializable()
// class JobShiftResponseModel extends BaseEntity<List<JobShiftModel>> {
//     JobShiftResponseModel({
//     super.statusCode,
//     super.data,
//     super.message,
//     super.totalRecords,
//     super.hasMorePages,
//   });
//   factory JobShiftResponseModel.fromJson(Map<String, dynamic> json) =>
//       _$JobShiftResponseModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$JobShiftResponseModelToJson(this);
// }
