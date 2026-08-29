// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationRequestModel _$NotificationRequestModelFromJson(
  Map<String, dynamic> json,
) => NotificationRequestModel(
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['page_size'] as num?)?.toInt() ?? 10,
);

Map<String, dynamic> _$NotificationRequestModelToJson(
  NotificationRequestModel instance,
) => <String, dynamic>{'page': instance.page, 'page_size': instance.pageSize};
