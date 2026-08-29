import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flexiJobs/features/language_selection/domain/entities/app_language.dart';
import 'package:flexiJobs/features/language_selection/domain/repositories/language_repository.dart';
import 'package:flexiJobs/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'language_selection_state.dart';

@injectable
class LanguageSelectionCubit extends Cubit<LanguageSelectionState> {
  LanguageSelectionCubit(this._repository)
      : super(const LanguageSelectionState(selected: null));

  final LanguageRepository _repository;

  Future<void> persistChoice() async {
    final AppLanguage? choice = state.selected;
    if (choice == null) {
      return;
    }
    emit(state.copyWith(isSaving: true));
    await _repository.saveLanguageChoice(langCode: choice.langCode);
    emit(state.copyWith(isSaving: false));
  }

  Future<void> changeLanguage({
    required AppLanguage language,
    required BuildContext context,
  }) async {
    emit(state.copyWith(selected: language));
    await context.setLocale(language.locale);
    MyApp.of(context).updateState();
  }
}
