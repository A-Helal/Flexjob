import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/login/data/data_sources/login_data_sources.dart';
import 'package:flexiJobs/features/login/data/models/request/login_request_model.dart';
import 'package:flexiJobs/features/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';
 
@Injectable(as: LoginRepository)
class LoginRepositoryImp implements LoginRepository {
 LoginRepositoryImp({
    required this. loginRemoteDataSource,
  });
  final LoginRemoteDataSource loginRemoteDataSource;
 
 Future<CustomResponseType<String>> login({ 
  required LoginRequestModel loginRequestModel })async{

    return loginRemoteDataSource.login(loginRequestModel: loginRequestModel);
  }
}
