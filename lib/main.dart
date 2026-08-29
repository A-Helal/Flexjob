import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flexiJobs/core/observers/app_bloc_observer.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get_it/get_it.dart';

import 'package:flexiJobs/core/theming/theme.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/core/routing/router_observer.dart';
import 'package:flexiJobs/core/routing/routes.dart';
import 'package:flexiJobs/features/shared/cubit/locale_cubit/locale_cubit.dart';
import 'package:flexiJobs/features/shared/cubit/theme_cubit/theme_cubit.dart';
import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flexiJobs/core/firebase/firebase_messaging_service.dart';

void main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await EasyLocalization.ensureInitialized();
  DartPingIOS.register();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register Crashlytics error handlers in production
  if (!kDebugMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    ErrorWidget.builder = (FlutterErrorDetails details) {
      FirebaseCrashlytics.instance.recordFlutterError(details);
      return const Material(
        child: Center(
          child: Text('Something went wrong. Please try again.'),
        ),
      );
    };
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  // Initialize Firebase Messaging after app starts to avoid blocking iOS
  // permission dialog on cold start.
  Future<void>.delayed(const Duration(milliseconds: 100), () {
    FirebaseMessagingService().init();
  });

  // Wire up global BlocObserver before any cubits are created
  Bloc.observer = const AppBlocObserver();

  await configureDependencies();

  // Register AppRouter after DI since it depends on nothing
  getIt.registerSingleton<AppRouter>(AppRouter());

  final LocaleCubit localCubit = getIt<LocaleCubit>();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const <Locale>[Locale('ar', 'KW'), Locale('en', 'US')],
      startLocale: localCubit.getCurrentLocale(),
      saveLocale: false,
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = getIt<AppRouter>();
  final ThemeCubit _themeCubit = getIt<ThemeCubit>();

  @override
  void initState() {
    super.initState();
    // Release the native splash once the first frame is drawn
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(430, 896),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            overscroll: false,
          ),
          routerConfig: _appRouter.config(
            deepLinkBuilder: (_) => const DeepLink(<PageRouteInfo<dynamic>>[
              SplashRoute(),
            ]),
            navigatorObservers: () => <NavigatorObserver>[
              CustomRouteObserver(),
            ],
          ),
          theme: _themeCubit.getTheme() ?? AppTheme.lightTheme,
          themeMode: _themeCubit.getThemeMode() ?? ThemeMode.light,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            FormBuilderLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            EasyLocalization.of(context)!.delegate,
          ],
          builder: EasyLoading.init(),
        );
      },
    );
  }

  void updateState() {
    setState(() {});
  }
}
