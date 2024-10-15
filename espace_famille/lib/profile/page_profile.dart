import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../services/basic_service.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});
  @override
  State<PageProfile> createState() => _PageProfileState();
}

BasicService _basicService = BasicService();
List<tache> taches = [
  tache('Organiser le bureau et trier les documents important',getImage()),
  tache('Préparer un repas équilibré pour le déjeuner',getImage()),
  tache('Faire une promenade de 30 minutes dans un parc local.',getImage()),
  tache('Apprendre 10 mots dans une nouvelle langue.',getImage()),
  tache('Appeler un ami pour prendre des nouvelles.',getImage()),
  tache('Nettoyer et organiser le réfrigérateur.',getImage()),
  tache('Planifier un budget pour la semaine à venir.',getImage()),
  tache('Lire un chapitre d\'un livre en cours.',getImage()),
  tache('Réparer un objet ou un appareil ménager défectueux.',getImage()),
  tache('Créer une playlist de musique motivante pour la journée.',getImage())
];

class _PageProfileState extends State<PageProfile> {

  double value = 3.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _basicService.appBar('Mon profil'),

      body: Column(
        children: [
          Container( //Bloc complet d'information utilisateur
            margin: const EdgeInsets.only(top: 24,left: 8,right: 8,bottom: 20),
            padding: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey.shade300, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1), // Couleur de l'ombre avec opacité
                    spreadRadius: 2, // Rayonnement de l'ombre
                    blurRadius: 2, // Rayon du flou de l'ombre
                    offset: Offset(1, 1), // Décalage horizontal et vertical de l'ombre
                  ),
                ]),
            child: Column( //Informations d'utilisateur
              children: [
                Row( // rangé contenant l'image
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                  ],
                ),
                const SizedBox(height: 8,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Jean Pierre', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.cyan),),
                    SizedBox(width: 8,),
                    Text('|', style: TextStyle(fontSize: 24, color: Colors.grey)),
                    SizedBox(width: 8,),
                    Text('16-03-1999', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic))
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Salut c\'est jean Pierre, Bonne journée', style: TextStyle(color: Colors.grey),),
                  ],
                ),
                const SizedBox(height: 8,),
                RatingStars(
                  value: value,
                  starBuilder: (index, color) => Icon(
                    Icons.star,
                    color: color,
                  ),
                  starCount: 5,
                  starSize: 20,
                  valueLabelColor: const Color(0xff9b9b9b),
                  valueLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0),
                  valueLabelRadius: 10,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: true,
                  valueLabelVisibility: true,
                  animationDuration: const Duration(milliseconds: 1000),
                  valueLabelPadding:
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  valueLabelMargin: const EdgeInsets.only(right: 8),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: Colors.yellow,
                ),
              ],
            ),
          ),
            const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Taches attribuées', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.cyan),),
            ],
          ),
          Expanded( //Bloc complet des listes des taches
            child: ListView.builder(
              itemCount: taches.length,
              itemBuilder: (BuildContext context, int index){
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey.shade300, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1), // Couleur de l'ombre avec opacité
                    spreadRadius: 2, // Rayonnement de l'ombre
                    blurRadius: 2, // Rayon du flou de l'ombre
                    offset: Offset(1, 1), // Décalage horizontal et vertical de l'ombre
                  ),
                ]),
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.asset(taches[index].img),
                  title: Text(taches[index].descr, style: TextStyle(color: Colors.black,),),
                ),
              );

              }),
          )
        ],

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        tooltip: 'justunbouton',
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, '/listetaches');
        },
      ),
    );
  }


}

String getImage(){
  int rnd = Random().nextInt(3);
  switch(rnd){
    case 0:
      return 'assets/images/bird.png';
    case 1:
      return 'assets/images/face_male.png';
    case 2:
      return 'assets/images/smiley_laughing.png';
    default:
      return 'assets/images/bird.png';
  }
}

class tache {

  String descr = '';
  String img = '';

  tache(String _descr, String _img){
    descr = _descr;
    img = _img;
  }
}
