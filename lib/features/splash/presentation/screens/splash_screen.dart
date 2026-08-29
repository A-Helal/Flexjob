import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/governorate/governorate_cubit.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/job_category/job_category_cubit.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/language_selection/domain/repositories/language_repository.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/version_check/data/data_sources/version_remote_data_source.dart';
import 'package:flexiJobs/features/version_check/data/models/app_version_model.dart';
import 'package:flexiJobs/features/version_check/helpers/version_comparison_helper.dart';
import 'package:flexiJobs/features/version_check/presentation/widgets/app_update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GovernorateCubit _governorateCubit = getIt<GovernorateCubit>();
  final JobCategoryCubit _jobCategoryCubit = getIt<JobCategoryCubit>();
  final VersionRemoteDataSource _versionRemoteDataSource =
      getIt<VersionRemoteDataSource>();
  Timer? _startupTimer;

  @override
  void initState() {
    super.initState();
    _startupTimer = Timer(const Duration(seconds: 2), _checkVersionAndNavigate);
  }

  @override
  void dispose() {
    _startupTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkVersionAndNavigate() async {
    try {
      final Either<Failure, AppVersionModel> result =
          await _versionRemoteDataSource.getAppVersion();

      await result.fold(
        (Failure failure) async => _handleFirstRoute(),
        (AppVersionModel versionModel) async {
          final UpdateType updateType =
              await VersionComparisonHelper.checkUpdateRequired(versionModel);

          if (!mounted) return;

          if (updateType == UpdateType.none) {
            await _handleFirstRoute();
          } else if (updateType == UpdateType.optional) {
            await AppUpdateDialog.show(context: context, isMandatory: false);
            await _handleFirstRoute();
          } else if (updateType == UpdateType.mandatory) {
            AppUpdateDialog.show(context: context, isMandatory: true);
            // Do not navigate — user must update
          }
        },
      );
    } catch (_) {
      await _handleFirstRoute();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset('assets/png/splash-background.png').image,
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Image.asset('assets/png/Flexijob-white.png'),
      ),
    );
  }

  Future<void> _handleFirstRoute() async {
    if (!mounted) return;

    final LanguageRepository languageRepository =
        getIt<LanguageRepository>();

    if (!languageRepository.isLanguageSelectionCompleted) {
      CustomMainRouter.appRouter.replace(LanguageSelectionRoute());
      return;
    }

    if (LocalData.getFirstLogin() == null) {
      await LocalData.setFirstLogin();
      CustomMainRouter.push(GetStartedRoute());
      return;
    }

    final String? token = await LocalData.getToken();
    if (token != null && !JwtDecoder.isExpired(token)) {
      _governorateCubit.getGovernorate();
      _jobCategoryCubit.getJobCategory();
      CustomMainRouter.push(
        NavigationMainRoute(children: <PageRouteInfo<dynamic>>[JobsRoute()]),
      );
    } else {
      CustomMainRouter.push(LoginRoute());
    }
  }
}
