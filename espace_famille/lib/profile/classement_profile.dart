import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/design_service.dart';
import 'model_profile.dart';

class ClassementProfiles extends StatefulWidget {
  const ClassementProfiles({super.key});

  @override
  State<ClassementProfiles> createState() => _ClassementProfilesState();
}
DesignService _designService = DesignService();

List<Profile> profiles = [
  Profile("Bruno", '28-04-2003', 4),
  Profile("Jean Pierre", '16-03-1999', 2),
  Profile("Mario", '24-07-2011', 4),
  Profile("Bruno", '28-04-2003', 4),
  Profile("Bruno", '28-04-2003', 4),
  Profile("Bruno", '28-04-2003', 4),
  Profile("Bruno", '28-04-2003', 4),
  Profile("Bruno", '28-04-2003', 4),
];

class _ClassementProfilesState extends State<ClassementProfiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar('Classement des meilleurs membres'),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: (){
          Navigator.pushNamed(context, '/accfam');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget buildBody(){
  return ListView.builder(
      itemCount: profiles.length,
      itemBuilder: (BuildContext context, int index) {

        if(index == 0){ // À l'index 0, on affiche le podium
          return Container(
            margin: const EdgeInsets.only(bottom: 24, left: 8, top: 8, right: 8),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(flex:1,
                    child: Container(
                      height: 240,
                      child: Column(
                        children: [
                          Expanded(child: Container(),),
                          Container(

                            margin: const EdgeInsets.only(bottom: 8),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/cat_profile_img.jpg',
                                semanticLabel: 'Image du profil',
                                fit: BoxFit.cover, height: 48, width: 48,),
                            ),
                          ),
                          Expanded(child: Container(decoration: const BoxDecoration(color: Colors.grey)))
                        ],
                      ),
                    )
                ),
                Expanded(flex:1,
                    child: Container(
                      height: 240,
                      child: Column(
                        children: [
                          Expanded(flex: 1,child: Container(),),
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),

                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/cat_profile_img.jpg',
                                semanticLabel: 'Image du profil',
                                fit: BoxFit.cover,height: 60, width: 60, ),
                            ),
                          ),
                          Expanded(flex: 20,child: Container(decoration: const BoxDecoration(color: Colors.yellow)))
                        ],
                      ),
                    )
                ),
                Expanded(flex:1,
                    child: Container(
                      height: 240,
                      child: Column(
                        children: [
                          Expanded(flex: 2, child: Container(),),
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            //height: 20, width: 20,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/cat_profile_img.jpg',
                                semanticLabel: 'Image du profil',
                                fit: BoxFit.cover, height: 36, width: 36, ),
                            ),
                          ),
                          Expanded(flex:1,child: Container(decoration: const BoxDecoration(color: Colors.brown)))
                        ],
                      ),
                    )
                ),
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
          child: Row(
            children: [
              Expanded(flex: 1, child: Text('$index', textAlign: TextAlign.center , style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),),
              const Expanded(flex: 2,child: Text("🥇",textAlign: TextAlign.center ,style: TextStyle(fontSize: 20))),
              ClipOval(
                child: Image.asset(
                  'assets/images/cat_profile_img.jpg',
                  semanticLabel: 'Image du profil',
                  fit: BoxFit.cover, height: 48, width: 48,),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Text(profiles[index].nom,style: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),),
                    Text(profiles[index].date),
                    _designService.getRatingStars(profiles[index].nbEtoiles, false)
                  ],
                ),
              )
            ],
          )
        );
      });
}
