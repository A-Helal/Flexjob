/// Validator class hold the RegExp for requested validation

class CustomValidator {
  /// Checks if password has minLength
  bool hasMinLength(String password, int minLength) {
    return password.length >= minLength ? true : false;
  }

  /// Checks if password has at least normal char letter matches
  bool hasMinNormalChar(String password, int normalCount) {
    String pattern = '^(.*?[A-Z]){' + normalCount.toString() + ',}';
    return password.toUpperCase().contains(new RegExp(pattern));
  }

  /// Checks if password has at least uppercaseCount uppercase letter matches
  bool hasMinUppercaseAndHasMinLowerCase(
      String password, int uppercaseCount, int lowercaseCount) {
    String pattern = '^(.*?[A-Z]){' + uppercaseCount.toString() + ',}';
    String lowerPattern = '^(.*?[a-z]){' + lowercaseCount.toString() + ',}';

    return (password.contains(new RegExp(pattern)) &&
        password.contains(new RegExp(lowerPattern)));
  }

  /// Checks if password has at least lowercaseCount lowercase letter matches
  bool hasMinLowercase(String password, int lowercaseCount) {
    String pattern = '^(.*?[a-z]){' + lowercaseCount.toString() + ',}';
    return password.contains(new RegExp(pattern));
  }

  /// Checks if password has at least numericCount numeric character matches
  bool hasMinNumericCharAndHasMinSpecialChar(
      String password, int numericCount, int specialCount) {
    String pattern = '^(.*?[0-9]){' + numericCount.toString() + ',}';
    String specialPattern =
        r"^(.*?[$&+,\:;/=?@#|'<>.^*()_%!-]){" + specialCount.toString() + ",}";
    return (password.contains(new RegExp(pattern)) &&
        password.contains(new RegExp(specialPattern)));
  }

  //Checks if password has at least specialCount special character matches
  bool hasMinSpecialChar(String password, int specialCount) {
    String pattern =
        r"^(.*?[$&+,\:;/=?@#|'<>.^*()_%!-]){" + specialCount.toString() + ",}";
    return password.contains(new RegExp(pattern));
  }
}
