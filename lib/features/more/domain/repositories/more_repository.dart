import 'package:dio/src/form_data.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

abstract class MoreRepository {
  Future<CustomResponseType<bool>> uploadVideo({required FormData file});
}
