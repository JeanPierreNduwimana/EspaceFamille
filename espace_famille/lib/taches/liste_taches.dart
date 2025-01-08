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
        backgroundColor: Colors.cyan.shade400,
        foregroundColor: Colors.white,
        onPressed: (){
          _designService.dialogCreerTache(context);
        },
        tooltip: 'Ajouter une tâche',
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                taches[index].img,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Description
                            Text(
                              taches[index].descr,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),

                            // List of tasks
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: taches[index].sous_taches.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.check_circle_outline, color: Colors.cyan),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          taches[index].sous_taches[i],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 24),

                            // Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 2,
                                backgroundColor: Colors.cyan,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Je m\'en occupe 😌',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                String message = 'Voulez-vous vraiment \n assumer cette tâche ?';
                                bool? result = await _designService.dialogYesorNo(context, message);

                                if (result != null) {
                                  result ? Navigator.pushNamed(context, '/listetaches') : null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },

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
