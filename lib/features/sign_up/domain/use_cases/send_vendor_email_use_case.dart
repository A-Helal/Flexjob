 import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/login/data/models/request/login_request_model.dart';
import 'package:flexiJobs/features/login/domain/repositories/login_repository.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/sign_up_request_model.dart';
import 'package:flexiJobs/features/sign_up/data/models/request/vendor_requet_model.dart';
import 'package:flexiJobs/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:injectable/injectable.dart';
 


@injectable
class SendVendorEmailUseCase implements UseCase<String, VendorRequestModel> {
  SendVendorEmailUseCase({required this.signUpRepository});
  final SignUpRepository signUpRepository;

  @override
  Future<CustomResponseType<String>> call(
     VendorRequestModel  vendorRequestModel,
  ) async {
    return signUpRepository.sendVendorEmail(
     vendorRequestModel:vendorRequestModel,
    );
  }
}
