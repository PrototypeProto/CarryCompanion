String? isValidEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Please enter your email';
  } else if (!RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$')
      .hasMatch(email)) {
    return 'Please enter a valid email';
  }
  return null;
}

String? isValidUsername(String? username) {
  if (username == null || username.isEmpty) {
    return 'Please enter your username';
  } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username)) {
    return 'Usernames may only contain alphabetic and numeric characters';
  } else if (username.length >= 32) {
    return 'Usernames cannot exceed 32 characters';
  }
  return null;
}

bool isValidPassword(String? password) {
  if (password == null || password.isEmpty) {
    return false;
  } else if (password.length < 6) {
    return false;
  } else if (password.length >= 32) {
    return false;
  } else if (!RegExp(r'^[a-zA-Z0-9!@#$%^&*]+$')
      .hasMatch(password)) {
    return false;
  }
  return true;
}

/* TODO: controller does not save state of other upon immediately changing */
String? isValidPasswordMessage(String? password1, String? password2) {
  if (password1!.length == password2!.length && password1.compareTo(password2) != 0) {
    return 'Passwords do not match.';
  }
  if (password1 == null || password1.isEmpty) {
    return 'Please enter your new password';
  } else if (password1.length < 6) {
    return 'Password must be at least 6 characters long';
  } else if (password1.length >= 32) {
    return 'Passwords cannot exceed 32 characters';
  } else if (!RegExp(r'^[a-zA-Z0-9!@#$%^&*]+$')
      .hasMatch(password1)) {
    return 'Password contains invalid character';
  } else if (password1.length != password2.length) {
    return 'Passwords do not match.';
  }
  return null;
}
