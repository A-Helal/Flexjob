part of 'language_selection_cubit.dart';

class LanguageSelectionState extends Equatable {
  const LanguageSelectionState({
    this.selected,
    this.isSaving = false,
  });

  final AppLanguage? selected;
  final bool isSaving;

  LanguageSelectionState copyWith({
    AppLanguage? selected,
    bool? isSaving,
    bool clearSelected = false,
  }) {
    return LanguageSelectionState(
      selected: clearSelected ? null : selected ?? this.selected,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  List<Object?> get props => <Object?>[selected, isSaving];
}
