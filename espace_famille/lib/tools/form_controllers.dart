import 'package:flutter/cupertino.dart';

class FormController{

  static TextEditingController username_controller = TextEditingController();
  static TextEditingController password_controller = TextEditingController();
  static TextEditingController passwordConfirm_controller = TextEditingController();
  static TextEditingController dateController = TextEditingController();

  FormController();

  void clearAllControllers(){
    username_controller.text = '';
    password_controller.text = '';
    passwordConfirm_controller.text = '';
    dateController.text = '';
  }

}