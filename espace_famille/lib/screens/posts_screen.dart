import 'package:espace_famille/models/transfer_models.dart';
import 'package:espace_famille/screens/post_comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/widget_service.dart';
import '../generated/l10n.dart';
import '../utils/form_controllers.dart';

const String image = 'assets/images/naruto.jpg';
WidgetService _designService = WidgetService();

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

String testmessage =
    'String message = Voulez-vous vraiment modifier cette annonce ?; String message = Voulez-vous vraiment modifier cette annonce ?;String message = Voulez-vous vraiment modifier cette annonce ?;Stri';
bool isloading = true;

class _PostsScreenState extends State<PostsScreen> {
  final List<Annonce> annonces = [
    Annonce(1, 'jeanPierre', testmessage, '10 mins', 6, 2, image),
    Annonce(2, 'Mario', 'Ne prennez pas mon sandwich que j\'ai laissé au frigo',
        '2024-10-11', 4, 0, ''),
    Annonce(3, 'Henry', 'Qui veut regarder les magas avec moi ce soir????',
        '2 jours', 9, 8, ''),
    Annonce(4, 'jeanpierre', 'Quel belle journée aujourd\'hui', '30 mins', 4, 3,
        image),
    Annonce(5, 'Mario', 'Ne prennez pas mon sandwich que j\'ai laissé au frigo',
        '1 heure', 2, 1, ''),
    Annonce(6, 'Henry', 'Qui veut regarder les magas avec moi ce soir????',
        '10 heure', 10, 12, image),
    Annonce(7, 'jeanpierre', 'Quel belle journée aujourd\'hui', '10 mins', 8, 1,
        ''),
    Annonce(8, 'Mario', 'Ne prennez pas mon sandwich que j\'ai laissé au frigo',
        '45 mins', 4, 2, ''),
    Annonce(9, 'Henry', 'Qui veut regarder les magas avec moi ce soir????',
        '7 mins', 3, 0, image)
  ];

  void loadPage() async {
    await fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isloading = true;
    });
    await Future.delayed(
        const Duration(seconds: 1)); // Simule un délai de chargement

    annonces.forEach((a) {
      if (a.Comments > 0) {
        //Jajoute les commentaires
        for (int i = 0; i < a.Comments; i++) {
          a.commentaires.add(Commentaire(
              i,
              a.id,
              'fan name',
              'blabla blab alabla hdhtr trthh htythtnytyhtn y h yyh yyht hnyn tnnbl',
              a.date,
              a.Favs,
              a.Comments));
        }
        //Je parcours les commentaires ajoutés pour y ajouter des sous commentaires
        a.commentaires.forEach((c) {
          for (int ii = 0; ii < c.nbCommentaire; ii++) {
            c.commentaires.add(Commentaire(
                ii,
                a.id,
                'fan name',
                'blabla blab alabla hdhtr trthh htythtnytyhtn y h yyh yyht hnyn tnnbl',
                a.date,
                a.Favs,
                a.Comments));
          }
        });
      }
    });

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp // Optional
    ]);
    loadPage();
  }

  Future<void> _onRefresh() async {
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar(
          context, S.of(context).appBarHomePageTitle, false, Colors.cyan),
      body: isloading
          ? _designService.shimmerEspaceFamille(context)
          : buildBody(),
      bottomNavigationBar: _designService.navigationBar(context, 2, setState),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isloading ? Colors.grey : Colors.cyan.shade400,
        foregroundColor: Colors.white,
        onPressed: () {
          if (!isloading) {
            _designService.dialogCreerAnnonce(context, '', null);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: Colors.cyan,
      child: ListView.builder(
          itemCount: annonces.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PostCommentsScreen(annonce: annonces[index])))
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 10, right: 16, left: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode
                              ? Colors.black87
                              : Colors.grey.withOpacity(
                                  0.1), // Couleur de l'ombre avec opacité
                          spreadRadius: 2, // Rayonnement de l'ombre
                          blurRadius: 3, // Rayon du flou de l'ombre
                          offset: const Offset(2,
                              2), // Décalage horizontal et vertical de l'ombre
                        ),
                      ],
                      // border: Border.all(color: Colors.grey.shade300, width: 1)
                    ),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/cat_profile_img.jpg',
                                      semanticLabel: 'Image du profil',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/pageprofile');
                                },
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(annonces[index].username,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    String message =
                                        S.of(context).messageEditPost;
                                    bool? result = await _designService
                                        .dialogYesorNo(context, message);

                                    if (result != null) {
                                      Image? currentImage;

                                      annonces[index].url == ''
                                          ? currentImage = null
                                          : currentImage =
                                              Image.asset(annonces[index].url);
                                      result
                                          ? _designService.dialogCreerAnnonce(
                                              context,
                                              annonces[index].description,
                                              currentImage)
                                          : null;
                                    }
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.orangeAccent,
                                  )),
                              const SizedBox(width: 12),
                              GestureDetector(
                                  onTap: () async {
                                    String message =
                                        S.of(context).messageDeletePost;
                                    bool? result = await _designService
                                        .dialogYesorNo(context, message);
                                    if (result != null) {
                                      result ? null : null;
                                    }
                                    //_designService.dialogYesorNo(context, modalRouteName);
                                  },
                                  child: const Icon(
                                    Icons.delete_outlined,
                                    color: Colors.redAccent,
                                  ))
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Text(annonces[index].description)),
                          const SizedBox(
                            height: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              _designService.dialogAfficherImage(
                                  context, annonces[index].url);
                            },
                            child: SizedBox(
                                height: 60,
                                width: 60,
                                child: getImage(annonces[index].url)),
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
                                onTap: (() {
                                  setState(() {
                                    annonces[index].liked =
                                        !annonces[index].liked;
                                  });
                                }),
                                child: annonces[index].liked
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.deepOrange[400],
                                        size: 20,
                                      )
                                    : Icon(Icons.favorite_border,
                                        color: Colors.deepOrange[400],
                                        size: 20),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                annonces[index].Favs.toString(),
                                style: TextStyle(
                                    color: Colors.deepOrange[400],
                                    fontSize: 16),
                              ),
                              const SizedBox(width: 24),
                              GestureDetector(
                                onTap: () {
                                  FormController
                                      .controllercommentRepondre.text = '';
                                  _designService
                                      .dialogRepondreCommentaire(context);
                                },
                                child: Row(children: [
                                  Icon(Icons.comment,
                                      color: Colors.cyan[600], size: 20),
                                  const SizedBox(width: 2),
                                  Text(
                                    annonces[index].Comments.toString(),
                                    style: TextStyle(
                                        color: Colors.cyan[600], fontSize: 16),
                                  ),
                                ]),
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  index == 3
                                      ? Expanded(
                                          flex: 2,
                                          child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                  color: isDarkMode
                                                      ? Colors.cyan.shade800
                                                      : Colors.cyan.shade400,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Text(
                                                S
                                                    .of(context)
                                                    .labeAutomaticMessage,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )))
                                      : const SizedBox(),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        annonces[index].date.toString(),
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic),
                                      )),
                                ],
                              ))
                            ],
                          ),
                        ],
                      )
                    ]),
                  )
                ],
              ),
            );
          }),
    );
  }

  getImage(String url) {
    if (url != '') {
      return Image.asset(
        url,
        fit: BoxFit.cover,
      );
    }
    return null;
  }
}
