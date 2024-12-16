import 'package:flutter/material.dart';

import '../services/design_service.dart';
import 'model_tache.dart';

DesignService _designService = DesignService();

class DetailsTache extends StatefulWidget {
  final Tache tache;
  const DetailsTache({super.key,required this.tache});

  @override
  State<DetailsTache> createState() => _DetailsTacheState();
}

class _DetailsTacheState extends State<DetailsTache> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar('Informations sur la tâche'),
      body: Container(
        padding: const EdgeInsets.all(8),
        height: 800,
        decoration: const BoxDecoration(
          color: Colors.white, // Your desired background color
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0), // Same radius as the shape
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 24,),
              const SizedBox(height: 24,),
              Image.asset(widget.tache.img),
              const SizedBox(height: 12,),
              Text(widget.tache.descr),
              Container( //Sous Taches
                margin: widget.tache.sous_taches.isNotEmpty? const EdgeInsets.only(top: 12, bottom: 12) : const EdgeInsets.only(bottom: 24),
                child: ListView.builder(shrinkWrap: true,itemCount: widget.tache.sous_taches.length, itemBuilder: (BuildContext context, int i){
                  return Text('\n• ${widget.tache.sous_taches[i]}');
                }),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(12),
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('À effectuer d\'ici'),
                        Text('En retard')
                      ],
                    ),
                    Row(
                      children: [
                        Text('5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32,),textAlign: TextAlign.end,),
                        Text('   Jours Restants',),
                        Expanded(child: Text('Jusqu\'au 25--302-24', textAlign: TextAlign.end,))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        children: [
                          Expanded(child: ElevatedButton(onPressed: (){}, child: const Text('Abandonner 🥵'))),
                          const SizedBox(width: 12,),
                          Expanded(child: ElevatedButton(onPressed: (){}, child: const Text('Échanger 🔁'))),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(width: 150, child: ElevatedButton(onPressed: ()=> Navigator.pop(context), child: const Text('Ok 👍'),))
                  ],
                ),
              )

            ],),),),
    );
  }
}
