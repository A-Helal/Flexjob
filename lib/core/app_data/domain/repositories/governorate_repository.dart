import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';

abstract class GovernorateRepository {

Future<CustomResponseType<BaseEntity<List<GovernorateEntity>>>> getGovernorates({ 
 required BaseRequestModel baseRequestModel });
  
}