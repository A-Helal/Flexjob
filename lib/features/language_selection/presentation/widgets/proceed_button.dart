import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/language_selection/domain/entities/app_language.dart';
import 'package:flexiJobs/features/language_selection/presentation/cubit/language_selection_cubit.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/cubit/locale_cubit/locale_cubit.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProceedButton extends StatelessWidget {
  const ProceedButton({super.key, required this.state});

  final LanguageSelectionState state;

  bool get _isEnabled => !state.isSaving && state.selected != null;

  Future<void> _onPressed(BuildContext context) async {
    if (!_isEnabled) return;

    final LanguageSelectionCubit cubit = context.read<LanguageSelectionCubit>();
    await cubit.persistChoice();

    final AppLanguage lang = cubit.state.selected!;
    getIt<LocaleCubit>().setLocale(context, lang.locale);
    MyApp.of(context).updateState();
    await LocalData.setFirstLogin();
    CustomMainRouter.appRouter.replace(GetStartedRoute());
  }

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: _isEnabled ? () => _onPressed(context) : null,
      width: double.infinity,
      height: 48.h,
      text: context.tr(AppLocalizationKeys.proceed),
      textStyle: AppTextStyle.semiBold_16,
      backgroundColor: _isEnabled ? Palette.primaryColor : Palette.grey_D1D1D1,
      textColor: _isEnabled ? Palette.white : Palette.grey_2C2C2C,
    );
  }
}
