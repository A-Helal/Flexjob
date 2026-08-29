import 'package:flexiJobs/core/app_data/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

part 'user_response_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
    UserModel({
    super.email,
    super.id,
    super.userableId,
    super.userableType
  });
  factory  UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserResponseModel extends BaseEntity<UserModel> {
   UserResponseModel({
    super.statusCode,
    super.data,
    super.message,
    super.totalRecords,
    super.hasMorePages,
  });
  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);
}
