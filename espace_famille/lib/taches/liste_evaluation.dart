import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../services/basic_service.dart';

BasicService _basicService = BasicService();

class ListeEvaluation extends StatefulWidget {
  const ListeEvaluation({super.key});

  @override
  State<ListeEvaluation> createState() => _ListeEvaluationState();
}
double value = 3.0;
class _ListeEvaluationState extends State<ListeEvaluation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _basicService.appBar('Evaluations de Jean Pierre'),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: (){
          Navigator.pushNamed(context, '/pageprofile');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    return ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          if(index == 0){
            return Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 20),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/cat_profile_img.jpg',
                        semanticLabel: 'Image du profil',
                        fit: BoxFit.cover,),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text('Jean Pierre', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.cyan),),
                  _basicService.getRatingStars(value),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    // Couleur de l'ombre avec opacité
                    spreadRadius: 2,
                    // Rayonnement de l'ombre
                    blurRadius: 2,
                    // Rayon du flou de l'ombre
                    offset: const Offset(1, 1), // Décalage horizontal et vertical de l'ombre
                  ),
                ]),
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: ClipOval(
                  child: Image.asset(
                    'assets/images/cat_profile_img.jpg',
                    semanticLabel: 'Image du profil',
                    fit: BoxFit.cover,),
                ),
              title: Column(
                children: [

                  Text(' ce que je pense de ca', style: const TextStyle(color: Colors.black,),),
                ],
              ),
            ),
          );
        });
  }
}
