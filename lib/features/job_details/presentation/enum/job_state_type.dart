import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/core/routing/routes.dart';

enum JobStateType { canceld, applied, checkedIn, checkedout }

extension JobStateTypeHelper on JobStateType {
  static String getText(JobStateType state) {
    switch (state) {
      case JobStateType.applied:
        return getIt<AppRouter>().navigatorKey.currentContext!.tr(AppLocalizationKeys.appliedSuccessfully);
      case JobStateType.canceld:
        return getIt<AppRouter>().navigatorKey.currentContext!.tr(AppLocalizationKeys.cancelledSuccessfully);
      case JobStateType.checkedIn:
        return getIt<AppRouter>().navigatorKey.currentContext!.tr(AppLocalizationKeys.checkInSuccessfully);
      case JobStateType.checkedout:
        return getIt<AppRouter>().navigatorKey.currentContext!.tr(AppLocalizationKeys.checkedOutSuccessfully);
    }
  }
}
