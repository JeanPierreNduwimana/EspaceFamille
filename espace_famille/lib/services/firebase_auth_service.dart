import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espace_famille/authentification/connexion.dart';
import 'package:espace_famille/models/transfer_models.dart';
import 'package:espace_famille/services/error_handling_service.dart';
import 'package:espace_famille/tools/form_controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_management/accueil.dart';


class FirebaseAuthService{

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseAuthService();


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
      LogInRequest logInRequest = LogInRequest(signUpRequest.username, signUpRequest.password);
      await logIn(logInRequest, context);

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

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('username', logInRequest.username);
      prefs.setString('password', logInRequest.password);

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

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<bool> isUserSignedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  void directAuth(BuildContext context) async {

    bool isSignedIn = await FirebaseAuthService().isUserSignedIn();

    // Vérification si le widget est toujours monté avant de naviguer
    if (!context.mounted) return;

    // Déterminer la destination en fonction de l'état de connexion
    Widget destination = isSignedIn ? const Accueil() : const Connection();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => destination),
            (Route<dynamic> route) => false,
      );
    });

  }

}