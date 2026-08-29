import 'package:equatable/equatable.dart';

import 'package:flexiJobs/core/app_data/data/models/response/app_user_response_model.dart';

class JobAttendanceEntity extends Equatable {
  const JobAttendanceEntity({
    this.actualCheckIn,
    this.actualCheckOut,
    this.checkIn,
    this.checkOut,
    this.appUserId,
    this.jobId,
    this.appUsers,
    this.amountShouldPay,
    this.jobApplicantId,
    this.vendorId,
 
  });
final String? actualCheckIn;
  final String? checkIn;
 final String? actualCheckOut;
 final String? checkOut;
 final int? appUserId;
 final int? jobId;
 final int? vendorId;
 final int? jobApplicantId;
 final int? amountShouldPay;
  
 
 final AppUserModel? appUsers;
  

  @override
  List<Object?> get props => <Object?>[];
}
