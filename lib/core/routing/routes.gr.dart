// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i27;
import 'package:camera/camera.dart' as _i30;
import 'package:collection/collection.dart' as _i31;
import 'package:flexiJobs/features/complete_profile/presentation/cubit/complete_profile_cubit.dart'
    as _i29;
import 'package:flexiJobs/features/complete_profile/presentation/screens/agreements_signing_screens.dart'
    as _i2;
import 'package:flexiJobs/features/complete_profile/presentation/screens/complete_profile_screen.dart'
    as _i4;
import 'package:flexiJobs/features/complete_profile/presentation/screens/payment_method_screen.dart'
    as _i17;
import 'package:flexiJobs/features/complete_profile/presentation/screens/personal_information_screen.dart'
    as _i18;
import 'package:flexiJobs/features/complete_profile/presentation/screens/skills_experience_screen.dart'
    as _i22;
import 'package:flexiJobs/features/complete_profile/presentation/screens/upload_documents_screen.dart'
    as _i24;
import 'package:flexiJobs/features/forget_password/presentation/screens/change_password_screen.dart'
    as _i3;
import 'package:flexiJobs/features/forget_password/presentation/screens/forget_password_screen.dart'
    as _i6;
import 'package:flexiJobs/features/get_started/presentation/screens/get_started_screen.dart'
    as _i7;
import 'package:flexiJobs/features/job_details/presentation/screens/job_details_screen.dart'
    as _i9;
import 'package:flexiJobs/features/job_details/presentation/widgets/qr_scanner_widget.dart'
    as _i19;
import 'package:flexiJobs/features/job_list/presentation/screens/job_list_screen.dart'
    as _i10;
import 'package:flexiJobs/features/jobs/presentation/screens/jobs_screen.dart'
    as _i11;
import 'package:flexiJobs/features/language_selection/presentation/screens/language_selection_screen.dart'
    as _i12;
import 'package:flexiJobs/features/login/presentation/screens/login_screen.dart'
    as _i13;
import 'package:flexiJobs/features/more/presentation/screens/about_us_screen.dart'
    as _i1;
import 'package:flexiJobs/features/more/presentation/screens/introduction_video_screen.dart'
    as _i8;
import 'package:flexiJobs/features/more/presentation/screens/more_screen.dart'
    as _i14;
import 'package:flexiJobs/features/more/presentation/screens/video_perview_screen.dart'
    as _i25;
import 'package:flexiJobs/features/more/presentation/screens/video_record_screen.dart'
    as _i26;
import 'package:flexiJobs/features/navigation_bottom/navigation_bottom.dart'
    as _i15;
import 'package:flexiJobs/features/notification/presentation/screens/notifications_screen.dart'
    as _i16;
import 'package:flexiJobs/features/shifts/presentation/screens/shifts_screen.dart'
    as _i20;
import 'package:flexiJobs/features/sign_up/presentation/screens/email_verification_screen.dart'
    as _i5;
import 'package:flexiJobs/features/sign_up/presentation/screens/sign_up_screen.dart'
    as _i21;
import 'package:flexiJobs/features/splash/presentation/screens/splash_screen.dart'
    as _i23;
import 'package:flutter/material.dart' as _i28;

/// generated route for
/// [_i1.AboutUsScreen]
class AboutUsRoute extends _i27.PageRouteInfo<void> {
  const AboutUsRoute({List<_i27.PageRouteInfo>? children})
    : super(AboutUsRoute.name, initialChildren: children);

  static const String name = 'AboutUsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutUsScreen();
    },
  );
}

/// generated route for
/// [_i2.AgreementsSigningScreens]
class AgreementsSigningRoutes
    extends _i27.PageRouteInfo<AgreementsSigningRoutesArgs> {
  AgreementsSigningRoutes({
    _i28.Key? key,
    required _i29.CompleteProfileCubit completeProfileCubit,
    bool viewMode = false,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         AgreementsSigningRoutes.name,
         args: AgreementsSigningRoutesArgs(
           key: key,
           completeProfileCubit: completeProfileCubit,
           viewMode: viewMode,
         ),
         initialChildren: children,
       );

  static const String name = 'AgreementsSigningRoutes';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AgreementsSigningRoutesArgs>();
      return _i2.AgreementsSigningScreens(
        key: args.key,
        completeProfileCubit: args.completeProfileCubit,
        viewMode: args.viewMode,
      );
    },
  );
}

class AgreementsSigningRoutesArgs {
  const AgreementsSigningRoutesArgs({
    this.key,
    required this.completeProfileCubit,
    this.viewMode = false,
  });

  final _i28.Key? key;

  final _i29.CompleteProfileCubit completeProfileCubit;

  final bool viewMode;

  @override
  String toString() {
    return 'AgreementsSigningRoutesArgs{key: $key, completeProfileCubit: $completeProfileCubit, viewMode: $viewMode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AgreementsSigningRoutesArgs) return false;
    return key == other.key &&
        completeProfileCubit == other.completeProfileCubit &&
        viewMode == other.viewMode;
  }

  @override
  int get hashCode =>
      key.hashCode ^ completeProfileCubit.hashCode ^ viewMode.hashCode;
}

/// generated route for
/// [_i3.ChangePasswordScreen]
class ChangePasswordRoute extends _i27.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i27.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i3.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i4.CompleteProfileScreen]
class CompleteProfileRoute extends _i27.PageRouteInfo<void> {
  const CompleteProfileRoute({List<_i27.PageRouteInfo>? children})
    : super(CompleteProfileRoute.name, initialChildren: children);

  static const String name = 'CompleteProfileRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i4.CompleteProfileScreen();
    },
  );
}

/// generated route for
/// [_i5.EmailVerificationScreen]
class EmailVerificationRoute
    extends _i27.PageRouteInfo<EmailVerificationRouteArgs> {
  EmailVerificationRoute({
    _i28.Key? key,
    required String email,
    bool callVerification = false,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         EmailVerificationRoute.name,
         args: EmailVerificationRouteArgs(
           key: key,
           email: email,
           callVerification: callVerification,
         ),
         initialChildren: children,
       );

  static const String name = 'EmailVerificationRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmailVerificationRouteArgs>();
      return _i5.EmailVerificationScreen(
        key: args.key,
        email: args.email,
        callVerification: args.callVerification,
      );
    },
  );
}

class EmailVerificationRouteArgs {
  const EmailVerificationRouteArgs({
    this.key,
    required this.email,
    this.callVerification = false,
  });

  final _i28.Key? key;

  final String email;

  final bool callVerification;

  @override
  String toString() {
    return 'EmailVerificationRouteArgs{key: $key, email: $email, callVerification: $callVerification}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EmailVerificationRouteArgs) return false;
    return key == other.key &&
        email == other.email &&
        callVerification == other.callVerification;
  }

  @override
  int get hashCode => key.hashCode ^ email.hashCode ^ callVerification.hashCode;
}

/// generated route for
/// [_i6.ForgetPasswordScreen]
class ForgetPasswordRoute extends _i27.PageRouteInfo<void> {
  const ForgetPasswordRoute({List<_i27.PageRouteInfo>? children})
    : super(ForgetPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgetPasswordRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i6.ForgetPasswordScreen();
    },
  );
}

/// generated route for
/// [_i7.GetStartedScreen]
class GetStartedRoute extends _i27.PageRouteInfo<void> {
  const GetStartedRoute({List<_i27.PageRouteInfo>? children})
    : super(GetStartedRoute.name, initialChildren: children);

  static const String name = 'GetStartedRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i7.GetStartedScreen();
    },
  );
}

/// generated route for
/// [_i8.IntroductionVideoScreen]
class IntroductionVideoRoute
    extends _i27.PageRouteInfo<IntroductionVideoRouteArgs> {
  IntroductionVideoRoute({
    _i28.Key? key,
    bool isSumbitted = false,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         IntroductionVideoRoute.name,
         args: IntroductionVideoRouteArgs(key: key, isSumbitted: isSumbitted),
         initialChildren: children,
       );

  static const String name = 'IntroductionVideoRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<IntroductionVideoRouteArgs>(
        orElse: () => const IntroductionVideoRouteArgs(),
      );
      return _i8.IntroductionVideoScreen(
        key: args.key,
        isSumbitted: args.isSumbitted,
      );
    },
  );
}

class IntroductionVideoRouteArgs {
  const IntroductionVideoRouteArgs({this.key, this.isSumbitted = false});

  final _i28.Key? key;

  final bool isSumbitted;

  @override
  String toString() {
    return 'IntroductionVideoRouteArgs{key: $key, isSumbitted: $isSumbitted}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! IntroductionVideoRouteArgs) return false;
    return key == other.key && isSumbitted == other.isSumbitted;
  }

  @override
  int get hashCode => key.hashCode ^ isSumbitted.hashCode;
}

/// generated route for
/// [_i9.JobDetailsScreen]
class JobDetailsRoute extends _i27.PageRouteInfo<JobDetailsRouteArgs> {
  JobDetailsRoute({
    _i28.Key? key,
    required _i9.JobDetailsRouteFrom jobDetailsRouteFrom,
    required int jobId,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         JobDetailsRoute.name,
         args: JobDetailsRouteArgs(
           key: key,
           jobDetailsRouteFrom: jobDetailsRouteFrom,
           jobId: jobId,
         ),
         initialChildren: children,
       );

  static const String name = 'JobDetailsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<JobDetailsRouteArgs>();
      return _i9.JobDetailsScreen(
        key: args.key,
        jobDetailsRouteFrom: args.jobDetailsRouteFrom,
        jobId: args.jobId,
      );
    },
  );
}

class JobDetailsRouteArgs {
  const JobDetailsRouteArgs({
    this.key,
    required this.jobDetailsRouteFrom,
    required this.jobId,
  });

  final _i28.Key? key;

  final _i9.JobDetailsRouteFrom jobDetailsRouteFrom;

  final int jobId;

  @override
  String toString() {
    return 'JobDetailsRouteArgs{key: $key, jobDetailsRouteFrom: $jobDetailsRouteFrom, jobId: $jobId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! JobDetailsRouteArgs) return false;
    return key == other.key &&
        jobDetailsRouteFrom == other.jobDetailsRouteFrom &&
        jobId == other.jobId;
  }

  @override
  int get hashCode =>
      key.hashCode ^ jobDetailsRouteFrom.hashCode ^ jobId.hashCode;
}

/// generated route for
/// [_i10.JobListScreen]
class JobListRoute extends _i27.PageRouteInfo<JobListRouteArgs> {
  JobListRoute({
    _i28.Key? key,
    required int categoryId,
    required String categoryName,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         JobListRoute.name,
         args: JobListRouteArgs(
           key: key,
           categoryId: categoryId,
           categoryName: categoryName,
         ),
         initialChildren: children,
       );

  static const String name = 'JobListRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<JobListRouteArgs>();
      return _i10.JobListScreen(
        key: args.key,
        categoryId: args.categoryId,
        categoryName: args.categoryName,
      );
    },
  );
}

class JobListRouteArgs {
  const JobListRouteArgs({
    this.key,
    required this.categoryId,
    required this.categoryName,
  });

  final _i28.Key? key;

  final int categoryId;

  final String categoryName;

  @override
  String toString() {
    return 'JobListRouteArgs{key: $key, categoryId: $categoryId, categoryName: $categoryName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! JobListRouteArgs) return false;
    return key == other.key &&
        categoryId == other.categoryId &&
        categoryName == other.categoryName;
  }

  @override
  int get hashCode =>
      key.hashCode ^ categoryId.hashCode ^ categoryName.hashCode;
}

/// generated route for
/// [_i11.JobsScreen]
class JobsRoute extends _i27.PageRouteInfo<void> {
  const JobsRoute({List<_i27.PageRouteInfo>? children})
    : super(JobsRoute.name, initialChildren: children);

  static const String name = 'JobsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i11.JobsScreen();
    },
  );
}

/// generated route for
/// [_i12.LanguageSelectionScreen]
class LanguageSelectionRoute extends _i27.PageRouteInfo<void> {
  const LanguageSelectionRoute({List<_i27.PageRouteInfo>? children})
    : super(LanguageSelectionRoute.name, initialChildren: children);

  static const String name = 'LanguageSelectionRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i12.LanguageSelectionScreen();
    },
  );
}

/// generated route for
/// [_i13.LoginScreen]
class LoginRoute extends _i27.PageRouteInfo<void> {
  const LoginRoute({List<_i27.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i13.LoginScreen();
    },
  );
}

/// generated route for
/// [_i14.MoreScreen]
class MoreRoute extends _i27.PageRouteInfo<void> {
  const MoreRoute({List<_i27.PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i14.MoreScreen();
    },
  );
}

/// generated route for
/// [_i15.NavigationMainScreen]
class NavigationMainRoute extends _i27.PageRouteInfo<void> {
  const NavigationMainRoute({List<_i27.PageRouteInfo>? children})
    : super(NavigationMainRoute.name, initialChildren: children);

  static const String name = 'NavigationMainRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i15.NavigationMainScreen();
    },
  );
}

/// generated route for
/// [_i16.NotificationsScreen]
class NotificationsRoute extends _i27.PageRouteInfo<void> {
  const NotificationsRoute({List<_i27.PageRouteInfo>? children})
    : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i16.NotificationsScreen();
    },
  );
}

/// generated route for
/// [_i17.PaymentMethodScreen]
class PaymentMethodRoute extends _i27.PageRouteInfo<PaymentMethodRouteArgs> {
  PaymentMethodRoute({
    _i28.Key? key,
    required _i29.CompleteProfileCubit completeProfileCubit,
    bool viewMode = false,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         PaymentMethodRoute.name,
         args: PaymentMethodRouteArgs(
           key: key,
           completeProfileCubit: completeProfileCubit,
           viewMode: viewMode,
         ),
         initialChildren: children,
       );

  static const String name = 'PaymentMethodRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PaymentMethodRouteArgs>();
      return _i17.PaymentMethodScreen(
        key: args.key,
        completeProfileCubit: args.completeProfileCubit,
        viewMode: args.viewMode,
      );
    },
  );
}

class PaymentMethodRouteArgs {
  const PaymentMethodRouteArgs({
    this.key,
    required this.completeProfileCubit,
    this.viewMode = false,
  });

  final _i28.Key? key;

  final _i29.CompleteProfileCubit completeProfileCubit;

  final bool viewMode;

  @override
  String toString() {
    return 'PaymentMethodRouteArgs{key: $key, completeProfileCubit: $completeProfileCubit, viewMode: $viewMode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaymentMethodRouteArgs) return false;
    return key == other.key &&
        completeProfileCubit == other.completeProfileCubit &&
        viewMode == other.viewMode;
  }

  @override
  int get hashCode =>
      key.hashCode ^ completeProfileCubit.hashCode ^ viewMode.hashCode;
}

/// generated route for
/// [_i18.PersonalInformationScreen]
class PersonalInformationRoute
    extends _i27.PageRouteInfo<PersonalInformationRouteArgs> {
  PersonalInformationRoute({
    _i28.Key? key,
    required _i29.CompleteProfileCubit completeProfileCubit,
    bool viewMode = false,
    bool fromUpdatePopup = false,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         PersonalInformationRoute.name,
         args: PersonalInformationRouteArgs(
           key: key,
           completeProfileCubit: completeProfileCubit,
           viewMode: viewMode,
           fromUpdatePopup: fromUpdatePopup,
         ),
         initialChildren: children,
       );

  static const String name = 'PersonalInformationRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PersonalInformationRouteArgs>();
      return _i18.PersonalInformationScreen(
        key: args.key,
        completeProfileCubit: args.completeProfileCubit,
        viewMode: args.viewMode,
        fromUpdatePopup: args.fromUpdatePopup,
      );
    },
  );
}

class PersonalInformationRouteArgs {
  const PersonalInformationRouteArgs({
    this.key,
    required this.completeProfileCubit,
    this.viewMode = false,
    this.fromUpdatePopup = false,
  });

  final _i28.Key? key;

  final _i29.CompleteProfileCubit completeProfileCubit;

  final bool viewMode;

  final bool fromUpdatePopup;

  @override
  String toString() {
    return 'PersonalInformationRouteArgs{key: $key, completeProfileCubit: $completeProfileCubit, viewMode: $viewMode, fromUpdatePopup: $fromUpdatePopup}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PersonalInformationRouteArgs) return false;
    return key == other.key &&
        completeProfileCubit == other.completeProfileCubit &&
        viewMode == other.viewMode &&
        fromUpdatePopup == other.fromUpdatePopup;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      completeProfileCubit.hashCode ^
      viewMode.hashCode ^
      fromUpdatePopup.hashCode;
}

/// generated route for
/// [_i19.QrScannerWidget]
class QrScannerWidget extends _i27.PageRouteInfo<void> {
  const QrScannerWidget({List<_i27.PageRouteInfo>? children})
    : super(QrScannerWidget.name, initialChildren: children);

  static const String name = 'QrScannerWidget';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i19.QrScannerWidget();
    },
  );
}

/// generated route for
/// [_i20.ShiftsScreen]
class ShiftsRoute extends _i27.PageRouteInfo<void> {
  const ShiftsRoute({List<_i27.PageRouteInfo>? children})
    : super(ShiftsRoute.name, initialChildren: children);

  static const String name = 'ShiftsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i20.ShiftsScreen();
    },
  );
}

/// generated route for
/// [_i21.SignUpScreen]
class SignUpRoute extends _i27.PageRouteInfo<void> {
  const SignUpRoute({List<_i27.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i21.SignUpScreen();
    },
  );
}

/// generated route for
/// [_i22.SkillsExperienceScreen]
class SkillsExperienceRoute
    extends _i27.PageRouteInfo<SkillsExperienceRouteArgs> {
  SkillsExperienceRoute({
    _i28.Key? key,
    required _i29.CompleteProfileCubit completeProfileCubit,
    bool viewMode = false,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         SkillsExperienceRoute.name,
         args: SkillsExperienceRouteArgs(
           key: key,
           completeProfileCubit: completeProfileCubit,
           viewMode: viewMode,
         ),
         initialChildren: children,
       );

  static const String name = 'SkillsExperienceRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SkillsExperienceRouteArgs>();
      return _i22.SkillsExperienceScreen(
        key: args.key,
        completeProfileCubit: args.completeProfileCubit,
        viewMode: args.viewMode,
      );
    },
  );
}

class SkillsExperienceRouteArgs {
  const SkillsExperienceRouteArgs({
    this.key,
    required this.completeProfileCubit,
    this.viewMode = false,
  });

  final _i28.Key? key;

  final _i29.CompleteProfileCubit completeProfileCubit;

  final bool viewMode;

  @override
  String toString() {
    return 'SkillsExperienceRouteArgs{key: $key, completeProfileCubit: $completeProfileCubit, viewMode: $viewMode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SkillsExperienceRouteArgs) return false;
    return key == other.key &&
        completeProfileCubit == other.completeProfileCubit &&
        viewMode == other.viewMode;
  }

  @override
  int get hashCode =>
      key.hashCode ^ completeProfileCubit.hashCode ^ viewMode.hashCode;
}

/// generated route for
/// [_i23.SplashScreen]
class SplashRoute extends _i27.PageRouteInfo<void> {
  const SplashRoute({List<_i27.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i23.SplashScreen();
    },
  );
}

/// generated route for
/// [_i24.UploadDocumentsScreen]
class UploadDocumentsRoute
    extends _i27.PageRouteInfo<UploadDocumentsRouteArgs> {
  UploadDocumentsRoute({
    _i28.Key? key,
    required _i29.CompleteProfileCubit completeProfileCubit,
    bool viewMode = false,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         UploadDocumentsRoute.name,
         args: UploadDocumentsRouteArgs(
           key: key,
           completeProfileCubit: completeProfileCubit,
           viewMode: viewMode,
         ),
         initialChildren: children,
       );

  static const String name = 'UploadDocumentsRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UploadDocumentsRouteArgs>();
      return _i24.UploadDocumentsScreen(
        key: args.key,
        completeProfileCubit: args.completeProfileCubit,
        viewMode: args.viewMode,
      );
    },
  );
}

class UploadDocumentsRouteArgs {
  const UploadDocumentsRouteArgs({
    this.key,
    required this.completeProfileCubit,
    this.viewMode = false,
  });

  final _i28.Key? key;

  final _i29.CompleteProfileCubit completeProfileCubit;

  final bool viewMode;

  @override
  String toString() {
    return 'UploadDocumentsRouteArgs{key: $key, completeProfileCubit: $completeProfileCubit, viewMode: $viewMode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UploadDocumentsRouteArgs) return false;
    return key == other.key &&
        completeProfileCubit == other.completeProfileCubit &&
        viewMode == other.viewMode;
  }

  @override
  int get hashCode =>
      key.hashCode ^ completeProfileCubit.hashCode ^ viewMode.hashCode;
}

/// generated route for
/// [_i25.VideoPreviewScreen]
class VideoPreviewRoute extends _i27.PageRouteInfo<VideoPreviewRouteArgs> {
  VideoPreviewRoute({
    required _i30.XFile video,
    required List<_i30.CameraDescription> cameras,
    _i28.Key? key,
    List<_i27.PageRouteInfo>? children,
  }) : super(
         VideoPreviewRoute.name,
         args: VideoPreviewRouteArgs(video: video, cameras: cameras, key: key),
         initialChildren: children,
       );

  static const String name = 'VideoPreviewRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoPreviewRouteArgs>();
      return _i25.VideoPreviewScreen(
        video: args.video,
        cameras: args.cameras,
        key: args.key,
      );
    },
  );
}

class VideoPreviewRouteArgs {
  const VideoPreviewRouteArgs({
    required this.video,
    required this.cameras,
    this.key,
  });

  final _i30.XFile video;

  final List<_i30.CameraDescription> cameras;

  final _i28.Key? key;

  @override
  String toString() {
    return 'VideoPreviewRouteArgs{video: $video, cameras: $cameras, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoPreviewRouteArgs) return false;
    return video == other.video &&
        const _i31.ListEquality().equals(cameras, other.cameras) &&
        key == other.key;
  }

  @override
  int get hashCode =>
      video.hashCode ^ const _i31.ListEquality().hash(cameras) ^ key.hashCode;
}

/// generated route for
/// [_i26.VideoRecordScreen]
class VideoRecordRoute extends _i27.PageRouteInfo<void> {
  const VideoRecordRoute({List<_i27.PageRouteInfo>? children})
    : super(VideoRecordRoute.name, initialChildren: children);

  static const String name = 'VideoRecordRoute';

  static _i27.PageInfo page = _i27.PageInfo(
    name,
    builder: (data) {
      return const _i26.VideoRecordScreen();
    },
  );
}
