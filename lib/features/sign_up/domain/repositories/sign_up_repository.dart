import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/sign_up_request_model.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/vendor_requet_model.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/verify_code_request_model.dart';

abstract class SignUpRepository {

 Future<CustomResponseType<String>> signup({ 
  required SignUpRequestModel signUpRequestModel });
 Future<CustomResponseType<String>> verifyCode({ 
  required VerifyCodeRequestModel verifyCodeRequestModel });
 Future<CustomResponseType<String>> resendCode({ 
  required String email });

  Future<CustomResponseType<String>> sendVendorEmail({required VendorRequestModel vendorRequestModel}) ;

  
}