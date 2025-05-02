import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorHandling {
  ErrorHandling();

  String? errorUsernameController(String username) {
    if (username.trim() == '') {
      return 'This field can\'t be empty';
    }

    if (username.contains(' ')) {
      return 'You username can\'t containt gaps';
    }

    if (username.trim().length <= 2) {
      return 'Username is too short';
    }
    return null;
  }

  String? errorEmptyField(String birthday) {
    if (birthday == '') {
      return 'This field can\'t be empty';
    }
    return null;
  }

  String? errorpasswordController(String password, String confirmPassword) {
    if (password.trim() == '') {
      return 'This field can\'t be empty';
    }
    if (password.trim().length <= 3) {
      return 'This field can\'t be empty';
    }
    if (errorpasswordsNotTheSame(password, confirmPassword)) {
      return 'Passwords are not the same';
    }
    return null;
  }

  String? errorconfirmPasswordController(
      String password, String confirmPassword) {
    if (confirmPassword == '') {
      return 'This field can\'t be empty';
    }
    if (errorpasswordsNotTheSame(password, confirmPassword)) {
      return 'Passwords are not the same';
    }
    return null;
  }

  bool errorpasswordsNotTheSame(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return true;
    }
    return false;
  }
}
