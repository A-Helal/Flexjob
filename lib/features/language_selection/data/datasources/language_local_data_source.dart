import 'package:flexiJobs/features/language_selection/data/constants/language_preference_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class LanguageLocalDataSource {
  LanguageLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  bool get hasLanguageSelectionCompletedKey => _prefs.containsKey(LanguagePreferenceKeys.languageSelectionCompleted);

  bool get languageSelectionCompleted => _prefs.getBool(LanguagePreferenceKeys.languageSelectionCompleted) ?? false;

  String? get langCode => _prefs.getString(LanguagePreferenceKeys.langCode);

  Future<void> setLangCode(String langCode) => _prefs.setString(LanguagePreferenceKeys.langCode, langCode);

  Future<void> setLanguageSelectionCompleted(bool value) =>
      _prefs.setBool(LanguagePreferenceKeys.languageSelectionCompleted, value);
}
