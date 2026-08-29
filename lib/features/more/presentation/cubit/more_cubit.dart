import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/user/user_cubit.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/more/domain/use_cases/upload_video_use_case.dart';
import 'package:injectable/injectable.dart';

part 'more_state.dart';

@injectable
class MoreCubit extends Cubit<MoreState> {
  MoreCubit({required this.uploadVideoUseCase}) : super(MoreInitial());

  final UploadVideoUseCase uploadVideoUseCase;

  Future<void> uploadVideo({required FormData file}) async {
    emit(MoreLoadingState());
    await Future.delayed(Duration(milliseconds: 400));

    try {
      final CustomResponseType<bool> eitherPackagesOrFailure = await uploadVideoUseCase(file);

      eitherPackagesOrFailure.fold((Failure failure) {
        emit(MoreErrorState(message: FailureToMessage().map(failure)));
      }, (bool response) async {
        try {
          UserCubit _userCubit = getIt<UserCubit>();
          await _userCubit.getUserInfo();
          emit(MoreReadyState());
        } catch (e) {
          // Even if getUserInfo fails, video was uploaded successfully
          // Just emit ready state so user can proceed
          emit(MoreReadyState());
        }
      });
    } catch (e) {
      emit(MoreErrorState(message: 'Upload failed. Please try again.'));
    }
  }
}
