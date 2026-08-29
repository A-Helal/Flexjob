import 'package:auto_route/auto_route.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/features/login/presentation/widgets/login_bloc_wrapper.dart';
import 'package:flexiJobs/features/login/presentation/widgets/login_bottom_sheet.dart';
import 'package:flexiJobs/features/login/presentation/widgets/login_hero_section.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final LoginCubit _loginCubit = getIt<LoginCubit>();
  final LocalAuthentication _auth = LocalAuthentication();
  List<BiometricType> _availableBiometrics = <BiometricType>[];

  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animController,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animController.forward();
      _loadBiometrics();
    });
  }

  Future<void> _loadBiometrics() async {
    final List<BiometricType> biometrics = await _auth.getAvailableBiometrics();
    setState(() => _availableBiometrics = biometrics);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: LoginBlocWrapper(
        loginCubit: _loginCubit,
        child: Scaffold(
          backgroundColor: Palette.white,
          body: Column(
            children: <Widget>[
              LoginHeroSection(fadeAnim: _fadeAnim),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: LoginBottomSheet(
                      loginCubit: _loginCubit,
                      availableBiometrics: _availableBiometrics,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
