import 'package:bloc/bloc.dart';
import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/attachment_request_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/complete_payment_info_request_model.dart';
import 'package:flexiJobs/features/complete_profile/domain/use_case/complete_payment_info_use_case.dart';
import 'package:flexiJobs/features/complete_profile/domain/use_case/complete_skills_use_case.dart';
import 'package:flexiJobs/features/complete_profile/domain/use_case/get_universites.dart';
import 'package:flexiJobs/features/complete_profile/domain/use_case/sign_agreements_use_case.dart';
import 'package:injectable/injectable.dart';

import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/core/app_data/constants/app_data_constants.dart';
import 'package:flexiJobs/core/app_data/domain/entities/app_user_entity.dart';
import 'package:flexiJobs/core/app_data/domain/use_cases/get_user_info.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/complete_personal_info_request_model.dart';
import 'package:flexiJobs/features/complete_profile/domain/use_case/complete_personal_info_use_case.dart';
import 'package:flexiJobs/features/complete_profile/domain/use_case/upload_documents_use_case.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';

part 'complete_profile_state.dart';

@injectable
class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit({
    required this.completePersonalInfoUseCase,
    required this.getUserInfoUseCase,
    required this.uploadDocumentsUseCase,
    required this.completePaymentInfoUseCase,
    required this.completeSkillsAndExperienceInfoUseCase,
    required this.completeProfileUseCase,
    required this.getUniversitesUseCase,
  }) : super(CompleteProfileInitialState());

  final CompletePersonalInfoUseCase completePersonalInfoUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final UploadDocumentsUseCase uploadDocumentsUseCase;
  final CompletePaymentInfoUseCase completePaymentInfoUseCase;
  final CompleteSkillsAndExperienceInfoUseCase completeSkillsAndExperienceInfoUseCase;
  final CompleteProfileUseCase completeProfileUseCase;
  final GetUniversitesUseCase getUniversitesUseCase;

  Future<void> completePersonalInfo(
      {required CompletePersonalInfoRequestModel completePersonalInfoRequestModel}) async {
    emit(CompleteProfileLoadingState());
    final CustomResponseType<AppUserEntity> eitherPackagesOrFailure =
        await completePersonalInfoUseCase(completePersonalInfoRequestModel);

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(CompleteProfileErrorState(message: FailureToMessage().map(failure)));
    }, (AppUserEntity response) async {
      AppUserEntity userEntity = await getUserInfo();
      LocalData.user = userEntity;
      await LocalData.setUserInfo(userEntity);
      emit(CompleteProfileReadyState());
    });
  }

  Future<void> uploadDocuments({required List<AttachmentRequestModel> listAttachments}) async {
    emit(CompleteProfileLoadingState());
    final CustomResponseType<AppUserEntity> eitherPackagesOrFailure = await uploadDocumentsUseCase(listAttachments);

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(CompleteProfileErrorState(message: FailureToMessage().map(failure)));
    }, (AppUserEntity response) async {
      AppUserEntity userEntity = await getUserInfo();
      LocalData.user = userEntity;
      await LocalData.setUserInfo(userEntity);

      emit(CompleteProfileReadyState());
    });
  }

  Future<void> completePaymentInfo({required CompletePaymentInfoRequestModel completePaymentInfoRequestModel}) async {
    emit(CompleteProfileLoadingState());
    final CustomResponseType<AppUserEntity> eitherPackagesOrFailure =
        await completePaymentInfoUseCase(completePaymentInfoRequestModel);

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(CompleteProfileErrorState(message: FailureToMessage().map(failure)));
    }, (AppUserEntity response) async {
      AppUserEntity userEntity = await getUserInfo();
      LocalData.user = userEntity;
      await LocalData.setUserInfo(userEntity);
      emit(CompleteProfileReadyState());
    });
  }

  Future<void> completeSkills({required List<int> jobCategoriesIds}) async {
    emit(CompleteProfileLoadingState());
    final CustomResponseType<AppUserEntity> eitherPackagesOrFailure =
        await completeSkillsAndExperienceInfoUseCase(jobCategoriesIds);

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(CompleteProfileErrorState(message: FailureToMessage().map(failure)));
    }, (AppUserEntity response) async {
      AppUserEntity userEntity = await getUserInfo();
      LocalData.user = userEntity;
      await LocalData.setUserInfo(userEntity);
      emit(CompleteProfileReadyState());
    });
  }

  Future<void> completeProfile() async {
    emit(CompleteProfileLoadingState());
    final CustomResponseType<AppUserEntity> eitherPackagesOrFailure = await completeProfileUseCase();

    eitherPackagesOrFailure.fold((Failure failure) {
      emit(CompleteProfileErrorState(message: FailureToMessage().map(failure)));
    }, (AppUserEntity response) async {
      AppUserEntity userEntity = await getUserInfo();
      LocalData.user = userEntity;
      await LocalData.setUserInfo(userEntity);
      emit(CompleteProfileReadyState());
    });
  }

  Future<AppUserEntity> getUserInfo() async {
    AppUserEntity? userEntity;
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
      userEntity = LocalData.user;
    }, (AppUserEntity response) {
      userEntity = response;
    });
    return userEntity!;
  }

  Future<void> getUniversites({BaseRequestModel? baseRequestModel}) async {
    final CustomResponseType<List<GovernorateEntity>> eitherPackagesOrFailure =
        await getUniversitesUseCase(BaseRequestModel(page: 1, pageSize: 100, relatedObjects: <String>[]));

    eitherPackagesOrFailure.fold((Failure failure) {}, (List<GovernorateEntity> response) async {
      await LocalData.setUniversites(response);
    });
  }
}
