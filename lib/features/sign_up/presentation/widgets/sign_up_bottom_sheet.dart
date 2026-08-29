import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/login/presentation/cubit/login_cubit.dart';
import 'package:flexiJobs/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/fill_company_form_widget.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/sign_up_form_widget.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/sign_up_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignUpBottomSheet extends StatelessWidget {
  const SignUpBottomSheet({
    super.key,
    required this.tabController,
    required this.signUpCubit,
    required this.loginCubit,
    required this.companyFormKey,
    required this.phoneNumber,
    required this.phoneCode,
    required this.fullNameController,
    required this.emailController,
    required this.companyNameController,
    required this.positionController,
    required this.enableEmailButton,
    required this.onEnableEmailButton,
  });

  final TabController tabController;
  final SignUpCubit signUpCubit;
  final LoginCubit loginCubit;
  final GlobalKey<FormBuilderState> companyFormKey;
  final TextEditingController phoneNumber;
  final TextEditingController phoneCode;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController companyNameController;
  final TextEditingController positionController;
  final bool enableEmailButton;
  final ValueChanged<bool> onEnableEmailButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Palette.white,
      ),
      child: Column(
        children: <Widget>[
          24.heightBox,
          SignUpTabBar(controller: tabController),
          16.heightBox,
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                SignUpFormWidget(
                  signUpCubit: signUpCubit,
                  loginCubit: loginCubit,
                ),
                FillCompanyFormWidget(
                  formKey: companyFormKey,
                  loginCubit: loginCubit,
                  fullNameController: fullNameController,
                  emailController: emailController,
                  companyController: companyNameController,
                  positionController: positionController,
                  signUpCubit: signUpCubit,
                  phoneNumber: phoneNumber,
                  phoneCode: phoneCode,
                  enableSendEmailButton: enableEmailButton,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
