import 'package:flexiJobs/features/language_selection/data/datasources/language_local_data_source.dart';
import 'package:flexiJobs/features/language_selection/domain/repositories/language_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LanguageRepository)
class LanguageRepositoryImpl implements LanguageRepository {
  LanguageRepositoryImpl(this._localDataSource);

  final LanguageLocalDataSource _localDataSource;

  @override
  bool get isLanguageSelectionCompleted =>
      _localDataSource.languageSelectionCompleted;

  @override
  Future<void> migrateLegacyPreferencesIfNeeded() async {
    if (!_localDataSource.hasLanguageSelectionCompletedKey &&
        _localDataSource.langCode != null) {
      await _localDataSource.setLanguageSelectionCompleted(true);
    }
  }

  @override
  Future<void> saveLanguageChoice({required String langCode}) async {
    await _localDataSource.setLangCode(langCode);
    await _localDataSource.setLanguageSelectionCompleted(true);
  }
}
