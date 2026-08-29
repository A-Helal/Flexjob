import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/version_check/domain/entities/app_version_entity.dart';

part 'app_version_model.g.dart';

@JsonSerializable()
class AppVersionModel extends AppVersionEntity {
  @JsonKey(name: 'android_version')
  final int? androidVersion;

  @JsonKey(name: 'android_critical_version')
  final int? androidCriticalVersion;

  @JsonKey(name: 'ios_version')
  final int? iosVersion;

  @JsonKey(name: 'ios_critical_version')
  final int? iosCriticalVersion;

  @JsonKey(name: 'current_datetime')
  final String? currentDatetime;

  const AppVersionModel({
    this.androidVersion,
    this.androidCriticalVersion,
    this.iosVersion,
    this.iosCriticalVersion,
    this.currentDatetime,
  }) : super(
          androidVersion: androidVersion,
          androidCriticalVersion: androidCriticalVersion,
          iosVersion: iosVersion,
          iosCriticalVersion: iosCriticalVersion,
          currentDatetime: currentDatetime,
        );

  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppVersionModelToJson(this);
}
