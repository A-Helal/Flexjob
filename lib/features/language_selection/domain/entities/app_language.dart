import 'package:flutter/material.dart';

enum AppLanguage {
  english(langCode: 'en', locale: Locale('en', 'US')),
  arabic(langCode: 'ar', locale: Locale('ar', 'KW'));

  const AppLanguage({required this.langCode, required this.locale});

  final String langCode;
  final Locale locale;

  static AppLanguage fromLangCode(String code) =>
      code == AppLanguage.arabic.langCode
      ? AppLanguage.arabic
      : AppLanguage.english;
}
