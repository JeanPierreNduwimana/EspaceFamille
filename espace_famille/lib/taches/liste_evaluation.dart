import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../services/design_service.dart';

DesignService _designService = DesignService();
bool test = false;
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
      appBar: _designService.appBar(context,'Evaluations de Jean Pierre', false),
      body: buildBody(),
      bottomNavigationBar: _designService.navigationBar(context, 2, setState),
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
    Future<void> _onRefresh() async {
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: Colors.cyan,
      child: ListView.builder(
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {

            if(index == 0){ //au premier index on affiche les info du profil
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
                    _designService.getRatingStars(value, true),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }
            return Container( // Contient les element de chaque listtile
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

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/cat_profile_img.jpg',
                          semanticLabel: 'Image du profil',
                          fit: BoxFit.cover,),
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox(),),
                    Expanded(
                      flex: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nom de la personne', style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 2,),
                        _designService.getRatingStars(3, false),
                        const Column(
                          children: [
                            SizedBox(height: 10,),
                            Text('ce que je pense de ca ce que je pense de ca ce que je pense de ca ce que je pense de ca ce que je pense de ca ce que je pense de ca' ,
                              textAlign: TextAlign.left, style: TextStyle(color: Colors.black,),),
                          ],
                        ),
                      ],
                                ),
                    )]
                ),
              ),
            );
          }),
    );
  }
}
