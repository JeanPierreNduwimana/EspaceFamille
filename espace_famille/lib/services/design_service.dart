import 'package:espace_famille/espace_famille/model_commentaire.dart';
import 'package:espace_famille/taches/details_tache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../taches/model_tache.dart';

class DesignService {

  DesignService();

  final TextEditingController comment_controller = TextEditingController();
  final TextEditingController controllercommentRepondre = TextEditingController();
  final TextEditingController controllerContenuAnnonce = TextEditingController();

/*
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
*/
  AppBar appBar(String title){
    return AppBar(
      backgroundColor: Colors.cyan,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  void dialogYesorNo(BuildContext context, String modalRouteName){
    showDialog(
        context: context,
        builder: (context){
          return Dialog(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              ),
            child: Container(
              color: Colors.white,
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Êtes vous sûr?', style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(onPressed: ()=> Navigator.popUntil(context, ModalRoute.withName(modalRouteName)), child: Text('Oui')),
                        ElevatedButton(onPressed: ()=> Navigator.pop(context), child: Text('Non')),
                      ],
                    ),
                  ],
                ),
              ),
            ));
    });
  }
  void dialogAfficherImage(BuildContext context, String image){
    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          
          child: Image.asset(image));
    });
  }
  void dialogEvaluerTacheDetailsProfile(bool visitor, BuildContext context, Tache t, double value){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
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
                      Container( //Sous Taches
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
                      (visitor? TextField(
                        controller: comment_controller,
                        keyboardType: TextInputType.text,
                        maxLength: 100,
                        maxLines: null,
                        minLines: 1,
                        decoration: const InputDecoration(
                            hintText: 'commentaire facultatif',
                            hintStyle: TextStyle(color: Colors.black38),
                            border: OutlineInputBorder(),
                        ),
                      ) : const SizedBox()),
                      (visitor?ElevatedButton(
                        child: value < 2.5? const Text('👎👎') : (value == 3? const Text('Meh 🥱') : (value == 4 ? const Text('Bravo 👏') : const Text('Bravo!! 😃'))),
                        onPressed: () => Navigator.pop(context),
                      ) :
                      Container(
                        margin: const EdgeInsets.only(left: 8,right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: (){
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DetailsTache(tache: t)));
                                      //Navigator.pop(context);
                                    },
                                    child: const Text('Consulter 🧐')),
                                ElevatedButton(onPressed: ()=> Navigator.pop(context), child: const Text('Compris! 👍'))
                              ],
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(onPressed: ()=> Navigator.pop(context), child: const Text('La tache est fait! 👌'),)
                          ],
                        ),
                      ))

                    ],),),),
            );},);},);
  }
  void dialogCreerAnnonce(BuildContext context){
    controllerContenuAnnonce.text = '';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:4, right: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: ((){
                                Navigator.pop(context);
                              }),
                              child: const Text('Annuler', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                            ElevatedButton(onPressed: (){}, child: Icon(Icons.send))
                          ],
                        ),
                      ),
                      TextField(
                        controller: controllerContenuAnnonce,
                        maxLines: null,  // Makes the TextField multiline
                        keyboardType: TextInputType.multiline,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Quoi de neuf ?',
                          //border: OutlineInputBorder(),
                        ),
                      )
                    ],
                  ),
                )),
            );},);},);
  }
  void dialogRepondreCommentaire(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permet de s'ajuster au clavier
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, // Ajustement pour le clavier
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ajuste la hauteur au contenu
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/cat_profile_img.jpg',
                                        semanticLabel: 'Image du profil',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Nom de la personne',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    '2024-04-03',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: const Text(
                                  'bl bablabl abla blabla b lab blablal abb al blablabl babalbl',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controllercommentRepondre,
                            maxLines: null,  // Makes the TextField multiline
                            keyboardType: TextInputType.multiline,
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: 'Votre réponse...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Action lorsque le bouton "Rep" est pressé
                            Navigator.pop(context);
                          },
                          child: const Text('Rep'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  RatingStars getRatingStars(double value, bool afficheValeur){
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
      valueLabelVisibility: afficheValeur,
      animationDuration: const Duration(milliseconds: 1000),
      valueLabelPadding:
      const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      valueLabelMargin: const EdgeInsets.only(right: 8),
      starOffColor: const Color(0xffe7e8ea),
      starColor: Colors.yellow,
    );
  }
  //verification booléen de longueur maximale des description des tache
  String maximumString(String descrTache, int max){
    if(descrTache.length > max){
      String stringAEnvoyer = '';
      int index = 0;
      while(index < max){
        stringAEnvoyer += descrTache[index];
        index++;
      }
      return ('$stringAEnvoyer...');

    }else{
      return descrTache;
    }
  }
}

