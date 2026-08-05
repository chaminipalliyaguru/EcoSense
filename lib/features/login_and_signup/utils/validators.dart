class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    // Basic email validation regex
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.\-_]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    final hasMinLength = value.length >= 8;
    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasNumber = value.contains(RegExp(r'[0-9]'));
    final hasSpecialChar = value.contains(RegExp(r'[!@#\$&*~]'));

    if (!hasMinLength || !hasUppercase || !hasNumber || !hasSpecialChar) {
      return 'Password must be at least 8 characters long,\nand include uppercase, number, and special character (!@#\$&*~)';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full Name is required';
    }
    return null;
  }
  
  static String? validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'User Name is required';
    }
    if (value.length < 3) {
      return 'User Name must be at least 3 characters long';
    }
    return null;
  }
}
