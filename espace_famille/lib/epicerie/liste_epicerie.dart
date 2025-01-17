import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

import '../generated/l10n.dart';
import '../nav_menu.dart';
import '../services/widget_service.dart';
import 'model_aliment.dart';

class ListeEpicerie extends StatefulWidget {
  const ListeEpicerie({super.key});

  @override
  State<ListeEpicerie> createState() => _ListeEpicerieState();
}
WidgetService _designService = WidgetService();

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
bool isloading = true;
class _ListeEpicerieState extends State<ListeEpicerie> {

  void loadPage()async{
    await fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isloading = true;
    });

    await Future.delayed(const Duration(seconds: 1)); // Simule un délai de chargement

    setState(() {
      isloading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp // Optional
    ]);
    loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                S.of(context).appBarGroceriePageTitle,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    if(!isloading){
                      _designService.dialogAjoutAliment(context);
                    }
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isloading ? Colors.grey : Colors.red.withOpacity(0.8),
                        border: Border.all(color: Colors.grey.shade50, width: 1),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2), // Couleur de l'ombre avec opacité
                            spreadRadius: 2, // Rayonnement de l'ombre
                            blurRadius: 3, // Rayon du flou de l'ombre
                            offset: Offset(3, 3), // Décalage horizontal et vertical de l'ombre
                          ),
                        ],
                      ),

                      child: const Icon(Icons.add, color: Colors.white, size: 18,)),
                ),
                const SizedBox(width: 18),
                PopupMenuButton<String>(
                    surfaceTintColor: Colors.white,
                    onSelected: (value) {
                      // Action à exécuter selon l'option sélectionnée
                      if (!isloading) {
                        if (value == 'Date') {
                        } else if (value == 'Achat') {
                        }
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem(enabled: false, child: Text(S.of(context).labelSortBy, style: const TextStyle(color: Colors.redAccent),)),
                      //const PopupMenuDivider(),
                      const PopupMenuItem<String>(
                        value: 'Date',
                        child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      PopupMenuItem<String>(
                        value: 'Achat',
                        child: Text(S.of(context).labelAchat, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                    icon: Row(
                      children: [
                        Text(S.of(context).labelSort, style: TextStyle(fontSize: 14, color: isloading ? Colors.grey : Colors.redAccent, fontWeight: FontWeight.bold),),
                        Icon(Icons.sort, color: isloading ? Colors.grey : Colors.redAccent),
                      ],
                    ) // Icône à trois points
                ),
                const SizedBox(width: 32),
                GestureDetector(
                  onTap: (){
                    if (!isloading) {
                      Navigator.pushNamed(context, '/app_options');
                    }
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/cat_profile_img.jpg',
                        semanticLabel: 'Image du profil',
                        fit: BoxFit.cover,),
                    ),
                  ),
                )
              ],
            )

          ],
        ),
      ),
      body: isloading ? _designService.shimmerEpiceire() : buildBody(),
      bottomNavigationBar: _designService.navigationBar(context, 1, setState),
    );
  }

  Widget buildBody(){
    Future<void> _onRefresh() async {
      await fetchData();
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: Colors.redAccent,
      child: ListView.builder(
        itemCount: aliments.length,
        itemBuilder: (context, index) {
          return index == 0 ?
           Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(height: 32),
                const Icon(Icons.dinner_dining, color: Colors.redAccent, size: 54,),
                const SizedBox(height: 32),
                Text(S.of(context).groceriePageTitle, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(S.of(context).groceriePageSubTitle,textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 24),
              ],
            ),
          )
          :
          Dismissible(
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 3),
                    content: Text(
                          aliments[index].validerAchat ? 'Cet aliment a été acheté : ${aliments[index].nom}'
                              : 'L\'achat de cet aliment est annulé : ${aliments[index].nom}' ))
                );
                return false;

              } else if (direction == DismissDirection.endToStart) {
                // Action quand l'utilisateur glisse vers la gauche
                bool? result = await _designService.dialogYesorNo(context, 'Supprimer cette aliment');
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
            child: GestureDetector(
              onTap: (){
                _designService.dialogDetailAliment(context);
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
                                   Text(S.of(context).labelMinutesPassed(2)),
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
                              Text(
                                S.of(context).labelQuantityShorted,
                                style: const TextStyle(fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
