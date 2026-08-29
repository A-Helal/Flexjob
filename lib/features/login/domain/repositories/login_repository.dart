 
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/login/data/models/request/login_request_model.dart';

abstract class LoginRepository {

 Future<CustomResponseType<String>> login({ 
  required LoginRequestModel loginRequestModel });

  
}