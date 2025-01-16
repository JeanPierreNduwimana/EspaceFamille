import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../nav_menu.dart';
import '../services/design_service.dart';
import '../taches/model_tache.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});
  @override
  State<PageProfile> createState() => _PageProfileState();
}

DesignService _designService = DesignService();
List<Tache> taches = [
  Tache('Organiser le bureau et trier les documents important',getImage(),true),
  Tache('Préparer un repas équilibré pour le déjeuner',getImage(),false),
  Tache('Faire une promenade de 30 minutes dans un parc local.',getImage(),true),
  Tache('Apprendre 10 mots dans une nouvelle langue.',getImage(),false),
  Tache('Appeler un ami pour prendre des nouvelles.',getImage(),true),
  Tache('Nettoyer et organiser le réfrigérateur.',getImage(),false),
  Tache('Planifier un budget pour la semaine à venir.',getImage(),true),
  Tache('Lire un chapitre d\'un livre en cours.',getImage(),false),
  Tache('Réparer un objet ou un appareil ménager défectueux.',getImage(),true),
  Tache('Créer une playlist de musique motivante pour la journée.',getImage(),false)
];

class _PageProfileState extends State<PageProfile> {

  double value = 3.5;

  @override
  Widget build(BuildContext context) {
    Future<void> _onRefresh() async {
    }
    return Scaffold(
      appBar: _designService.appBar(context,'Mon profil', true),
      resizeToAvoidBottomInset: true, // Permet d'éviter que le clavier cache le contenu
      bottomNavigationBar: _designService.navigationBar(context, 0, setState),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Colors.cyan,
        child: Column(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top:16, left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(Icons.arrow_back_ios_new)
                                )
                              ],
                            ),
                          )),
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
                        Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top:16, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, '/listevaluation');
                                    },
                                      child: Image.asset('assets/images/task_list.png', height: 28, width: 28,fit: BoxFit.fill,color: Colors.white, colorBlendMode: BlendMode.difference,))
                                ],
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(height: 8,),
                    const Row(
                      children: [
                        Expanded(child: Text('Jean Pierre',textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.cyan),)),
                        Text('   |   ', style: TextStyle(fontSize: 24, color: Colors.grey)),
                        Expanded(child: Text('16-03-1999', textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)))
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Salut c\'est jean Pierre, Bonne journée', style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    _designService.getRatingStars(value, true)
                  ],
                ),
              ),
              const Row( // Titre Taches attribuées
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
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    onTap: () => _designService.dialogEvaluerTacheDetailsProfile(
                        false, context, taches[index], value),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Ajout de coins arrondis à l'image
                      child: Image.asset(
                        taches[index].img,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      _designService.maximumString(taches[index].descr, 28),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.cyan, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Fait',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.cyan,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Chaque lundi',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.cyan,
                      size: 18,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    tileColor: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )
                );

                }),
            )
          ],

        ),
      ),
      //drawer: NavMenu(),
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



