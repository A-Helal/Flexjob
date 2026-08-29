import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/jobs/domain/entities/upcoming_shift_entity.dart';

part 'upcoming_shift_dto.g.dart';

@JsonSerializable(createToJson: false)
class UpcomingShiftDto {
  const UpcomingShiftDto({
    required this.id,
    required this.jobId,
    required this.appUserId,
    this.actualCheckIn,
    this.actualCheckOut,
    this.vendorId,
    this.jobApplicantId,
    this.amountShouldPay,
    this.upcomingShiftStartIn,
  });

  final int id;
  @JsonKey(name: 'job_id')
  final int jobId;
  @JsonKey(name: 'app_user_id')
  final int appUserId;
  @JsonKey(name: 'actual_check_in')
  final String? actualCheckIn;
  @JsonKey(name: 'actual_check_out')
  final String? actualCheckOut;
  @JsonKey(name: 'vendor_id')
  final int? vendorId;
  @JsonKey(name: 'job_applicant_id')
  final int? jobApplicantId;
  @JsonKey(name: 'amount_should_pay')
  final num? amountShouldPay;
  @JsonKey(name: 'upcoming_shift_start_in')
  final String? upcomingShiftStartIn;

  factory UpcomingShiftDto.fromJson(Map<String, dynamic> json) =>
      _$UpcomingShiftDtoFromJson(json);

  UpcomingShiftEntity toEntity() => UpcomingShiftEntity(
    id: id,
    jobId: jobId,
    appUserId: appUserId,
    actualCheckIn: _parseDateTime(actualCheckIn),
    actualCheckOut: _parseDateTime(actualCheckOut),
    vendorId: vendorId,
    jobApplicantId: jobApplicantId,
    amountShouldPay: amountShouldPay?.toDouble(),
    upcomingShiftStartIn: upcomingShiftStartIn,
  );

  static DateTime? _parseDateTime(String? raw) =>
      raw != null ? DateTime.tryParse(raw) : null;
}