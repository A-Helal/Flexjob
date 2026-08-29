import 'package:flexiJobs/features/language_selection/domain/entities/app_language.dart';
import 'package:flexiJobs/features/language_selection/presentation/cubit/language_selection_cubit.dart';
import 'package:flexiJobs/features/language_selection/presentation/widgets/language_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageOptionItem extends StatelessWidget {
  const LanguageOptionItem({
    super.key,
    required this.title,
    required this.assetPath,
    required this.language,
    required this.selected,
  });

  final String title;
  final String assetPath;
  final AppLanguage language;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return LanguageCard(
      title: title,
      assetPath: assetPath,
      selected: selected,
      onTap: () => context.read<LanguageSelectionCubit>().changeLanguage(
            language: language,
            context: context,
          ),
    );
  }
}