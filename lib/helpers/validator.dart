class Validator {
  static final RegExp _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp _ucase = RegExp(r'[A-Z]');
  static final RegExp _digit = RegExp(r'\d');
  // match special characters except space
  static final RegExp _special = RegExp(r'(_|[^\w\d ])');

  static String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return 'Email is required.';
    } else if (!_emailRegex.hasMatch(text)) {
      return 'Enter a valid email.';
    }
    return null;
  }

  static String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return 'Password required.';
    } else if (text.length < 8) {
      return 'At least 8 characters required.';
    }
    // else if (!_ucase.hasMatch(text)) {
    //   return 'At least one uppercase (A-Z) required.';
    // } else if (!_digit.hasMatch(text)) {
    //   return 'At least one digit (0-9) required.';
    // } else if (!_special.hasMatch(text)) {
    //   return 'At least one special character required.';
    // }
    return null;
  }

  static String? validatePhoneNumber(String? text) {
    if (text == null || text.isEmpty) {
      return 'Phone number required.';
    } else if (text.length != 10) {
      return 'Enter a valid phone number.';
    }
    return null;
  }

  static String? checkIfEmpty(String placeHolder, String? text) {
    if (text == null || text.isEmpty) {
      return '$placeHolder is required.';
    }
    return null;
  }
}
