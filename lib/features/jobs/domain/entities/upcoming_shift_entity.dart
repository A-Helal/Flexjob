import 'package:equatable/equatable.dart';

class UpcomingShiftEntity extends Equatable {
  const UpcomingShiftEntity({
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
  final int jobId;
  final int appUserId;
  final DateTime? actualCheckIn;
  final DateTime? actualCheckOut;
  final int? vendorId;
  final int? jobApplicantId;
  final double? amountShouldPay;
  final String? upcomingShiftStartIn;

  bool get hasCheckedIn => actualCheckIn != null;

  @override
  List<Object?> get props => <Object?>[id, jobId, appUserId, actualCheckIn];
}