import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/design_service.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}
DesignService _designService = DesignService();
final List<Map<String, String>> categories = [
  {"title": "Espace Famille", "image": "assets/images/naruto.jpg"},
  {"title": "Liste d'Épicerie", "image": "assets/images/naruto.jpg"},
  {"title": "Liste de Tâches", "image": "assets/images/naruto.jpg"},
  {"title": "Liste d'Événements", "image": "assets/images/naruto.jpg"},
  {"title": "Classement des Membres", "image": "assets/images/naruto.jpg"},
];

bool containposts = true;
bool postimageavailable = true;
bool valideAchat1 = false;
bool orgExist = false;

class _AccueilState extends State<Accueil> {

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
    Future<void> pageRefresh() async {
      setState(() {
      });
    }
    return Scaffold(
      appBar: _designService.appBar(context,'Espace Famille', false),
      body: RefreshIndicator(
        onRefresh: pageRefresh,
        color: Colors.cyan,
        child: buildBody()
      ),
      bottomNavigationBar: _designService.navigationBar(context, 0, setState),
      //drawer: const NavMenu(),
      backgroundColor: Colors.white,
    );
  }

  Widget buildBody(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 32,bottom: 4),
              padding: const EdgeInsets.all(12.0),
              child: const Text('Connectez avec vos proches !', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
            ),
            Container(
              height: postimageavailable ? 400 : 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Couleur de l'ombre avec opacité
                    spreadRadius: 4, // Rayonnement de l'ombre
                    blurRadius: 6, // Rayon du flou de l'ombre
                    offset: const Offset(3, 3), // Décalage horizontal et vertical de l'ombre
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: containposts ?  Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // En-tête avec l'image de profil et le nom de l'utilisateur
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  // Photo de profil
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundImage: AssetImage('assets/images/naruto.jpg'),
                                  ),
                                  SizedBox(width: 12),
                                  // Nom de l'utilisateur
                                  Text(
                                    'Jean Pierre',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Message publié
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Text(
                                'message nuisdbvdbsi ub iubriuei uibreiuvb bvruievbei vreiuvbieurbvierv',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            // Image attachée au post
                            Expanded(
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  postimageavailable ?
                                  ClipRRect(
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5), // Adjust the opacity
                                        BlendMode.darken, // Ensures the opacity blends with the image
                                      ),
                                      child: Image.asset(
                                        "assets/images/naruto.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ) : const SizedBox(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.cyan.shade700,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if(orgExist){
                                              Navigator.pushNamed(context, '/accfam');
                                            }else {
                                              bool? result = await _designService.dialogJoinorCreatFam(context);
                                              if(result != null){
                                                if(result){
                                                  _designService.dialogJoinOrganizationDialog(context);
                                                }else{
                                                  _designService.dialogCreateOrganizationDialog(context);
                                                }
                                              }
                                            }

                                          },
                                          child: const Row(
                                            children: [
                                              Text("Joindre l'espace"),
                                              SizedBox(width: 8),
                                              Icon(Icons.arrow_right_alt)
                                            ],
                                      )
                                      ),
                                    ],
                                  ),
                                ],
                              )

                            ),
                          ],
                        ),
                        // Badge pour indiquer les nouveaux posts
                        if (true)
                          Positioned(
                            top: 20,
                            right: 24,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Nouveaux',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ) :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline,
                          size: 48,
                          color: Colors.cyan,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Aucun post pour l'instant.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Soyez le premier à partager avec vos proches !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyan,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: (){},
                              icon: const Icon(Icons.add),
                              label: const Text("Créer un post"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Espace Famille',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              padding: const EdgeInsets.all(12.0),
              child: const Text('Gestion facile d\'épicerie, Miam !', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
            ),
            Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Couleur de l'ombre avec opacité
                      spreadRadius: 4, // Rayonnement de l'ombre
                      blurRadius: 6, // Rayon du flou de l'ombre
                      offset: const Offset(3, 3), // Décalage horizontal et vertical de l'ombre
                    ),
                  ],
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: containposts? Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(right: 20),
                                              height: 40, width: 40,
                                              child: Image.asset('assets/images/naruto.jpg', fit: BoxFit.cover,),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Banane',
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 15,
                                                        width: 15,
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
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              margin: const EdgeInsets.only(right: 8),
                                              decoration: BoxDecoration(
                                                //border: ,
                                                color: valideAchat1 ? Colors.grey.withOpacity(0.3) : Colors.red.withOpacity(0.6),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "3",
                                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Qté",
                                                    style: TextStyle(fontSize: 8, color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 16)
                                    ],
                                  );
                                }),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: (){
                                    Navigator.pushNamed(context, '/liste_epicerie');
                                  }, child: const Text('Voir plus')),
                            ),
                          ],
                        ),
                      ],
                    ) :
                    Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.dinner_dining,
                              size: 48,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "La liste d'epicerie est vide",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Manque t'il quelque chose au frigo ?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: (){
                                Navigator.pushNamed(context, '/liste_epicerie');
                              },
                              icon: const Icon(Icons.add),
                              label: const Text("Ajouter un aliment"),
                            ),
                          ],
                        ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Liste d'épicerie",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              padding: const EdgeInsets.all(12.0),
              child: const Text('Mieux s\'organiser en famille !', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/listetaches');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2), // Couleur de l'ombre avec opacité
                              spreadRadius: 4, // Rayonnement de l'ombre
                              blurRadius: 6, // Rayon du flou de l'ombre
                              offset: const Offset(1, 3), // Décalage horizontal et vertical de l'ombre
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Image de la catégorie
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(38),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/images/task_icon.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            // Titre de la catégorie
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.green.shade700,
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Taches',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: ()async{
                        if(orgExist){
                          Navigator.pushNamed(context, '/classement');
                        }else {
                          bool? result = await _designService.dialogJoinorCreatFam(context);
                          if(result != null){
                            if(result){
                              _designService.dialogJoinOrganizationDialog(context);
                            }else{
                              _designService.dialogCreateOrganizationDialog(context);
                            }
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2), // Couleur de l'ombre avec opacité
                              spreadRadius: 4, // Rayonnement de l'ombre
                              blurRadius: 6, // Rayon du flou de l'ombre
                              offset: const Offset(2, 2), // Décalage horizontal et vertical de l'ombre
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Image de la catégorie
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(38),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                child: Image.asset('assets/images/trophy_icon.png', fit: BoxFit.contain,))
                            ),
                            // Titre de la catégorie
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade700,
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Classement',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              padding: const EdgeInsets.all(12.0),
              child: const Text('Se tenir à jour des évènements !', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Couleur de l'ombre avec opacité
                    spreadRadius: 4, // Rayonnement de l'ombre
                    blurRadius: 6, // Rayon du flou de l'ombre
                    offset: const Offset(3, 3), // Décalage horizontal et vertical de l'ombre
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/events');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image de la catégorie
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/images/family_jump.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Titre de la catégorie
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Evenements',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              padding: const EdgeInsets.all(12.0),
              child: const Text('Apercu des membres de votre famille !', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Couleur de l'ombre avec opacité
                    spreadRadius: 4, // Rayonnement de l'ombre
                    blurRadius: 6, // Rayon du flou de l'ombre
                    offset: const Offset(3, 3), // Décalage horizontal et vertical de l'ombre
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: (){
                  //Navigator.pushNamed(context, '/events');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image de la catégorie
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch ,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2), // Couleur de l'ombre avec opacité
                                    spreadRadius: 4, // Rayonnement de l'ombre
                                    blurRadius: 6, // Rayon du flou de l'ombre
                                    offset: const Offset(3,0), // Décalage horizontal et vertical de l'ombre
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                'assets/images/family_jump.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                              child: orgExist ?
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 7,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index){
                                    return Container(
                                      padding: const EdgeInsets.all(4),
                                      margin: const EdgeInsets.only(top: 8),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            height: 80,
                                            width: 80,
                                            margin: const EdgeInsets.only(top: 20),
                                            child: ClipOval(
                                              child: Image.asset(
                                                'assets/images/cat_profile_img.jpg',
                                                semanticLabel: 'Image du profil',
                                                fit: BoxFit.cover,),
                                            ),
                                          ),
                                          //const SizedBox(height: 4),
                                          const Text('Jean Pierre', textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),)
                                        ],
                                      ),
                                    );
                                  }) :
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pinkAccent,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: ()async{
                                        bool? result = await _designService.dialogJoinorCreatFam(context);
                                        if(result != null){
                                          if(result){
                                            _designService.dialogJoinOrganizationDialog(context);
                                          }else{
                                            _designService.dialogCreateOrganizationDialog(context);
                                          }
                                        }
                                      }, child: const Row(
                                        children: [
                                          Text('Joinde ma famille'),
                                          SizedBox(width: 8),
                                          Icon(Icons.arrow_right_alt)
                                        ],
                                      )
                                  ),
                                ],
                              ),
                          )
                        ],
                      ),
                    ),
                    // Titre de la catégorie
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(16),
                        ),
                      ),
                      child: Text(
                        orgExist? 'Nom de l\'organisation' : 'Votre famille',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const  SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}
