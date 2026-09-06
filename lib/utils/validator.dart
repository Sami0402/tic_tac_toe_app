class Validator {
  static String? username(String? input) {
    if (input!.isEmpty) {
      return 'Please enter your unique username';
    } else {
      return null;
    }
  }

  static String? email(String? input) {
    if (input!.isEmpty) {
      return 'Please enter your email';
    } else {
      return null;
    }
  }

  static String? password(String? input) {
    if (input!.isEmpty) {
      return 'Please enter your password';
    } else {
      return null;
    }
  }

  static String? confirmPassword(String? input, String password) {
    if (input != password) {
      return "Password doesn't match";
    } else if (input!.isEmpty) {
      return "Please enter confirm password";
    } else {
      return null;
    }
  }

  static String? roomId(String? input) {
    if (input!.isEmpty) {
      return 'Please enter Room ID';
    } else {
      return null;
    }
  }
}
