import 'package:espace_famille/espace_famille/model_annonce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../nav_menu.dart';
import '../services/design_service.dart';

DesignService _designService = DesignService();



class CommentairesAnnonce extends StatefulWidget {
  Annonce annonce;
  CommentairesAnnonce({super.key, required this.annonce});

  @override
  State<CommentairesAnnonce> createState() => _CommentairesAnnonceState();
}

class _CommentairesAnnonceState extends State<CommentairesAnnonce> {

  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar('Commentaires'),
      body: buildBody(),
      drawer: NavMenu(),
    );
  }

  Widget buildBody(){
    return Column(
      children: [
        Expanded(
          flex: MediaQuery.of(context).viewInsets.bottom > 0 ?2 : 1,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            //padding: const EdgeInsets.all(16),
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

            child: ListTile(
                title: Row(
                  children: [
                    Expanded(child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text('Jean Pierre', style: const TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('description nlanlanlblablablabla'),
                        SizedBox(height: 4,)
                      ],
                    ) ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PopupMenuButton<String>(
                            icon: const Icon(Icons.more_horiz),
                            onSelected: (String value){
                              print('Selected: $value');
                            },
                            itemBuilder: (BuildContext context){
                              return const [
                                PopupMenuItem<String>(
                                  value: 'Modifier',
                                  child: Row(
                                    children: [
                                      Text('Modifier', style: TextStyle(fontSize: 16),),
                                      SizedBox(width: 4,),
                                      Icon(Icons.edit, size: 16,)
                                    ],
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Supprimer',
                                  child: Row(
                                    children: [
                                      Text('Supprimer', style: TextStyle(fontSize: 16),),
                                      SizedBox(width: 4,),
                                      Icon(Icons.delete, size: 16,)
                                    ],
                                  ),
                                )
                              ];
                            }),
                        SizedBox(height: 4,),
                        Container(
                            height: 60,
                            width: 60,
                            child:  Image.asset('assets/images/bird.png')
                        ),
                      ],
                    )
                  ],
                ),
                subtitle: Column(
                  children: [
                    Divider(
                      thickness: 1,
                      color: Colors.cyan[200],
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.deepOrange[400],),
                        Text('2', style: TextStyle(color: Colors.deepOrange[400]),),
                        SizedBox(width: 8),
                        Icon(Icons.comment, color: Colors.cyan[600],),
                        Text('3', style: TextStyle(color: Colors.cyan[600]),),
                        Expanded(child: Align(alignment: Alignment.centerRight, child: Text('2023-03-04', style: const TextStyle(fontStyle: FontStyle.italic),)))
                      ],
                    ),
                  ],
                )
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            padding: const EdgeInsets.all(16),
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
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text( '${widget.annonce.commentaires.length} Commentaires', textAlign: TextAlign.right, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      MediaQuery.of(context).viewInsets.bottom > 0 ? SizedBox(): Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                        height: 20 //s'ajuste quand le clavier s'affiche
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: ListView.builder(shrinkWrap: true,controller: _scrollController, itemCount: widget.annonce.commentaires.length, itemBuilder: (BuildContext context, int ii)
                  {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40, width: 40,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/cat_profile_img.jpg',
                                  semanticLabel: 'Image du profil',
                                  fit: BoxFit.cover,),
                              ),
                            ),
                            const SizedBox(width: 12,),
                            Text('Nom de la personne', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 12,),
                            Text('2024-04-03')
                          ],
                        ),
                        const SizedBox(height: 12,),
                        Container(
                            margin: const EdgeInsets.only(left: 4),
                            child: const Text('bl bablabl abla blabla b lab blablal abb al blablabl babalbl',textAlign: TextAlign.left,)),
                        const SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.favorite, color: Colors.deepOrange[400],),
                                Text('2', style: TextStyle(color: Colors.deepOrange[400]),),
                              ],),
                            GestureDetector(
                              onTap: () {
                                afficheSousCommentaire(ii);
                              },
                              child: widget.annonce.commentaires[ii].afficheSousCommentaire ? Text('Cacher les commentaires') : Text('Afficher les commentaires'),
                            ),
                            Row(
                              children: [
                                //Icon(Icons.add_card_rounded, color: Colors.cyan[600],),
                                GestureDetector(
                                  onTap: (){
                                    _designService.controllercommentRepondre.text = '';
                                    _designService.dialogRepondreCommentaire(context);
                                  },
                                  child: Text('Répondre'),)

                              ],),
                          ],
                        ),
                        const SizedBox(height: 12,),
                        Container(
                          child: ListView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(), itemCount: widget.annonce.commentaires[ii].commentaires.length, itemBuilder: (BuildContext context, int i){
                            return widget.annonce.commentaires[ii].afficheSousCommentaire ?
                            Row(
                              children: [
                                SizedBox(width: 40,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 30, width: 30,
                                            child: ClipOval(
                                              child: Image.asset(
                                                'assets/images/cat_profile_img.jpg',
                                                semanticLabel: 'Image du profil',
                                                fit: BoxFit.cover,),
                                            ),
                                          ),
                                          const SizedBox(width: 12,),
                                          Text('Nom de la personne', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                          const SizedBox(width: 12,),
                                          Text('2024-04-03', style: TextStyle(fontSize: 14))
                                        ],
                                      ),
                                      const SizedBox(height: 12,),
                                      Container(
                                          margin: const EdgeInsets.only(left: 4),
                                          child: const Text('bl bablabl abla blabla b lab blablal abb al blablabl babalbl',textAlign: TextAlign.left,)),
                                      const SizedBox(height: 12,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.favorite, color: Colors.deepOrange[400],),
                                              Text('2', style: TextStyle(color: Colors.deepOrange[400]),),
                                            ],
                                          ),
                                          //SizedBox(width: 8),
                                          Row(
                                            children: [
                                              //Icon(Icons.add_card_rounded, color: Colors.cyan[600],),
                                              GestureDetector(
                                                onTap: (){
                                                  _designService.controllercommentRepondre.text = '';
                                                  _designService.dialogRepondreCommentaire(context);
                                                },
                                                child: Text('Répondre'),)

                                            ],
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            )
                                : SizedBox();
                          }
                          ),),


                      ],
                    );
                  }


                  ),
                ),
              ],
            ),),
        )

      ],
    );
  }

  void afficheSousCommentaire(int index){
    setState(() {
      widget.annonce.commentaires[index].afficheSousCommentaire = !widget.annonce.commentaires[index].afficheSousCommentaire;
    });



  }
}
