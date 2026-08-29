class AppValidators {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final String email = value.trim();
    final RegExp regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
      r"@[a-zA-Z0-9-]+"
      r"(\.[a-zA-Z0-9-]+)*$",
    );

    if (!regex.hasMatch(email)) {
      return 'Enter a valid email address';
    }

    if (email.length > 254) {
      return 'Email is too long';
    }

    if (email.startsWith('.') || email.endsWith('.')) {
      return 'Invalid email format';
    }

    if (email.contains('..')) {
      return 'Invalid email format';
    }

    return null;
  }
}
