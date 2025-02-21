


import 'package:espace_famille/models/transfer_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorHandling{
  ErrorHandling();

  /*bool signUpvalidation(SignUpRequest signUpRequest){

    //Si un des champs est vide
    if(signUpRequest.username == '' ||
        signUpRequest.birthday == '' ||
        signUpRequest.password == '' ||
        signUpRequest.confirmPassword == ''){

      return true;
    }

    //Si les mot de passe ne sont identiques
    if(signUpRequest.password != signUpRequest.confirmPassword){
      return true;
    }
    return false;
  } */

  String? errorUsernameController(String username){
    if(username.trim() == ''){
      return 'This field can\'t be empty';
    }

    if(username.contains(' ')){
      return 'You username can\'t containt gaps';
    }

    if(username.trim().length <= 2){
      return 'Username is too short';
    }
    return null;
  }

  String? errorEmptyField(String birthday){
    if(birthday == ''){
      return 'This field can\'t be empty';
    }
    return null;
  }

  String? errorpasswordController(String password, String confirmPassword){
    if(password.trim() == ''){
      return 'This field can\'t be empty';
    }
    if(password.trim().length <= 3){
      return 'This field can\'t be empty';
    }
    if(errorpasswordsNotTheSame(password, confirmPassword)){
      return 'Passwords are not the same';
    }
    return null;
  }
  String? errorconfirmPasswordController(String password, String confirmPassword){
    if(confirmPassword == ''){
      return 'This field can\'t be empty';
    }
    if(errorpasswordsNotTheSame(password, confirmPassword)){
      return 'Passwords are not the same';
    }
    return null;
  }

  bool errorpasswordsNotTheSame(String password, String confirmPassword){
    if(password != confirmPassword){
      return true;
    }
    return false;
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMessage(String message, BuildContext context, int duration){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: duration),),
    );
  }
}