// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flexiJobs/core/app_data/data/data_sources/governorate_data_sources.dart'
    as _i897;
import 'package:flexiJobs/core/app_data/data/data_sources/job_category_data_sources.dart'
    as _i15;
import 'package:flexiJobs/core/app_data/data/data_sources/user_app_data_sources.dart'
    as _i343;
import 'package:flexiJobs/core/app_data/data/repositories/governorate_repository_imp.dart'
    as _i309;
import 'package:flexiJobs/core/app_data/data/repositories/job_category_repository_imp.dart'
    as _i269;
import 'package:flexiJobs/core/app_data/data/repositories/user_repository_imp.dart'
    as _i187;
import 'package:flexiJobs/core/app_data/domain/repositories/governorate_repository.dart'
    as _i878;
import 'package:flexiJobs/core/app_data/domain/repositories/job_category_repository.dart'
    as _i394;
import 'package:flexiJobs/core/app_data/domain/repositories/user_repository.dart'
    as _i843;
import 'package:flexiJobs/core/app_data/domain/use_cases/delete_user_account.dart'
    as _i1011;
import 'package:flexiJobs/core/app_data/domain/use_cases/get_governorates.dart'
    as _i658;
import 'package:flexiJobs/core/app_data/domain/use_cases/get_job_categories.dart'
    as _i941;
import 'package:flexiJobs/core/app_data/domain/use_cases/get_user_info.dart'
    as _i300;
import 'package:flexiJobs/core/app_data/presentation/cubit/governorate/governorate_cubit.dart'
    as _i374;
import 'package:flexiJobs/core/app_data/presentation/cubit/job_category/job_category_cubit.dart'
    as _i885;
import 'package:flexiJobs/core/app_data/presentation/cubit/user/user_cubit.dart'
    as _i736;
import 'package:flexiJobs/core/di/register_module.dart' as _i540;
import 'package:flexiJobs/core/network/network_helper.dart' as _i569;
import 'package:flexiJobs/features/complete_profile/data/data_sources/complete_profile_data_sources.dart'
    as _i823;
import 'package:flexiJobs/features/complete_profile/data/repository/complete_profile_repository_imp.dart'
    as _i686;
import 'package:flexiJobs/features/complete_profile/domain/repository/complete_profile_repository.dart'
    as _i811;
import 'package:flexiJobs/features/complete_profile/domain/use_case/complete_payment_info_use_case.dart'
    as _i182;
import 'package:flexiJobs/features/complete_profile/domain/use_case/complete_personal_info_use_case.dart'
    as _i688;
import 'package:flexiJobs/features/complete_profile/domain/use_case/complete_skills_use_case.dart'
    as _i88;
import 'package:flexiJobs/features/complete_profile/domain/use_case/get_universites.dart'
    as _i610;
import 'package:flexiJobs/features/complete_profile/domain/use_case/sign_agreements_use_case.dart'
    as _i31;
import 'package:flexiJobs/features/complete_profile/domain/use_case/upload_documents_use_case.dart'
    as _i296;
import 'package:flexiJobs/features/complete_profile/presentation/cubit/complete_profile_cubit.dart'
    as _i310;
import 'package:flexiJobs/features/forget_password/data/data_sources/forget_password_data_sources.dart'
    as _i292;
import 'package:flexiJobs/features/forget_password/data/repositories/forget_password_repository_imp.dart'
    as _i14;
import 'package:flexiJobs/features/forget_password/domain/repositories/forget_password_repository.dart'
    as _i937;
import 'package:flexiJobs/features/forget_password/domain/use_cases/create_new_password_use_case.dart'
    as _i567;
import 'package:flexiJobs/features/forget_password/presentation/cubit/forget_password_cubit.dart'
    as _i23;
import 'package:flexiJobs/features/job_details/data/data_sources/job_details_data_sources.dart'
    as _i254;
import 'package:flexiJobs/features/job_details/data/repository/job_details_repository_imp.dart'
    as _i663;
import 'package:flexiJobs/features/job_details/domain/repository/job_details_repository.dart'
    as _i238;
import 'package:flexiJobs/features/job_details/domain/use_case/apply_on_job_use_case.dart'
    as _i893;
import 'package:flexiJobs/features/job_details/domain/use_case/cancel_job_use_case.dart'
    as _i371;
import 'package:flexiJobs/features/job_details/domain/use_case/check_in_use_case.dart'
    as _i2;
import 'package:flexiJobs/features/job_details/domain/use_case/check_out_use_case.dart'
    as _i645;
import 'package:flexiJobs/features/job_details/domain/use_case/get_job_details_use_case.dart'
    as _i981;
import 'package:flexiJobs/features/job_details/presentation/cubit/job_details_cubit.dart'
    as _i490;
import 'package:flexiJobs/features/job_list/data/data_sources/job_list_for_category_data_sources.dart'
    as _i817;
import 'package:flexiJobs/features/job_list/data/repositories/job_list_repository_imp.dart'
    as _i910;
import 'package:flexiJobs/features/job_list/domain/repositories/job_list_repository.dart'
    as _i497;
import 'package:flexiJobs/features/job_list/domain/use_cases/get_jobs_list_for_category.dart'
    as _i615;
import 'package:flexiJobs/features/job_list/presentation/cubit/job_list_cubit.dart'
    as _i373;
import 'package:flexiJobs/features/jobs/data/data_sources/job_data_source.dart'
    as _i698;
import 'package:flexiJobs/features/jobs/data/repositories/job_repository_imp.dart'
    as _i517;
import 'package:flexiJobs/features/jobs/domain/repositories/job_repository.dart'
    as _i311;
import 'package:flexiJobs/features/jobs/domain/use_cases/get_available_jobs_use_case.dart'
    as _i686;
import 'package:flexiJobs/features/jobs/domain/use_cases/get_home_data_use_case.dart'
    as _i113;
import 'package:flexiJobs/features/jobs/domain/use_cases/get_unread_notifications_count_use_case.dart'
    as _i854;
import 'package:flexiJobs/features/jobs/domain/use_cases/get_upcoming_shift_use_case.dart'
    as _i199;
import 'package:flexiJobs/features/jobs/presentation/cubit/jobs_cubit.dart'
    as _i429;
import 'package:flexiJobs/features/language_selection/data/datasources/language_local_data_source.dart'
    as _i159;
import 'package:flexiJobs/features/language_selection/data/repositories/language_repository_impl.dart'
    as _i1051;
import 'package:flexiJobs/features/language_selection/domain/repositories/language_repository.dart'
    as _i796;
import 'package:flexiJobs/features/language_selection/presentation/cubit/language_selection_cubit.dart'
    as _i337;
import 'package:flexiJobs/features/login/data/data_sources/login_data_sources.dart'
    as _i617;
import 'package:flexiJobs/features/login/data/repositories/login_repository_imp.dart'
    as _i251;
import 'package:flexiJobs/features/login/domain/repositories/login_repository.dart'
    as _i515;
import 'package:flexiJobs/features/login/domain/use_cases/login_use_case.dart'
    as _i779;
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart'
    as _i136;
import 'package:flexiJobs/features/more/data/data_sources/more_remote_data_sources.dart'
    as _i296;
import 'package:flexiJobs/features/more/data/repositories/more_repository_imp.dart'
    as _i527;
import 'package:flexiJobs/features/more/domain/repositories/more_repository.dart'
    as _i1064;
import 'package:flexiJobs/features/more/domain/use_cases/upload_video_use_case.dart'
    as _i820;
import 'package:flexiJobs/features/more/presentation/cubit/more_cubit.dart'
    as _i1061;
import 'package:flexiJobs/features/notification/data/data_sources/notification_remote_data_sources.dart'
    as _i1068;
import 'package:flexiJobs/features/notification/data/repositories/notification_repository_imp.dart'
    as _i299;
import 'package:flexiJobs/features/notification/domain/repositories/notification_repository.dart'
    as _i130;
import 'package:flexiJobs/features/notification/domain/use_cases/get_all_notifications_use_case.dart'
    as _i284;
import 'package:flexiJobs/features/notification/domain/use_cases/read_all_notifications_use_case.dart'
    as _i612;
import 'package:flexiJobs/features/notification/presentation/cubit/notification_cubit.dart'
    as _i649;
import 'package:flexiJobs/features/shared/cubit/locale_cubit/locale_cubit.dart'
    as _i999;
import 'package:flexiJobs/features/shared/cubit/theme_cubit/theme_cubit.dart'
    as _i907;
import 'package:flexiJobs/features/shared/widgets/custom_check_box/check_box_cubit.dart'
    as _i232;
import 'package:flexiJobs/features/shared/widgets/custom_date_picker/custom_date_picker_cubit.dart'
    as _i23;
import 'package:flexiJobs/features/shared/widgets/custom_file_picker/custom_file_picker_cubit.dart'
    as _i285;
import 'package:flexiJobs/features/shared/widgets/custom_map_picker/custom_map_picker_cubit.dart'
    as _i298;
import 'package:flexiJobs/features/shared/widgets/pdf_bottomsheet_widget/pdf_cubit.dart'
    as _i853;
import 'package:flexiJobs/features/shifts/data/data_sources/shift_data_sources.dart'
    as _i900;
import 'package:flexiJobs/features/shifts/data/repositories/shift_repository_imp.dart'
    as _i82;
import 'package:flexiJobs/features/shifts/domain/repositories/shift_repository.dart'
    as _i819;
import 'package:flexiJobs/features/shifts/domain/use_cases/get_applied_jobs_use_case.dart'
    as _i329;
import 'package:flexiJobs/features/shifts/domain/use_cases/get_past_jobs_use_case.dart'
    as _i512;
import 'package:flexiJobs/features/shifts/domain/use_cases/get_upcoming_jobs_use_case.dart'
    as _i980;
import 'package:flexiJobs/features/shifts/presentation/cubit/shift_cubit.dart'
    as _i87;
import 'package:flexiJobs/features/sign_up/data/data_sources/sign_up_data_sources.dart'
    as _i431;
import 'package:flexiJobs/features/sign_up/data/repositories/sign_up_repository_imp.dart'
    as _i263;
import 'package:flexiJobs/features/sign_up/domain/repositories/sign_up_repository.dart'
    as _i471;
import 'package:flexiJobs/features/sign_up/domain/use_cases/resend_code_use_case.dart'
    as _i888;
import 'package:flexiJobs/features/sign_up/domain/use_cases/send_vendor_email_use_case.dart'
    as _i361;
import 'package:flexiJobs/features/sign_up/domain/use_cases/sign_up_use_case.dart'
    as _i637;
import 'package:flexiJobs/features/sign_up/domain/use_cases/verify_code_use_case.dart'
    as _i359;
import 'package:flexiJobs/features/sign_up/presentation/cubit/sign_up_cubit.dart'
    as _i21;
import 'package:flexiJobs/features/version_check/data/data_sources/version_remote_data_source.dart'
    as _i670;
import 'package:flutter_session_manager/flutter_session_manager.dart' as _i611;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i999.LocaleCubit>(() => _i999.LocaleCubit());
  gh.factory<_i907.ThemeCubit>(() => _i907.ThemeCubit());
  gh.factory<_i23.DatePickerCubit>(() => _i23.DatePickerCubit());
  gh.factory<_i285.FilePickerCubit>(() => _i285.FilePickerCubit());
  gh.factory<_i298.LocationCubit>(() => _i298.LocationCubit());
  gh.factory<_i853.PDFCubit>(() => _i853.PDFCubit());
  await gh.singletonAsync<_i460.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  await gh.singletonAsync<_i611.SessionManager>(
    () => registerModule.sessionManager,
    preResolve: true,
  );
  gh.factory<_i159.LanguageLocalDataSource>(
    () => _i159.LanguageLocalDataSource(gh<_i460.SharedPreferences>()),
  );
  gh.factory<String>(() => registerModule.baseUrl, instanceName: 'BaseUrl');
  gh.factory<_i796.LanguageRepository>(
    () => _i1051.LanguageRepositoryImpl(gh<_i159.LanguageLocalDataSource>()),
  );
  gh.factory<_i337.LanguageSelectionCubit>(
    () => _i337.LanguageSelectionCubit(gh<_i796.LanguageRepository>()),
  );
  gh.factory<_i232.CheckboxCubit>(() => _i232.CheckboxCubit(gh<bool>()));
  gh.lazySingleton<_i361.Dio>(
    () => registerModule.dio(gh<String>(instanceName: 'BaseUrl')),
  );
  gh.factory<_i569.NetworkHelper>(() => _i569.NetworkHelper(gh<_i361.Dio>()));
  gh.factory<_i698.JobRemoteDataSource>(
    () => _i698.JobRemoteDataSourceImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i897.GovernorateRemoteDataSource>(
    () => _i897.GovernorateRemoteDataSourceImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i343.UserRemoteDataSource>(
    () => _i343.UserRemoteDataSourceImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i254.JobDetailsDataSources>(
    () => _i254.JobDetailsDataSourcesImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i296.MoreRemoteDataSource>(
    () => _i296.MoreRemoteDataSourceImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i292.ForgetPasswordDataSources>(
    () => _i292.ForgetPasswordDataSourcesImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i617.LoginRemoteDataSource>(
    () => _i617.DataSourceNameRemoteDataSourceImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i670.VersionRemoteDataSource>(
    () => _i670.VersionRemoteDataSourceImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i878.GovernorateRepository>(
    () => _i309.GovernorateRepositoryImp(
      governorateRemoteDataSource: gh<_i897.GovernorateRemoteDataSource>(),
    ),
  );
  gh.factory<_i15.JobCategoryRemoteDataSource>(
    () => _i15.GovernorateRemoteDataSourceImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i431.SignUpRemoteDataSource>(
    () => _i431.SignUpRemoteDataSourceImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i311.JobRepository>(
    () => _i517.JobRepositoryImpl(
      remoteDataSource: gh<_i698.JobRemoteDataSource>(),
    ),
  );
  gh.factory<_i1064.MoreRepository>(
    () => _i527.MoreRepositoryImp(
      moreRemoteDataSource: gh<_i296.MoreRemoteDataSource>(),
    ),
  );
  gh.factory<_i823.CompleteProfileDataSources>(
    () => _i823.CompleteProfileDataSourcesImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i900.ShiftRemoteDataSource>(
    () => _i900.ShiftRemoteDataSourceImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i817.JobListForCategortRemoteDataSource>(
    () => _i817.JobRemoteDataSourceImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i820.UploadVideoUseCase>(
    () => _i820.UploadVideoUseCase(moreRepository: gh<_i1064.MoreRepository>()),
  );
  gh.factory<_i113.GetHomeDataUseCase>(
    () => _i113.GetHomeDataUseCase(repository: gh<_i311.JobRepository>()),
  );
  gh.factory<_i811.CompleteProfileRepository>(
    () => _i686.CompleteProfileRepositoryImp(
      completeProfileDataSources: gh<_i823.CompleteProfileDataSources>(),
    ),
  );
  gh.factory<_i1068.NotificationRemoteDataSource>(
    () => _i1068.NotificationRemoteDataSourceImpl(gh<_i569.NetworkHelper>()),
  );
  gh.factory<_i394.JobCategoryRepository>(
    () => _i269.JobCategoryRepositoryImp(
      jobCategoryRemoteDataSource: gh<_i15.JobCategoryRemoteDataSource>(),
    ),
  );
  gh.factory<_i937.ForgetPasswordRepository>(
    () => _i14.ForgetPasswordRepositoryImp(
      forgetPasswordDataSources: gh<_i292.ForgetPasswordDataSources>(),
    ),
  );
  gh.factory<_i238.JobDetailsRepository>(
    () => _i663.JobDetailsRepositoryImp(
      jobDetailsDataSources: gh<_i254.JobDetailsDataSources>(),
    ),
  );
  gh.factory<_i819.ShiftRepository>(
    () => _i82.ShiftRepositoryImp(
      shiftRemoteDataSource: gh<_i900.ShiftRemoteDataSource>(),
    ),
  );
  gh.factory<_i658.GetGovernoratsUseCase>(
    () => _i658.GetGovernoratsUseCase(
      governorateRepository: gh<_i878.GovernorateRepository>(),
    ),
  );
  gh.factory<_i329.GetAppliedJobsUseCase>(
    () => _i329.GetAppliedJobsUseCase(
      shiftRepository: gh<_i819.ShiftRepository>(),
    ),
  );
  gh.factory<_i512.GetPastJobsUseCase>(
    () =>
        _i512.GetPastJobsUseCase(shiftRepository: gh<_i819.ShiftRepository>()),
  );
  gh.factory<_i980.GetUpcomingJobsUseCase>(
    () => _i980.GetUpcomingJobsUseCase(
      shiftRepository: gh<_i819.ShiftRepository>(),
    ),
  );
  gh.factory<_i471.SignUpRepository>(
    () => _i263.SignUpRepositoryImp(
      signUpRemoteDataSource: gh<_i431.SignUpRemoteDataSource>(),
    ),
  );
  gh.factory<_i515.LoginRepository>(
    () => _i251.LoginRepositoryImp(
      loginRemoteDataSource: gh<_i617.LoginRemoteDataSource>(),
    ),
  );
  gh.factory<_i843.UserRepository>(
    () => _i187.UserRepositoryImp(
      userRemoteDataSource: gh<_i343.UserRemoteDataSource>(),
    ),
  );
  gh.factory<_i893.ApplyOnJobUseCase>(
    () => _i893.ApplyOnJobUseCase(
      jobDetailsRepository: gh<_i238.JobDetailsRepository>(),
    ),
  );
  gh.factory<_i371.CancelJobUseCase>(
    () => _i371.CancelJobUseCase(
      jobDetailsRepository: gh<_i238.JobDetailsRepository>(),
    ),
  );
  gh.factory<_i2.CheckInUseCase>(
    () => _i2.CheckInUseCase(
      jobDetailsRepository: gh<_i238.JobDetailsRepository>(),
    ),
  );
  gh.factory<_i645.CheckoutUseCase>(
    () => _i645.CheckoutUseCase(
      jobDetailsRepository: gh<_i238.JobDetailsRepository>(),
    ),
  );
  gh.factory<_i981.GetJobDetailsUseCase>(
    () => _i981.GetJobDetailsUseCase(
      jobDetailsRepository: gh<_i238.JobDetailsRepository>(),
    ),
  );
  gh.factory<_i130.NotificationRepository>(
    () => _i299.NotificationRepositoryImpl(
      remoteDataSource: gh<_i1068.NotificationRemoteDataSource>(),
    ),
  );
  gh.factory<_i686.GetAvailableJobsUseCase>(
    () =>
        _i686.GetAvailableJobsUseCase(jobRepository: gh<_i311.JobRepository>()),
  );
  gh.factory<_i854.GetUnreadNotificationsCountUseCase>(
    () => _i854.GetUnreadNotificationsCountUseCase(
      jobRepository: gh<_i311.JobRepository>(),
    ),
  );
  gh.factory<_i199.GetUpComingShiftUseCase>(
    () =>
        _i199.GetUpComingShiftUseCase(jobRepository: gh<_i311.JobRepository>()),
  );
  gh.factory<_i497.JobListRepository>(
    () => _i910.JobListRepositoryImp(
      jobListForCategortRemoteDataSource:
          gh<_i817.JobListForCategortRemoteDataSource>(),
    ),
  );
  gh.factory<_i429.JobsCubit>(
    () => _i429.JobsCubit(
      getHomeDataUseCase: gh<_i113.GetHomeDataUseCase>(),
      getAvailableJobsUseCase: gh<_i686.GetAvailableJobsUseCase>(),
    ),
  );
  gh.factory<_i941.GetJobCategoriesUseCase>(
    () => _i941.GetJobCategoriesUseCase(
      jobCategoryRepository: gh<_i394.JobCategoryRepository>(),
    ),
  );
  gh.factory<_i1061.MoreCubit>(
    () => _i1061.MoreCubit(uploadVideoUseCase: gh<_i820.UploadVideoUseCase>()),
  );
  gh.factory<_i182.CompletePaymentInfoUseCase>(
    () => _i182.CompletePaymentInfoUseCase(
      completeProfileRepository: gh<_i811.CompleteProfileRepository>(),
    ),
  );
  gh.factory<_i688.CompletePersonalInfoUseCase>(
    () => _i688.CompletePersonalInfoUseCase(
      completeProfileRepository: gh<_i811.CompleteProfileRepository>(),
    ),
  );
  gh.factory<_i88.CompleteSkillsAndExperienceInfoUseCase>(
    () => _i88.CompleteSkillsAndExperienceInfoUseCase(
      completeProfileRepository: gh<_i811.CompleteProfileRepository>(),
    ),
  );
  gh.factory<_i610.GetUniversitesUseCase>(
    () => _i610.GetUniversitesUseCase(
      completeProfileRepository: gh<_i811.CompleteProfileRepository>(),
    ),
  );
  gh.factory<_i31.CompleteProfileUseCase>(
    () => _i31.CompleteProfileUseCase(
      completeProfileRepository: gh<_i811.CompleteProfileRepository>(),
    ),
  );
  gh.factory<_i296.UploadDocumentsUseCase>(
    () => _i296.UploadDocumentsUseCase(
      completeProfileRepository: gh<_i811.CompleteProfileRepository>(),
    ),
  );
  gh.factory<_i490.JobDetailsCubit>(
    () => _i490.JobDetailsCubit(
      checkInUseCase: gh<_i2.CheckInUseCase>(),
      checkoutUseCase: gh<_i645.CheckoutUseCase>(),
      applyOnJobUseCase: gh<_i893.ApplyOnJobUseCase>(),
      cancelJobUseCase: gh<_i371.CancelJobUseCase>(),
      getJobDetailsUseCase: gh<_i981.GetJobDetailsUseCase>(),
    ),
  );
  gh.factory<_i888.ResendCodeUseCase>(
    () =>
        _i888.ResendCodeUseCase(signUpRepository: gh<_i471.SignUpRepository>()),
  );
  gh.factory<_i361.SendVendorEmailUseCase>(
    () => _i361.SendVendorEmailUseCase(
      signUpRepository: gh<_i471.SignUpRepository>(),
    ),
  );
  gh.factory<_i637.SignUpUseCase>(
    () => _i637.SignUpUseCase(signUpRepository: gh<_i471.SignUpRepository>()),
  );
  gh.factory<_i359.VerifyCodeUseCase>(
    () =>
        _i359.VerifyCodeUseCase(signUpRepository: gh<_i471.SignUpRepository>()),
  );
  gh.factory<_i885.JobCategoryCubit>(
    () => _i885.JobCategoryCubit(
      getJobCategoriesUseCase: gh<_i941.GetJobCategoriesUseCase>(),
    ),
  );
  gh.factory<_i567.CreateNewPasswordUseCase>(
    () => _i567.CreateNewPasswordUseCase(
      forgetPasswordRepository: gh<_i937.ForgetPasswordRepository>(),
    ),
  );
  gh.factory<_i374.GovernorateCubit>(
    () => _i374.GovernorateCubit(
      getGovernoratsUseCase: gh<_i658.GetGovernoratsUseCase>(),
    ),
  );
  gh.factory<_i1011.DeleteUserAccountUseCase>(
    () => _i1011.DeleteUserAccountUseCase(
      userRepository: gh<_i843.UserRepository>(),
    ),
  );
  gh.factory<_i300.GetUserInfoUseCase>(
    () => _i300.GetUserInfoUseCase(userRepository: gh<_i843.UserRepository>()),
  );
  gh.factory<_i779.LoginUseCase>(
    () => _i779.LoginUseCase(loginRepository: gh<_i515.LoginRepository>()),
  );
  gh.factory<_i21.SignUpCubit>(
    () => _i21.SignUpCubit(
      signUpUseCase: gh<_i637.SignUpUseCase>(),
      verifyCodeUseCase: gh<_i359.VerifyCodeUseCase>(),
      resendCodeUseCase: gh<_i888.ResendCodeUseCase>(),
      sendVendorEmailUseCase: gh<_i361.SendVendorEmailUseCase>(),
    ),
  );
  gh.factory<_i615.GetAvailableJobsForCategoryUseCase>(
    () => _i615.GetAvailableJobsForCategoryUseCase(
      jobListRepository: gh<_i497.JobListRepository>(),
    ),
  );
  gh.factory<_i736.UserCubit>(
    () => _i736.UserCubit(
      getUserInfoUseCase: gh<_i300.GetUserInfoUseCase>(),
      deleteUserAccountUseCase: gh<_i1011.DeleteUserAccountUseCase>(),
    ),
  );
  gh.factory<_i284.GetAllNotificationsUseCase>(
    () => _i284.GetAllNotificationsUseCase(
      repository: gh<_i130.NotificationRepository>(),
    ),
  );
  gh.factory<_i612.ReadAllNotificationsUseCase>(
    () => _i612.ReadAllNotificationsUseCase(
      repository: gh<_i130.NotificationRepository>(),
    ),
  );
  gh.factory<_i87.ShiftsCubit>(
    () => _i87.ShiftsCubit(
      getUpcomingJobsUseCase: gh<_i980.GetUpcomingJobsUseCase>(),
      getPastJobsUseCase: gh<_i512.GetPastJobsUseCase>(),
      getAppliedJobsUseCase: gh<_i329.GetAppliedJobsUseCase>(),
      getUpComingShiftUseCase: gh<_i199.GetUpComingShiftUseCase>(),
    ),
  );
  gh.factory<_i310.CompleteProfileCubit>(
    () => _i310.CompleteProfileCubit(
      completePersonalInfoUseCase: gh<_i688.CompletePersonalInfoUseCase>(),
      getUserInfoUseCase: gh<_i300.GetUserInfoUseCase>(),
      uploadDocumentsUseCase: gh<_i296.UploadDocumentsUseCase>(),
      completePaymentInfoUseCase: gh<_i182.CompletePaymentInfoUseCase>(),
      completeSkillsAndExperienceInfoUseCase:
          gh<_i88.CompleteSkillsAndExperienceInfoUseCase>(),
      completeProfileUseCase: gh<_i31.CompleteProfileUseCase>(),
      getUniversitesUseCase: gh<_i610.GetUniversitesUseCase>(),
    ),
  );
  gh.factory<_i136.LoginCubit>(
    () => _i136.LoginCubit(loginUseCase: gh<_i779.LoginUseCase>()),
  );
  gh.factory<_i649.NotificationCubit>(
    () => _i649.NotificationCubit(
      getAllNotificationsUseCase: gh<_i284.GetAllNotificationsUseCase>(),
      readAllNotificationsUseCase: gh<_i612.ReadAllNotificationsUseCase>(),
    ),
  );
  gh.factory<_i373.JobListCubit>(
    () => _i373.JobListCubit(
      getAvailableJobsForCategoryUseCase:
          gh<_i615.GetAvailableJobsForCategoryUseCase>(),
    ),
  );
  gh.factory<_i23.ForgetPasswordCubit>(
    () => _i23.ForgetPasswordCubit(
      resendCodeUseCase: gh<_i888.ResendCodeUseCase>(),
      createNewPasswordUseCase: gh<_i567.CreateNewPasswordUseCase>(),
      verifyCodeUseCase: gh<_i359.VerifyCodeUseCase>(),
    ),
  );
  return getIt;
}

class _$RegisterModule extends _i540.RegisterModule {}
