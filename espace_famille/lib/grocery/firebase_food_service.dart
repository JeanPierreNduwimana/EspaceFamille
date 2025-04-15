import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espace_famille/utils/show_snackbar.dart';
import '../models/transfer_models.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFoodService {
  FirebaseFoodService();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Request of Grocery Food List
  Future<List<Food>> getGroceryList(Member member) async {
    try {
      // get of the grocery collection
      QuerySnapshot taskSnapshot = await _db
          .collection('Organisations')
          .doc(member.famId)
          .collection('Groceries')
          .get();
      await Future.delayed(const Duration(seconds: 1));
      // serialisation of the collection, return of the list
      return taskSnapshot.docs.map((doc) {
        return Food.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } on FirebaseException catch (e) {
      // Error handling
      if (e.code == "network-request-failed") {
        ShowSnackbar(
            message: "Sorry, no connection 😟 \n Please check your network");
      }
    }
    return [];
  }

  /// Request to add a food item to the grocery list
  Future<void> addFoodToGrocery(
      Food food, File foodImage, Member member) async {
    try {
      // Reference to the future location of the food image
      var foodImageStorageref = _storage
          .ref()
          .child('groceryImages/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the image to its designated location
      UploadTask uploadTask = foodImageStorageref.putFile(foodImage);
      TaskSnapshot taskSnapshot = await uploadTask;

      // Upload the image link to attribute it to the food
      food.imgUrl = await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      // Gestion d'erreurs
      ShowSnackbar(message: 'Il y\'a une erreur avec l\'image fourni');
      return;
    }

    //4: If the image procedure is successful, the food is added to the database
    if (food.imgUrl != '') {
      try {
        CollectionReference groceryList = _db
            .collection('Organisations')
            .doc(member.famId)
            .collection('Groceries');
        food.id = groceryList.doc().id;
        // await groceryList.add(food.toJson());
        await groceryList.doc(food.id).set(food.toJson());
      } on FirebaseException catch (e) {
        if (e.code == "network-request-failed") {
          ShowSnackbar(
              message: "Sorry, no connection 😟 \n Please check your network");
        }
      }
    }
  }

  /// Request for registration of a food
  Future<void> addSavedFoodToGrocery(Food food, Member member) async {
    try {
      CollectionReference groceryList = _db
          .collection('Organisations')
          .doc(member.famId)
          .collection('Groceries');
      await groceryList.add(food.toJson());
    } on FirebaseException catch (e) {
      if (e.code == "network-request-failed") {
        ShowSnackbar(
            message: "Sorry, no connection 😟 \n Please check your network");
      }
    }
  }

  /// Request to add a food item saved in the grocery store
  Future<void> addToSavedFoodList(
      Food food, File foodImage, Member member) async {
    try {
      CollectionReference groceryList = _db
          .collection('Organisations')
          .doc(member.famId)
          .collection('SavedGroceries');
      String foodDocId = groceryList.doc().id;
      SavedFood savedFood = SavedFood(food.imgUrl, foodDocId, food.name, 0);
      await groceryList.add(savedFood.toJson());
    } on FirebaseException catch (e) {
      if (e.code == "network-request-failed") {
        ShowSnackbar(
            message: "Sorry, no connection 😟 \n Please check your network");
      }
    }
  }

  /// Query that changes the status of a food (purchased / not purchased)
  Future<Food?> setPurchasedFood(Food food, Member member) async {
    try {
      DocumentReference foodDoc = _db
          .collection('Organisations/${member.famId}/Groceries')
          .doc(food.id);
      foodDoc.update({'isPurchased': !food.isPurchased});
      DocumentSnapshot updatedFood = await foodDoc.get();

      return Food.fromJson(updatedFood.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      if (e.code == "network-request-failed") {
        ShowSnackbar(
            message: "Sorry, no connection 😟 \n Please check your network");
      }
    }

    return null;
  }

  /// Query that deletes a food item in the grocery store
  Future<void> deleteFoodFromGrocery(Food food, Member member) async {
    CollectionReference groceryList = _db
        .collection('Organisations')
        .doc(member.famId)
        .collection('Groceries');
    try {
      groceryList.doc(food.id).delete();
    } on FirebaseException catch (e) {
      if (e.code == "network-request-failed") {
        ShowSnackbar(
            message: "Sorry, no connection 😟 \n Please check your network");
      }

      //TODO: Gestion de suppression d'un element qui n'existe pas
    }
  }

  /// Query that deletes a food from the list of saved foods
  Future<void> deletesavedFood(SavedFood savedfood, Member member) async {
    CollectionReference groceryList = _db
        .collection('Organisations')
        .doc(member.famId)
        .collection('SavedGroceries');

    try {
      groceryList.doc(savedfood.id).delete();
    } on FirebaseException catch (e) {
      if (e.code == "network-request-failed") {
        ShowSnackbar(
            message: "Sorry, no connection 😟 \n Please check your network");
      }

      //TODO: Gestion de suppression d'un element qui n'existe pas
    }
  }
}
