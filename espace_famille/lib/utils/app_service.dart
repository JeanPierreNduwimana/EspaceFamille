import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppService{
  AppService();
  DateTime? _selectedDate;
  Image? uploadedImage;

  //verification booléen de longueur maximale des description des tache
  String maximumString(String descrTache, int max){
    if(descrTache.length > max){
      String stringAEnvoyer = '';
      int index = 0;
      while(index < max){
        stringAEnvoyer += descrTache[index];
        index++;
      }
      return ('$stringAEnvoyer...');

    }else{
      return descrTache;
    }
  }

  String randomDefaultProfileImage(){
    //les images par default sont nommé de 1 à 5 .jpg
    //Donc on retourne un chiffre aléatoire correspondant à un image
    int imageName = Random().nextInt(4) + 1;
    return 'assets/images/default_profile_pictures/$imageName.jpg';
  }

  Future<String> getDatepicker(BuildContext context, Color primaryColor, bool wihFutureDates) async {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Date par défaut
      firstDate: wihFutureDates ? DateTime.now() : DateTime(1900),  // Date minimale
      lastDate: wihFutureDates ? DateTime(2065) : DateTime.now(),  // Date maximale
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            //primaryColor: Colors.cyan, // Accent sur les boutons
            colorScheme: isDarkMode ? ColorScheme.dark(
              primary: primaryColor, // Header background color & buttons
              onPrimary: Colors.black, // Text color on header buttons
              onSurface: Colors.white, // Text color for dates
            ): ColorScheme.light(
              primary: primaryColor, // Header background color & buttons
              onPrimary: Colors.white, // Text color on header buttons
              onSurface: Colors.black, // Text color for dates
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: primaryColor // Button text color
              ),
            ),
            dialogBackgroundColor: Colors.white, // Background color of the dialog
            scaffoldBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
        _selectedDate = pickedDate;
        return "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }else{
      return "";
    }
  }

  //region Ici se trouve les méthodes utilisé par les widgets dans cette classe
  Future<File?> getImage() async{
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    String? imagePath = pickedImage!.path;

    if(imagePath != ""){
      return File(imagePath);
    }

    return null;
  }
  void removeImage(StateSetter setState){
    uploadedImage = null;
    setState((){});
  }
}