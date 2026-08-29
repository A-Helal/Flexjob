abstract class LanguageRepository {
  bool get isLanguageSelectionCompleted;

  Future<void> migrateLegacyPreferencesIfNeeded();

  Future<void> saveLanguageChoice({required String langCode});
}
