import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espace_famille/authentification/connexion.dart';
import 'package:espace_famille/models/transfer_models.dart';
import 'package:espace_famille/app_services/error_handling_service.dart';
import 'package:espace_famille/utils/form_controllers.dart';
import 'package:espace_famille/utils/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../app_management/accueil.dart';

class FirebaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuthService();

  /// Authentification par inscription
  Future<void> signUp(SignUpRequest signUpRequest, BuildContext context) async {
    //1: Concatenation qui crée un email d'authentification pour l'utilisateur
    String email = '${signUpRequest.username.trim()}@espacefamille.com';

    try {
      //2: Requête d'authentification
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email, password: signUpRequest.password);

      //3: Instantiation d'un membre relié à l'utilisateur
      String memberId = userCredential.user!.uid;
      Member member = Member(
          DateFormat('d/M/yyyy').parse(signUpRequest.birthday),
          5,
          '',
          memberId,
          '',
          '',
          signUpRequest.username);

      //4: Ajout du membre dans la base de donnée
      await _db.collection('Members').doc(memberId).set(member.toJson());

      //5: Instance LoginRequest pour connecter directement l'utilisateur
      LogInRequest logInRequest =
          LogInRequest(signUpRequest.username, signUpRequest.password);

      //6: Connection de l'utilisateur
      await logIn(logInRequest, context);
    } on FirebaseAuthException catch (e) {
      //Gestion d'erreurs
      if (e.code == "email-already-in-use") {
        ShowSnackbar(message: "The username is already taken");
      } else if (e.code == "weak-password") {
        ShowSnackbar(
            message: "Your password is too weak \n Choose another one");
      } else if (e.code == "network-request-failed") {
        ShowSnackbar(
            message: "Sorry, no connection 😟 \n Please check your network");
      }
    }
  }

  /// Authentification par connection
  Future<void> logIn(LogInRequest logInRequest, BuildContext context) async {
    //1: Concatenation qui crée un email d'authentification pour l'utilisateur
    String logInEmail = '${logInRequest.username.trim()}@espacefamille.com';

    try {
      //2: Requête d'authentification
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: logInEmail,
        password: logInRequest.password,
      );

      //3: Les informations des champs sont effacés
      FormController().clearAllControllers();

      //4: Navigation vers la page d'accueil
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Accueil()),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      //Gestion d'erreurs
      if (e.code == "invalid-credential") {
        ShowSnackbar(message: "User not found. Please sign up");
      } else if (e.code == "network-request-failed") {
        ShowSnackbar(
            message: "Sorry, no connection 😟 \n Please check your network");
      } else {
        ShowSnackbar(message: "Error during log in");
      }
    }
  }

  /// Déconnection
  Future<void> signOut() async {
    await auth.signOut();
  }

  /// Verification si l'utilisateur est toujours connecté
  Future<bool> isUserSignedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  /// Authentification automatique de l'utilisateur
  void directAuth(BuildContext context) async {
    //1: Verification si l'utilisateur est toujours authentifié
    bool isSignedIn = await FirebaseAuthService().isUserSignedIn();

    //2: Déterminer la destination en fonction de l'état de connexion
    Widget destination = isSignedIn ? const Accueil() : const Connection();

    //3: Redirection vers la page de destination
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => destination),
        (Route<dynamic> route) => false,
      );
    });
  }
}
