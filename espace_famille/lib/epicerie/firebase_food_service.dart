import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/transfer_models.dart';
import '../app_services/error_handling_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFoodService{
  FirebaseFoodService();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Requête de liste des aliments dans l'epicerie
  Future<List<Food>> getGroceryList(Member member, BuildContext context)async{

    try{
      //1: Recherche de la liste d'épicerie
      QuerySnapshot taskSnapshot = await _db.collection('Organisations').doc(member.famId).collection('Groceries').get();
      await Future.delayed(const Duration(seconds: 1));
      //2: On fait la serialisation, ensuite on retourne la liste
      return taskSnapshot.docs.map((doc) {
        return Food.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }on FirebaseException  catch(e){
      //Gestion d'erreurs
      if(e.code == "network-request-failed"){
        ErrorHandling().showMessage("Sorry, no connection 😟 \n Please check your network", context,3);
      }
    }
    return [];
  }

  /// Requête d'ajout d'un aliment dans l'épicerie
  Future<void> addFoodToGrocery(Food food, File foodImage, Member member,BuildContext context)async {

    try{
      //1: Référence de l'emplacement future de l'image de l'aliment
      var foodImageStorageref = _storage.ref().child('groceryImages/${DateTime.now().millisecondsSinceEpoch}.jpg');

      //2: Televersement de l'image dans son emplacement designé
      UploadTask uploadTask = foodImageStorageref.putFile(foodImage);
      TaskSnapshot taskSnapshot = await uploadTask;

      //3: Telechargment du lien de l'image afin de l'atribuer à l'aliment
      food.imgUrl = await taskSnapshot.ref.getDownloadURL();

    }catch(e){
      //Gestion d'erreurs
      ErrorHandling().showMessage('Il y\'a une erreur avec l\'image fourni', context, 3);
      return;
    }

    //4: Si la procédure de l'image est reussi, on ajoute l'aliment dans la bd
    if(food.imgUrl != ''){
      try{
        CollectionReference groceryList = _db.collection('Organisations').doc(member.famId).collection('Groceries');
        food.id = groceryList.doc().id;
       // await groceryList.add(food.toJson());
        await groceryList.doc(food.id).set(food.toJson());
      }on FirebaseException  catch(e){
        if(e.code == "network-request-failed"){
          ErrorHandling().showMessage("Sorry, no connection 😟 \n Please check your network", context,3);
        }
      }
    }

  }

  /// Requête d'enregistrement d'un aliment
  Future<void> addSavedFoodToGrocery(Food food, Member member,BuildContext context)async {
    try{
      CollectionReference groceryList = _db.collection('Organisations').doc(member.famId).collection('Groceries');
      await groceryList.add(food.toJson());
    }on FirebaseException  catch(e){
      if(e.code == "network-request-failed"){
        ErrorHandling().showMessage("Sorry, no connection 😟 \n Please check your network", context,3);
      }
    }
  }

  /// Requête d'ajout d'un aliment enregistré dans l'épicerie
  Future<void> addToSavedFoodList(Food food, File foodImage, Member member,BuildContext context)async {

    try{

      CollectionReference groceryList = _db.collection('Organisations').doc(member.famId).collection('SavedGroceries');
      String foodDocId = groceryList.doc().id;
      SavedFood savedFood = SavedFood(food.imgUrl, foodDocId, food.name, 0);
      await groceryList.add(savedFood.toJson());
    }on FirebaseException  catch(e){
      if(e.code == "network-request-failed"){
        ErrorHandling().showMessage("Sorry, no connection 😟 \n Please check your network", context,3);
      }
    }
  }

  /// Requête qui change l'état d'un aliment (acheté / pas acheté)
  Future<Food?> setPurchasedFood(Food food, Member member,BuildContext context)async {

    try{
      DocumentReference foodDoc = _db.collection('Organisations/${member.famId}/Groceries').doc(food.id);
      foodDoc.update({
        'isPurchased' : !food.isPurchased
      });
      DocumentSnapshot updatedFood = await foodDoc.get();

      return Food.fromJson(updatedFood.data() as Map<String, dynamic>);
    }on FirebaseException  catch(e){
      if(e.code == "network-request-failed"){
        ErrorHandling().showMessage("Sorry, no connection 😟 \n Please check your network", context,3);
      }
    }

    return null;
  }

  /// Requête qui efface un aliment dans l'épicerie
  Future<void> deleteFoodFromGrocery(Food food,Member member,BuildContext context)async{
    CollectionReference groceryList = _db.collection('Organisations').doc(member.famId).collection('Groceries');
    try{
      groceryList.doc(food.id).delete();
    }on FirebaseException  catch(e){
      if(e.code == "network-request-failed"){
        ErrorHandling().showMessage("Sorry, no connection 😟 \n Please check your network", context,3);
      }

      //TODO: Gestion de suppression d'un element qui n'existe pas
    }
  }

  /// Requête qui efface un aliment dans la liste des aliments enregistrés
  Future<void> deletesavedFood(SavedFood savedfood,Member member,BuildContext context)async{
    CollectionReference groceryList = _db.collection('Organisations').doc(member.famId).collection('SavedGroceries');

    try{
      groceryList.doc(savedfood.id).delete();
    }on FirebaseException  catch(e){
      if(e.code == "network-request-failed"){
        ErrorHandling().showMessage("Sorry, no connection 😟 \n Please check your network", context,3);
      }

      //TODO: Gestion de suppression d'un element qui n'existe pas
    }
  }

}