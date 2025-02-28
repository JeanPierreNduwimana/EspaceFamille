import 'package:flutter/cupertino.dart';

class FormController{

  static TextEditingController username_controller = TextEditingController();
  static TextEditingController password_controller = TextEditingController();
  static TextEditingController passwordConfirm_controller = TextEditingController();
  static TextEditingController dateController = TextEditingController();
  static TextEditingController comment_controller = TextEditingController();
  static TextEditingController controllercommentRepondre = TextEditingController();
  static TextEditingController controllerContenuAnnonce = TextEditingController();
  static TextEditingController nom_aliment_controller = TextEditingController();
  static TextEditingController descr_aliment_controller = TextEditingController();
  static TextEditingController quantite_aliment_controller = TextEditingController();
  static TextEditingController controllerTitleEvent = TextEditingController();
  static TextEditingController controllerDescriptionEvent = TextEditingController();
  static TextEditingController controllerDateEvent = TextEditingController();

  FormController();

  void clearAllControllers(){
    username_controller.text = '';
    password_controller.text = '';
    passwordConfirm_controller.text = '';
    dateController.text = '';
    comment_controller.text = '';
    controllercommentRepondre.text = '';
    controllerContenuAnnonce.text = '';
    nom_aliment_controller.text = '';
    descr_aliment_controller.text = '';
    quantite_aliment_controller.text = '';
    controllerTitleEvent.text = '';
    controllerDescriptionEvent.text = '';
    controllerDateEvent.text = '';
  }

}