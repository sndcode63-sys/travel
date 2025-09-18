// Handles all validations in the app.
class Validators {
  // Email or Mobile Validator
  static String? emailOrMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email / Mobile number is required";
    }

    // Email pattern
    final emailRegex = RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$");

    // Mobile pattern (10 digit India)
    final mobileRegex = RegExp(r"^[0-9]{10}$");

    if (!emailRegex.hasMatch(value.trim()) &&
        !mobileRegex.hasMatch(value.trim())) {
      return "Enter valid email or mobile number";
    }

    return null;
  }

  // Password Validator
  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least 1 uppercase letter";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Password must contain at least 1 lowercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least 1 number";
    }
    if (!RegExp(r'[!@#$&*~]').hasMatch(value)) {
      return "Password must contain at least 1 special character (!@#\$&*~)";
    }
    return null;
  }
}
