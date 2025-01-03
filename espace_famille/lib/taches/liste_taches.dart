import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../nav_menu.dart';
import '../services/design_service.dart';
import 'model_tache.dart';

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

class ListeTaches extends StatefulWidget {
  const ListeTaches({super.key});

  @override
  State<ListeTaches> createState() => _ListeTachesState();
}

class _ListeTachesState extends State<ListeTaches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar('Tâches disponibles'),
      body: buildBody(),
      drawer: NavMenu(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: (){
          Navigator.pushNamed(context, '/classement');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    return ListView.builder(
        itemCount: taches.length,
        itemBuilder: (BuildContext context, int index) {

          if(index == 0){ // À l'index 0, on affiche les infos du profil
            return Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Image.asset('assets/images/task_list.png'),
                  const SizedBox(height: 32),
                  const Text('Selectionner la taches qui vous convient avec votre disponibilité', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
              onTap: () {
                showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  height: 400,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 24,),
                      Image.asset(taches[index].img),
                        const SizedBox(height: 18,),
                      Text(taches[index].descr),
                        const SizedBox(height: 24,),
                      ListView.builder(shrinkWrap: true,itemCount: taches[index].sous_taches.length, itemBuilder: (BuildContext context, int i){
                        return Text('\n• ${taches[index].sous_taches[i]}');
                      }),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        child: const Text('Je m\'en occupe 😌'),
                        onPressed: () {
                          _designService.dialogYesorNo(context,'/listetaches');
                        },
                      ),],),),);},);},

              leading: Image.asset(taches[index].img),
              title: Text(
                taches[index].descr, style: const TextStyle(color: Colors.black,),),
            ),
          );
        });
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
