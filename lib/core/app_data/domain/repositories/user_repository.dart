import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/app_data/domain/entities/app_user_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';

abstract class UserRepository {

 
Future<CustomResponseType< AppUserEntity>> getUserInfo({ 
 required BaseRequestModel baseRequestModel });

 Future<CustomResponseType< String>> deleteUser();

 
  
}