import 'package:auto_route/auto_route.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/sign_up_bloc_wrapper.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/sign_up_bottom_sheet.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/sign_up_hero_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final SignUpCubit _signUpCubit = getIt<SignUpCubit>();
  final LoginCubit _loginCubit = getIt<LoginCubit>();

  late final TabController _tabController;
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  final GlobalKey<FormBuilderState> _companyFormKey =
      GlobalKey<FormBuilderState>();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _phoneCode = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  bool _enableEmailButton = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _animController.forward(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animController.dispose();
    _phoneNumber.dispose();
    _phoneCode.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _companyNameController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  void _resetCompanyForm() {
    _fullNameController.clear();
    _emailController.clear();
    _companyNameController.clear();
    _positionController.clear();
    _phoneNumber.clear();
    _phoneCode.clear();
    _companyFormKey.currentState?.reset();
    setState(() => _enableEmailButton = false);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SignUpBlocWrapper(
        signUpCubit: _signUpCubit,
        loginCubit: _loginCubit,
        onVendorEmailSent: _resetCompanyForm,
        child: Scaffold(
          backgroundColor: Palette.white,
          body: Column(
            children: <Widget>[
              SignUpHeroSection(fadeAnim: _fadeAnim),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: SignUpBottomSheet(
                      tabController: _tabController,
                      signUpCubit: _signUpCubit,
                      loginCubit: _loginCubit,
                      companyFormKey: _companyFormKey,
                      phoneNumber: _phoneNumber,
                      phoneCode: _phoneCode,
                      fullNameController: _fullNameController,
                      emailController: _emailController,
                      companyNameController: _companyNameController,
                      positionController: _positionController,
                      enableEmailButton: _enableEmailButton,
                      onEnableEmailButton: (bool val) =>
                          setState(() => _enableEmailButton = val),
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
