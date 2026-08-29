import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/core/routing/routes.dart';
import 'package:flutter/cupertino.dart';

/// This class helps to recognize user selected condition and check them
class CustomConditionsHelper {
  CustomConditionsHelper(this.strings);

  final CustomFlutterPwValidatorStrings strings;
  Map<String, bool>? _selectedCondition;

  /// Recognize user selected condition from widget constructor to put them on map with their value
  void setSelectedCondition(int minLength, normalCharCount, uppercaseCharCount, lowercaseCharCount, numericCharCount,
      specialCharCount, hasMatch) {
    _selectedCondition = <String, bool>{
      if (minLength > 0) strings.atLeast: false,
      if (uppercaseCharCount > 0 && lowercaseCharCount > 0) strings.uppercaseLettersAndLowerCase: false,
      if (numericCharCount > 0) strings.numericCharactersAndSpecialCharacters: false,
      if (hasMatch > 0) strings.hasMatch: false,
    };
  }

  /// Checks condition new value and passed validator, sets that in map and return new value;
  ///
  dynamic checkCondition(
    int userRequestedValue,
    Function validator,
    TextEditingController controller,
    String key,
    dynamic oldValue, {
    List<int>? userRequestedValues,
  }) {
    dynamic newValue;

    if (userRequestedValues != null && userRequestedValues.isNotEmpty) {
      bool isValid = userRequestedValues.every((int i) => i > 0);
      if (isValid) {
        newValue = validator(controller.text, userRequestedValues[0], userRequestedValues[1]);
      } else
        newValue = null;
      if (newValue == null)
        return null;
      else if (newValue != oldValue) {
        _selectedCondition![key] = newValue;
        return newValue;
      } else
        return oldValue;
    } else {
      /// If the userRequested Value is grater than 0 that means user select them and we have to check new value;
      if (userRequestedValue > 0) {
        newValue = validator(controller.text, userRequestedValue);
      } else
        newValue = null;

      if (newValue == null)
        return null;
      else if (newValue != oldValue) {
        _selectedCondition![key] = newValue;
        return newValue;
      } else
        return oldValue;
    }
  }

  /// Check if the confirm password is match with password

  bool checkConfirmMatch(String password, String? confirm, String key, bool oldValue) {
    if (password == confirm) {
      _selectedCondition![key] = true;
      return true;
    } else {
      _selectedCondition![key] = false;
      return false;
    }
  }

  Map<String, bool>? getter() => _selectedCondition;
}

/// Strings hold constant strings used across the package
class CustomFlutterPwValidatorStrings {
  final String atLeast =
      getIt<AppRouter>().navigatorKey.currentContext!.tr(AppLocalizationKeys.atLeast8CharacterLength);
  final String uppercaseLettersAndLowerCase =
      getIt<AppRouter>().navigatorKey.currentContext!.tr(AppLocalizationKeys.oneUpperCaseAndLower);
  final String numericCharactersAndSpecialCharacters =
      getIt<AppRouter>().navigatorKey.currentContext!.tr(AppLocalizationKeys.oneSpecialCharacterAndNumeric);
  final String hasMatch = getIt<AppRouter>().navigatorKey.currentContext!.tr(AppLocalizationKeys.matches);
}
