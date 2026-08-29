import 'package:equatable/equatable.dart';
import 'package:flexiJobs/core/app_data/presentation/enum/app_status.dart';
import 'package:json_annotation/json_annotation.dart';

class JobApplicantEntity extends Equatable {
  const JobApplicantEntity({this.id, this.status});

  final int? id;
  final String? status;

  @override
  List<Object?> get props => <Object?>[];
}
