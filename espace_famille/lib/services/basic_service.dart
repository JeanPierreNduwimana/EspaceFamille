import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../taches/model_tache.dart';

class BasicService {

  BasicService(){}

  PreferredSize appBar(String title){
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0), // Hauteur de l'AppBar
      child: AppBar(
        backgroundColor: Colors.cyan,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void ratingStarDialog(bool visitor, BuildContext context, Tache t, double value){

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
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
                    visitor? const Text('Evaluer JeanPierre pour cette tache', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),) :
                    const Text('Informations sur ma tâche', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    const SizedBox(height: 24,),
                    Image.asset(t.img),
                    const SizedBox(height: 12,),
                    Text(t.descr),
                    Container(
                      margin: t.sous_taches.isNotEmpty? const EdgeInsets.only(top: 12, bottom: 12) : const EdgeInsets.only(bottom: 24),
                      child: ListView.builder(shrinkWrap: true,itemCount: t.sous_taches.length, itemBuilder: (BuildContext context, int i){
                        return Text('\n• ${t.sous_taches[i]}');
                      }),
                    ),
                    (visitor?RatingStars(
                      value: value,
                      onValueChanged: (v) {
                        //
                        setState(() {
                          value = v;
                        });
                      },
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
                    ) : const SizedBox()),
                    (!visitor?Container(
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
                    ) : const SizedBox()),
                    const SizedBox(height: 8),
                    (visitor?ElevatedButton(
                      child: value < 2.5? const Text('👎👎') : (value == 3? const Text('Meh 🥱') : (value == 4 ? const Text('Bravo 👏') : const Text('Bravo!! 😃'))),
                      onPressed: () => Navigator.pop(context),
                    ) :
                    Container(
                      margin: const EdgeInsets.only(left: 8,right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(onPressed: ()=> Navigator.pop(context), child: const Text('Consulter 🧐')),
                          ElevatedButton(onPressed: ()=> Navigator.pop(context), child: const Text('Compris! 👍'))
                        ],
                      ),
                    ))

                  ],),),);},);},);
  }

  RatingStars getRatingStars(double value){
    return RatingStars(
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
    );
  }
}