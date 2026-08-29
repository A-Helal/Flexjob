import 'package:flexiJobs/features/sign_up/data/models/request/sign_up_request_model.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/vendor_requet_model.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/verify_code_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/network/network_helper.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';

abstract class SignUpRemoteDataSource {
  Future<CustomResponseType<String>> signup({required SignUpRequestModel signUpRequestModel});
  Future<CustomResponseType<String>> verifyCode({required VerifyCodeRequestModel verifyCodeRequestModel});
  Future<CustomResponseType<String>> resendCode({required String email});

  Future<CustomResponseType<String>> sendVendorEmail({required VendorRequestModel vendorRequestModel});
}

@Injectable(as: SignUpRemoteDataSource)
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  SignUpRemoteDataSourceImpl(this.networkHelper);
  final NetworkHelper networkHelper;

  @override
  Future<CustomResponseType<String>> signup({required SignUpRequestModel signUpRequestModel}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.post(path: ApiConstants.register, data: signUpRequestModel.toJson());

    if (result.success) {
      return right(result.response['data']['users']['email']);
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<String>> verifyCode({required VerifyCodeRequestModel verifyCodeRequestModel}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.post(path: ApiConstants.verifyCode, data: verifyCodeRequestModel.toJson());

    if (result.success) {
      return right(result.response['data']['token']);
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

  @override
  Future<CustomResponseType<String>> resendCode({required String email}) async {
    ({dynamic response, bool success}) result =
        await networkHelper.post(path: ApiConstants.resendVerificationCode, data: {"email": email});

    if (result.success) {
      return right("Sucess");
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }
  
 
  @override
  Future<CustomResponseType<String>> sendVendorEmail({
    required VendorRequestModel vendorRequestModel
  }) async {
    ({dynamic response, bool success}) result =
        await networkHelper.post(path: ApiConstants.sendVendorEmail,data: vendorRequestModel.toJson());

    if (result.success) {
      return right("success");
    } else {
      return left(ServerFailure(message: result.response as String));
    }
  }

}
