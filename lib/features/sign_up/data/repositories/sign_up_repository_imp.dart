import 'package:flexiJobs/features/sign_up/data/data_sources/sign_up_data_sources.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/sign_up_request_model.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/vendor_requet_model.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/verify_code_request_model.dart';
import 'package:flexiJobs/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';

 @Injectable(as: SignUpRepository)
 class SignUpRepositoryImp implements SignUpRepository {
  SignUpRepositoryImp({
required this. signUpRemoteDataSource,
   });
final SignUpRemoteDataSource signUpRemoteDataSource;
 
 Future<CustomResponseType<String>> signup({ 
required SignUpRequestModel signUpRequestModel })async{
 
   return signUpRemoteDataSource.signup(signUpRequestModel: signUpRequestModel);
  }
 Future<CustomResponseType<String>> verifyCode({ 
  required VerifyCodeRequestModel verifyCodeRequestModel })async{

    return signUpRemoteDataSource.verifyCode(verifyCodeRequestModel: verifyCodeRequestModel);
  }
 Future<CustomResponseType<String>> resendCode({ 
  required String email })async{  

    return signUpRemoteDataSource.resendCode(email: email);
  }

  @override
  Future<CustomResponseType<String>> sendVendorEmail({required VendorRequestModel vendorRequestModel}) {
   
    return signUpRemoteDataSource.sendVendorEmail(vendorRequestModel: vendorRequestModel);
  }
}
