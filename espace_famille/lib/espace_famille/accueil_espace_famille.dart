import 'package:espace_famille/espace_famille/commentaires_annonce.dart';
import 'package:espace_famille/espace_famille/model_commentaire.dart';
import 'package:espace_famille/nav_menu.dart';
import 'package:espace_famille/services/design_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model_annonce.dart';

const String image = 'assets/images/naruto.jpg';
DesignService _designService = DesignService();

class AccueilEspaceFammille extends StatefulWidget {
  const AccueilEspaceFammille({super.key});

  @override
  State<AccueilEspaceFammille> createState() => _AccueilEspaceFammilleState();
}
String testmessage = 'String message = Voulez-vous vraiment modifier cette annonce ?; String message = Voulez-vous vraiment modifier cette annonce ?;String message = Voulez-vous vraiment modifier cette annonce ?;Stri';

class _AccueilEspaceFammilleState extends State<AccueilEspaceFammille> {


  final List<Annonce> annonces = [
    Annonce(1,'jeanPierre',testmessage,'10 mins',6,2, image),
    Annonce(2,'Mario', 'Ne prennez pas mon sandwich que j\'ai laissé au frigo', '2024-10-11',4,0, ''),
    Annonce(3,'Henry','Qui veut regarder les magas avec moi ce soir????', '2 jours',9,8, ''),
    Annonce(4,'jeanpierre', 'Quel belle journée aujourd\'hui', '30 mins',4,3, image),
    Annonce(5,'Mario', 'Ne prennez pas mon sandwich que j\'ai laissé au frigo', '1 heure',2,1, ''),
    Annonce(6,'Henry','Qui veut regarder les magas avec moi ce soir????', '10 heure',10,12, image),
    Annonce(7,'jeanpierre', 'Quel belle journée aujourd\'hui', '10 mins',8,1,''),
    Annonce(8,'Mario', 'Ne prennez pas mon sandwich que j\'ai laissé au frigo', '45 mins',4,2,''),
    Annonce(9,'Henry','Qui veut regarder les magas avec moi ce soir????', '7 mins',3,0,image)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp // Optional
    ]);

    annonces.forEach((a) {
      if(a.Comments > 0){
        //Jajoute les commentaires
        for(int i = 0; i < a.Comments; i++){
          a.commentaires.add(Commentaire(i, a.id, 'fan name',
              'blabla blab alabla hdhtr trthh htythtnytyhtn y h yyh yyht hnyn tnnbl',
              a.date, a.Favs, a.Comments));
        }
        //Je parcours les commentaires ajoutés pour y ajouter des sous commentaires
        a.commentaires.forEach((c) {
          for(int ii = 0; ii < c.nbCommentaire; ii++){
            c.commentaires.add(Commentaire(ii, a.id, 'fan name',
                'blabla blab alabla hdhtr trthh htythtnytyhtn y h yyh yyht hnyn tnnbl',
                a.date, a.Favs, a.Comments));
          }

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _designService.appBar(context,'Espace Famille', false),
      body: buildBody(),
      //drawer: const NavMenu(),
      bottomNavigationBar: _designService.navigationBar(context, 2, setState),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan.shade400,
        foregroundColor: Colors.white,
        onPressed: (){
          //Navigator.pushNamed(context, '/pageprofile');
          _designService.dialogCreerAnnonce(context,'', null);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody(){
    Future<void> _onRefresh() async {
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: Colors.cyan,
      child: ListView.builder(
          itemBuilder: (BuildContext context, int index){
            if(index < annonces.length){
              return GestureDetector(
                onTap: () => {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => CommentairesAnnonce(annonce: annonces[index])))
                },
                child: Column(
                  children: [
                    const SizedBox(height: 12,),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      padding: const EdgeInsets.only(top:16, bottom: 10, right: 16,left: 16),
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1), // Couleur de l'ombre avec opacité
                              spreadRadius: 2, // Rayonnement de l'ombre
                              blurRadius: 3, // Rayon du flou de l'ombre
                              offset: Offset(2, 2), // Décalage horizontal et vertical de l'ombre
                            ),
                          ],
                         border: Border.all(color: Colors.grey.shade300, width: 1)),
                      child: Column(
                        children : [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    child:Container(
                                      height: 40,
                                      width: 40,
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/cat_profile_img.jpg',
                                          semanticLabel: 'Image du profil',
                                          fit: BoxFit.cover,),
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.pushNamed(context, '/pageprofile');
                                    },
                                  ),
                                  const SizedBox(width: 12,),
                                  Text(annonces[index].username, style: const TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: ()async{
                                        String message = 'Voulez-vous vraiment \n modifier cette annonce ?';
                                        bool? result = await _designService.dialogYesorNo(context, message );

                                        if(result !=null){
                                          Image? currentImage;

                                          annonces[index].url == '' ? currentImage = null : currentImage = Image.asset(annonces[index].url);
                                          result ? _designService.dialogCreerAnnonce(context, annonces[index].description, currentImage) : null;
                                        }
                                      },
                                      child: Icon(Icons.edit, color: Colors.orangeAccent,)
                                  ),
                                  SizedBox(width: 12),
                                  GestureDetector(
                                      onTap: ()async{
                                        String message = 'Voulez-vous vraiment \n supprimer cette annonce ?';
                                        bool? result = await _designService.dialogYesorNo(context, message);
                                        if(result !=null){
                                          result ? null : null;
                                        }
                                        //_designService.dialogYesorNo(context, modalRouteName);
                                      },
                                      child: Icon(Icons.delete_outlined, color: Colors.redAccent,)
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text(annonces[index].description)),
                              SizedBox(height: 4,),
                              GestureDetector(
                                onTap: (){
                                  _designService.dialogAfficherImage(context, annonces[index].url);
                                },
                                child: Container(
                                    height: 60,
                                    width: 60,
                                    child:  getImage(annonces[index].url)
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Divider(
                                thickness: 1,
                                color: Colors.cyan[200],
                                height: 20,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: ((){
                                      setState(() {
                                        annonces[index].liked = !annonces[index].liked;
                                      });
                                    }),
                                    child: annonces[index].liked ? Icon(Icons.favorite, color: Colors.deepOrange[400],) : Icon(Icons.favorite_border, color: Colors.deepOrange[400],),
                                  ),
                                  Text(annonces[index].Favs.toString(), style: TextStyle(color: Colors.deepOrange[400]),),
                                  SizedBox(width: 8),
                                  Icon(Icons.comment, color: Colors.cyan[600],),
                                  Text(annonces[index].Comments.toString(), style: TextStyle(color: Colors.cyan[600]),),
                                  Expanded(child: Align(alignment: Alignment.centerRight, child: Text(annonces[index].date.toString(), style: const TextStyle(fontStyle: FontStyle.italic),)))
                                ],
                              ),
                            ],
                          )
                        ]
                      ),
                    )
                  ],
                ),
              );
            }

          }),
    );

  }

  getImage(String url){
    if(url != ''){
      return Image.asset(url, fit: BoxFit.cover,);
    }
    return null;
  }
}

