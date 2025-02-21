import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espace_famille/models/transfer_models.dart';
import 'package:espace_famille/services/error_handling_service.dart';
import 'package:espace_famille/tools/form_controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_management/accueil.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;
class FirebaseService{

  FirebaseService();

  bool isUserSignedIn(){
    bool signed = false;
    FirebaseAuth.instance.authStateChanges().listen((User? user){
          if (user == null){
            print('User is currently signed out!');
            signed = false;
          } else {
            print('User is signed in!');
            signed = true;
          }
        });

    return signed;
  }

  Future<void> signUp(SignUpRequest signUpRequest, BuildContext context)async {
    String email = '${signUpRequest.username.trim()}@espacefamille.com';

    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: signUpRequest.password
      );
      //ajout dans la bd firestore
      await FirebaseFirestore.instance.collection('Members').doc(
          userCredential.user!.uid).set({
        'anniversary': DateFormat('d/M/yyyy').parse(signUpRequest.birthday),
        'avgStars': 5,
        'famId': '',
        'profileDescr': '',
        'profileImgUrl': 'https://firebasestorage.googleapis.com/v0/b/espace-famille.firebasestorage.app/o/cat_profile_img.jpg?alt=media&token=45f1b705-a401-43ee-9220-2410eeaf8378',
        'username': signUpRequest.username,
      });
      FormController().clearAllControllers();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Accueil()), (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e){
      if(e.code == "email-already-in-use"){
        ErrorHandling().showMessage("The username is already taken", context,3);
      }else if(e.code == "weak-password"){
        ErrorHandling().showMessage("Your password is too weak \n Choose another one", context,3);
      }else if(e.code == "network-request-failed"){
        ErrorHandling().showMessage("Sorry, no connection 😟 \n Please check your network", context,3);
      }
    }

  }

  Future<void> logIn(LogInRequest logInRequest, BuildContext context)async{
    String logInEmail = '${logInRequest.username.trim()}@espacefamille.com';

    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: logInEmail,
        password: logInRequest.password,
      );
      FormController().clearAllControllers();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Accueil()), (Route<dynamic> route) => false,
      );

    } on FirebaseAuthException catch (e){
      if(e.code == "invalid-credential"){
        ErrorHandling().showMessage("User not found. Please sign up", context,3);
      }else if(e.code == "network-request-failed"){
        ErrorHandling().showMessage("Sorry, no connection 😟 \n Please check your network", context,3);
      }else{
        ErrorHandling().showMessage("Error during log in", context,3);
      }
    }
  }

}