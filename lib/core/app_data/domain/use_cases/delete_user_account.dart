import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/app_data/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
  
 

@injectable
class DeleteUserAccountUseCase implements UseCaseNoParam< String> {
  DeleteUserAccountUseCase({required this.userRepository});
  final UserRepository userRepository;

  @override
   Future<CustomResponseType<String>> call() async {
    return userRepository.deleteUser();
  }
}
