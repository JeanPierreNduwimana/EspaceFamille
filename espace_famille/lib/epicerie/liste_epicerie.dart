import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../nav_menu.dart';
import '../services/design_service.dart';
import 'model_aliment.dart';

class ListeEpicerie extends StatefulWidget {
  const ListeEpicerie({super.key});

  @override
  State<ListeEpicerie> createState() => _ListeEpicerieState();
}
DesignService _designService = DesignService();

List<Aliment> aliments = [
  Aliment('banane', 7, false),
  Aliment('patate', 3, true),
  Aliment('orange', 5, true),
  Aliment('Pain', 2, false),
  Aliment('Ketchup', 1, false),
  Aliment('Mayonnaise', 2, true),
  Aliment('L\'eau', 3, false),
  Aliment('Pomme de terre', 1, false)
];

class _ListeEpicerieState extends State<ListeEpicerie> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp // Optional
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar('Gestion d\'epicerie'),
      body: buildBody(),
      drawer: const NavMenu(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.withOpacity(0.8),
        foregroundColor: Colors.white,
        onPressed: (){
          //dialog d'ajout d'un aliment
        },
        tooltip: 'Ajout d\'un aliment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody(){
    Future<void> _onRefresh() async {
    }

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemCount: aliments.length, // Example number of items
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(aliments[index].nom),
                  background: Container(
                    margin: const EdgeInsets.symmetric(vertical: 18),
                    color: Colors.greenAccent,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    margin: const EdgeInsets.symmetric(vertical: 18),
                    color: Colors.red.withOpacity(0.6),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      // Action quand l'utilisateur glisse vers la droite
                      setState(() {
                        aliments[index].validerAchat = !aliments[index].validerAchat;
                      });
                      return false;

                    } else if (direction == DismissDirection.endToStart) {
                      // Action quand l'utilisateur glisse vers la gauche
                      bool? result = await _designService.dialogYesorNo(context, '(In)Valider cette aliment');
                      if(result != null && result){
                          return true;
                      }
                    }
                    return null;
                  },
                  onDismissed: (direction) {
                    setState(() {
                      aliments.remove(aliments[index]);
                    });
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    color: aliments[index].validerAchat ? Colors.grey.withOpacity(0.1) : Colors.white,
                    elevation: aliments[index].validerAchat ? 0 :  1,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            height: 80, width: 80,
                            child: Image.asset('assets/images/naruto.jpg', fit: BoxFit.cover,),
                          ),
                           Expanded(
                             flex: 2,
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                   aliments[index].nom,
                                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                              ),
                                   const SizedBox(height: 8),
                                   Row(
                                     children: [
                                       SizedBox(
                                         height: 20,
                                         width: 20,
                                         child: ClipOval(
                                           child: Image.asset(
                                             'assets/images/cat_profile_img.jpg',
                                             semanticLabel: 'Image du profil',
                                             fit: BoxFit.cover,),
                                         ),
                                       ),
                                       const SizedBox(width: 8),
                                       const Text('il y a 2 mins'),
                                     ],
                                   ),
                                 ],
                               ),
                           ),
                           Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                //border: ,
                                color: aliments[index].validerAchat ? Colors.grey.withOpacity(0.3) : Colors.red.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    aliments[index].quantite.toString(),
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  const Text(
                                    "Qté",
                                    style: TextStyle(fontSize: 10, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          /*ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: aliments[index].validerAchat ? Colors.green : Colors.white,
                              foregroundColor: aliments[index].validerAchat ? Colors.white : Colors.green,
                            ),
                            child: Icon(Icons.check,),
                            onPressed: () {
                              setState(() {
                                aliments[index].validerAchat = !aliments[index].validerAchat;
                              });
                            },
                          ),*/
                          /*Container(
                            decoration: BoxDecoration(
                              color: aliments[index].validerAchat ? Colors.red.withOpacity(0.6) : null, // Background color
                              shape: BoxShape.circle, // Optional: To make it circular
                            ),
                            child: IconButton(
                              icon: Icon(Icons.check),
                              color: aliments[index].validerAchat ? Colors.white : Colors.red,
                              onPressed: () {
                                setState(() {
                                  aliments[index].validerAchat = !aliments[index].validerAchat;
                                });
                              },
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          height: 100, // This can be adjusted based on your design needs
          color: Colors.grey[200],
          child: const Center(child: Text("Additional content")),
        ),
      ],
    );
  }
}