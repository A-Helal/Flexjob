import 'package:auto_route/auto_route.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter();
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(
          page: LanguageSelectionRoute.page,
        ),
        AutoRoute(
          page: GetStartedRoute.page,
        ),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: SignUpRoute.page,
        ),
        AutoRoute(
          page: EmailVerificationRoute.page,
        ),
        AutoRoute(
          page: JobListRoute.page,
        ),
        AutoRoute(
          page: NavigationMainRoute.page,
          children: <AutoRoute>[
            AutoRoute(page: JobsRoute.page, maintainState: false),
            AutoRoute(
              page: ShiftsRoute.page,
              maintainState: false,
            ),
            AutoRoute(
              page: MoreRoute.page,
              maintainState: false,
            ),
          ],
        ),
        AutoRoute(
          page: CompleteProfileRoute.page,
        ),
        AutoRoute(
          page: PersonalInformationRoute.page,
        ),
        AutoRoute(
          page: UploadDocumentsRoute.page,
        ),
        AutoRoute(
          page: PaymentMethodRoute.page,
        ),
        AutoRoute(
          page: SkillsExperienceRoute.page,
        ),
        AutoRoute(
          page: AgreementsSigningRoutes.page,
        ),
        AutoRoute(
          page: JobDetailsRoute.page,
        ),
        AutoRoute(
          page: ForgetPasswordRoute.page,
        ),
        AutoRoute(
          page: QrScannerWidget.page,
        ),
        AutoRoute(
          page: NotificationsRoute.page,
        ),
        AutoRoute(
          page: IntroductionVideoRoute.page,
        ),
        AutoRoute(
          page: AboutUsRoute.page,
        ),
        AutoRoute(
          page: VideoPreviewRoute.page,
        ),
        AutoRoute(
          page: VideoRecordRoute.page,
        ),
        AutoRoute(
          page: ChangePasswordRoute.page,
        ),
      ];
}
