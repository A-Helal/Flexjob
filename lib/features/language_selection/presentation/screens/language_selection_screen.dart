import 'package:auto_route/auto_route.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/language_selection/presentation/cubit/language_selection_cubit.dart';
import 'package:flexiJobs/features/language_selection/presentation/widgets/language_option_list.dart';
import 'package:flexiJobs/features/language_selection/presentation/widgets/language_selection_header.dart';
import 'package:flexiJobs/features/language_selection/presentation/widgets/language_selection_subtitle.dart';
import 'package:flexiJobs/features/language_selection/presentation/widgets/proceed_button.dart';
import 'package:flexiJobs/features/language_selection/presentation/widgets/saved_rights_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageSelectionCubit>(
      create: (_) => getIt<LanguageSelectionCubit>(),
      child: const _LanguageSelectionView(),
    );
  }
}

class _LanguageSelectionView extends StatelessWidget {
  const _LanguageSelectionView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocBuilder<LanguageSelectionCubit, LanguageSelectionState>(
            builder: (BuildContext context, LanguageSelectionState state) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                100.heightBox,
                const LanguageSelectionHeader(),
                48.heightBox,
                const LanguageSelectionSubtitle(),
                22.heightBox,
                LanguageOptionList(state: state),
                100.heightBox,
                ProceedButton(state: state),
                const Spacer(),
                const SavedRightsText(),
                22.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
