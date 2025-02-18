import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

}