import 'dart:math';
import 'package:flutter/material.dart';

class SharedHelpers {
  SharedHelpers();

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMessage(
      {required String message,
      required BuildContext buildContext,
      int? duration}) {
    return ScaffoldMessenger.of(buildContext).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration ?? 3),
      ),
    );
  }

  //verification booléen de longueur maximale des description des tache
  String maximumString(String descrTache, int max) {
    if (descrTache.length > max) {
      String stringAEnvoyer = '';
      int index = 0;
      while (index < max) {
        stringAEnvoyer += descrTache[index];
        index++;
      }
      return ('$stringAEnvoyer...');
    } else {
      return descrTache;
    }
  }

  String randomDefaultProfileImage() {
    //les images par default sont nommé de 1 à 5 .jpg
    //Donc on retourne un chiffre aléatoire correspondant à un image
    int imageName = Random().nextInt(4) + 1;
    return 'assets/images/default_profile_pictures/$imageName.jpg';
  }
}
