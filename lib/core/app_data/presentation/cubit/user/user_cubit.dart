// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/core/app_data/constants/app_data_constants.dart';
import 'package:flexiJobs/core/app_data/domain/entities/app_user_entity.dart';
import 'package:flexiJobs/core/app_data/domain/use_cases/delete_user_account.dart';
import 'package:flexiJobs/core/app_data/domain/use_cases/get_user_info.dart';

import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/firebase/firebase_messaging_service.dart';

part 'user_state.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit({required this.getUserInfoUseCase, required this.deleteUserAccountUseCase}) : super(UserInitialState());
  final GetUserInfoUseCase getUserInfoUseCase;
  final DeleteUserAccountUseCase deleteUserAccountUseCase;

  Future<void> getUserInfo() async {
    emit(UserLoadingState());
    final CustomResponseType<AppUserEntity> eitherPackagesOrFailure =
        await getUserInfoUseCase(BaseRequestModel(relatedObjects: <String>[
      AppDataConstants.attachments,
      AppDataConstants.governorates,
      AppDataConstants.cities,
      AppDataConstants.users,
      AppDataConstants.paymentable,
      AppDataConstants.jobCategories,
    ]));

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(UserErrorState(message: FailureToMessage().map(failure)));
    }, (AppUserEntity response) async {
      LocalData.user = response;
      await LocalData.setUserInfo(response);

      // Subscribe to user-specific topic if notifications are authorized
      if (response.userId != null) {
        final FirebaseMessagingService firebaseService = FirebaseMessagingService();
        bool isAuthorized = await firebaseService.areNotificationsAuthorized();
        if (isAuthorized) {
          await firebaseService.subscribeToUserTopic(response.id!);
        }
      }

      emit(UserReadyState());
    });
  }

  Future<void> deleteUser() async {
    emit(UserLoadingState());
    final CustomResponseType<String> eitherPackagesOrFailure = await deleteUserAccountUseCase();

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(UserErrorState(message: FailureToMessage().map(failure)));
    }, (String response) {
      emit(UserDeletedState());
    });
  }
}
