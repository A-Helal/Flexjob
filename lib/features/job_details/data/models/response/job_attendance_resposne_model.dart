import 'package:flexiJobs/core/app_data/data/models/response/app_user_response_model.dart';
import 'package:flexiJobs/features/job_details/domain/entity/job_attendance_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

part 'job_attendance_resposne_model.g.dart';

@JsonSerializable()
class JobAttanedanceResponseModel extends JobAttendanceEntity {
    JobAttanedanceResponseModel({
      super.actualCheckIn,
    super.actualCheckOut,
    super.checkIn,
    super.checkOut,
    super.appUserId,
    super.jobId,
    super.appUsers,
    super.amountShouldPay,
    super.jobApplicantId,
    super.vendorId,
  });
  factory  JobAttanedanceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$JobAttanedanceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobAttanedanceResponseModelToJson(this);
}
