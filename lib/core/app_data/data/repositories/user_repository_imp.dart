import 'package:flexiJobs/core/app_data/data/data_sources/user_app_data_sources.dart';
import 'package:flexiJobs/core/app_data/data/models/response/app_user_response_model.dart';
import 'package:flexiJobs/core/app_data/domain/repositories/user_repository.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/network/base_handling.dart';

@Injectable(as: UserRepository)
class UserRepositoryImp implements UserRepository {
  UserRepositoryImp({
    required this.userRemoteDataSource,
  });
  final UserRemoteDataSource userRemoteDataSource;
  Future<CustomResponseType<AppUserModel>> getUserInfo(
      {required BaseRequestModel baseRequestModel}) async {
    return userRemoteDataSource.getUserInfo(baseRequestModel: baseRequestModel);
  }

  @override
  Future<CustomResponseType< String>> deleteUser() {
        return userRemoteDataSource.deleteUser();

  }
}
