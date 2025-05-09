import 'package:espace_famille/espace_famille/model_annonce.dart';
import 'package:espace_famille/tools/form_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../generated/l10n.dart';
import '../app_services/widget_service.dart';

WidgetService _designService = WidgetService();
String testmessage = 'String message = Voulez-vous vraiment modifier cette annonce ?; String message = Voulez-vous vraiment modifier cette annonce ?;String message = Voulez-vous vraiment modifier cette annonce ?;Stri';

bool isloading = false;


class CommentairesAnnonce extends StatefulWidget {
  final Annonce annonce;
  const CommentairesAnnonce({super.key, required this.annonce});

  @override
  State<CommentairesAnnonce> createState() => _CommentairesAnnonceState();
}

class _CommentairesAnnonceState extends State<CommentairesAnnonce> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp // Optional
    ]);
    loadPage();
  }

  void loadPage()async{
    await fetchData();
  }

  Future<void> fetchData() async {
    setState(() { isloading = true;});
    await Future.delayed(const Duration(seconds: 1));
    setState(() {isloading = false;});
  }
  Future<void> _onRefresh() async {
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar(context,'Commentaires', false,Colors.cyan),
      body: isloading ? _designService.shimmerCommentairesAnnonce(context) : buildBody(),
      bottomNavigationBar: _designService.navigationBar(context, 2, setState),
    );
  }

  Widget buildBody(){
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: Colors.cyan,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: isDarkMode ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? Colors.black87 : Colors.grey.withOpacity(0.1), // Couleur de l'ombre avec opacité
                    spreadRadius: 2, // Rayonnement de l'ombre
                    blurRadius: 3, // Rayon du flou de l'ombre
                    offset: const Offset(2, 2), // Décalage horizontal et vertical de l'ombre
                  ),
                ],
                border: !isDarkMode ? Border.all(color: Colors.grey.shade300, width: 1) : null
            ),

            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          child:SizedBox(
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
                        const Text('Jean Pierre', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: ()async{
                              String message = S.of(context).messageEditPost;
                              bool? result = await _designService.dialogYesorNo(context, message );

                              if(result !=null){
                                // Image? currentImage;

                                // annonces[index].url == '' ? currentImage = null : currentImage = Image.asset(annonces[index].url);
                                // result ? _designService.dialogCreerAnnonce(context, annonces[index].description, currentImage) : null;
                              }
                            },
                            child: const Icon(Icons.edit, color: Colors.orangeAccent,)
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                            onTap: ()async{
                              String message = 'Voulez-vous vraiment \n supprimer cette annonce ?';
                              bool? result = await _designService.dialogYesorNo(context, message);
                              if(result !=null){
                                result ? null : null;
                              }
                              //_designService.dialogYesorNo(context, modalRouteName);
                            },
                            child: const Icon(Icons.delete_outlined, color: Colors.redAccent,)
                        )
                      ],
                    )
                  ],
              ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Text(testmessage,)),
                    const SizedBox(width: 8,),
                    GestureDetector(
                      onTap: (){
                        _designService.dialogAfficherImage(context, 'assets/images/bird.png');
                      },
                      child: SizedBox(
                          height: 60,
                          width: 60,
                          child:  Image.asset('assets/images/bird.png')
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
                        Icon(Icons.favorite, color: Colors.deepOrange[400], size: 20),
                        const SizedBox(width: 2),
                        Text('2', style: TextStyle(color: Colors.deepOrange[400],fontSize: 16)),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: (){
                            FormController.controllercommentRepondre.text = '';
                            _designService.dialogRepondreCommentaire(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.comment, color: Colors.cyan[600], size: 20),
                              const SizedBox(width: 2),
                              Text('3', style: TextStyle(color: Colors.cyan[600],fontSize: 16)),
                            ],
                          ),
                        ),

                        const Expanded(child: Align(alignment: Alignment.centerRight, child: Text('2023-03-04', style: TextStyle(fontStyle: FontStyle.italic),)))
                      ],
                    ),
                  ],
                )
              ]
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black87 : Colors.grey.withOpacity(0.1), // Couleur de l'ombre avec opacité
                      spreadRadius: 2, // Rayonnement de l'ombre
                      blurRadius: 3, // Rayon du flou de l'ombre
                      offset: const Offset(2, 2), // Décalage horizontal et vertical de l'ombre
                    ),
                  ],
                  border: !isDarkMode ? Border.all(color: Colors.grey.shade300, width: 1) : null
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text( '${widget.annonce.commentaires.length} Commentaires', textAlign: TextAlign.right, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      MediaQuery.of(context).viewInsets.bottom > 0 ? const SizedBox(): Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                        height: 20 //s'ajuste quand le clavier s'affiche
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(shrinkWrap: true, itemCount: widget.annonce.commentaires.length, itemBuilder: (BuildContext context, int ii)
                    {
                      return Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 40, width: 40,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/cat_profile_img.jpg',
                                    semanticLabel: 'Image du profil',
                                    fit: BoxFit.cover,),
                                ),
                              ),
                              const SizedBox(width: 12,),
                              const Text('Nom de la personne', style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 12,),
                              const Text('2024-04-03')
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
                                  Icon(Icons.favorite, color: Colors.deepOrange[400], size: 20),
                                  const SizedBox(width: 2),
                                  Text('2', style: TextStyle(color: Colors.deepOrange[400],fontSize: 16)),
                                ],),
                              GestureDetector(
                                onTap: () {
                                  afficheSousCommentaire(ii);
                                },
                                child: widget.annonce.commentaires[ii].afficheSousCommentaire ? const Text('Cacher les commentaires') : const Text('Afficher les commentaires'),
                              ),
                              Row(
                                children: [
                                  //Icon(Icons.add_card_rounded, color: Colors.cyan[600],),
                                  GestureDetector(
                                    onTap: (){
                                      FormController.controllercommentRepondre.text = '';
                                      _designService.dialogRepondreCommentaire(context);
                                    },
                                    child: const Text('Répondre'),)

                                ],),
                            ],
                          ),
                          const SizedBox(height: 12,),
                          ListView.builder(shrinkWrap: true,physics: const NeverScrollableScrollPhysics(), itemCount: widget.annonce.commentaires[ii].commentaires.length, itemBuilder: (BuildContext context, int i){
                            return widget.annonce.commentaires[ii].afficheSousCommentaire ?
                            Row(
                              children: [
                                const SizedBox(width: 40,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 30, width: 30,
                                            child: ClipOval(
                                              child: Image.asset(
                                                'assets/images/cat_profile_img.jpg',
                                                semanticLabel: 'Image du profil',
                                                fit: BoxFit.cover,),
                                            ),
                                          ),
                                          const SizedBox(width: 12,),
                                          const Text('Nom de la personne', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                          const SizedBox(width: 12,),
                                          const Text('2024-04-03', style: TextStyle(fontSize: 14))
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
                                              Icon(Icons.favorite, color: Colors.deepOrange[400], size: 20),
                                              const SizedBox(width: 2),
                                              Text('2', style: TextStyle(color: Colors.deepOrange[400],fontSize: 16)),
                                            ],
                                          ),
                                          //SizedBox(width: 8),
                                          Row(
                                            children: [
                                              //Icon(Icons.add_card_rounded, color: Colors.cyan[600],),
                                              GestureDetector(
                                                onTap: (){
                                                  FormController.controllercommentRepondre.text = '';
                                                  _designService.dialogRepondreCommentaire(context);
                                                },
                                                child: const Text('Répondre'),)

                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12,),
                                    ],
                                  ),
                                ),
                              ],
                            )
                                : const SizedBox();
                          }
                          ),


                        ],
                      );
                    }


                    ),
                  ),
                ],
              ),),
          )

        ],
      ),
    );
  }

  void afficheSousCommentaire(int index){
    setState(() {
      widget.annonce.commentaires[index].afficheSousCommentaire = !widget.annonce.commentaires[index].afficheSousCommentaire;
    });
  }
}
