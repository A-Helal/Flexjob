// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionModel _$AppVersionModelFromJson(Map<String, dynamic> json) =>
    AppVersionModel(
      androidVersion: (json['android_version'] as num?)?.toInt(),
      androidCriticalVersion: (json['android_critical_version'] as num?)
          ?.toInt(),
      iosVersion: (json['ios_version'] as num?)?.toInt(),
      iosCriticalVersion: (json['ios_critical_version'] as num?)?.toInt(),
      currentDatetime: json['current_datetime'] as String?,
    );

Map<String, dynamic> _$AppVersionModelToJson(AppVersionModel instance) =>
    <String, dynamic>{
      'android_version': instance.androidVersion,
      'android_critical_version': instance.androidCriticalVersion,
      'ios_version': instance.iosVersion,
      'ios_critical_version': instance.iosCriticalVersion,
      'current_datetime': instance.currentDatetime,
    };
