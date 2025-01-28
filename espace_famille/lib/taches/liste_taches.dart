import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../generated/l10n.dart';
import '../services/widget_service.dart';
import 'model_tache.dart';

WidgetService _designService = WidgetService();
List<Tache> taches = [
  Tache('Organiser le bureau et trier les documents important',getImage(),true),
  Tache('Préparer un repas équilibré pour le déjeuner',getImage(),false),
  Tache('Faire une promenade de 30 minutes dans un parc local.',getImage(),true),
  Tache('Apprendre 10 mots dans une nouvelle langue.',getImage(),false),
  Tache('Appeler un ami pour prendre des nouvelles.',getImage(),true),
  Tache('Nettoyer et organiser le réfrigérateur.',getImage(),false),
  Tache('Planifier un budget pour la semaine à venir.',getImage(),true),
  Tache('Lire un chapitre d\'un livre en cours.',getImage(),false),
  Tache('Réparer un objet ou un appareil ménager défectueux.',getImage(),true),
  Tache('Créer une playlist de musique motivante pour la journée.',getImage(),false)
];

bool isloading = true;

class ListeTaches extends StatefulWidget {
  const ListeTaches({super.key});

  @override
  State<ListeTaches> createState() => _ListeTachesState();
}

class _ListeTachesState extends State<ListeTaches> {

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
      appBar: _designService.appBar(context,S.of(context).appBarTaskPageTitle, false,Colors.green),
      body: isloading ? _designService.shimmerTaches(context) : buildBody(),
      bottomNavigationBar: _designService.navigationBar(context, 3, setState),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isloading ? Colors.grey : Theme.of(context).brightness == Brightness.dark? Colors.green.shade700 : Colors.green.shade400,
        foregroundColor: Colors.white,
        onPressed: (){
          _designService.dialogCreateTask(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: Colors.green,
      child: ListView.builder(
          itemCount: taches.length,
          itemBuilder: (BuildContext context, int index) {

            // À l'index 0, on affiche les infos du profil
            if(index == 0){
              return Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    Image.asset('assets/images/task_list.png'),
                    const SizedBox(height: 32),
                    Text(S.of(context).taskPageTitle, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }
            return GestureDetector(
               onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      height: 400,
                      decoration: BoxDecoration(
                        color: !isDarkMode ? Colors.white : null,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                taches[index].img,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Description
                            Text(
                              taches[index].descr,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),

                            // List of tasks
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: taches[index].sous_taches.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.check_circle_outline, color: Colors.green),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          taches[index].sous_taches[i],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 24),

                            // Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 2,
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                S.of(context).buttonOwnAtask,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                String message = S.of(context).messageOwnAtask;
                                bool? result = await _designService.dialogYesorNo(context, message);

                                if (result != null) {
                                  result ? Navigator.pushNamed(context, '/listetaches') : null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: !isDarkMode ? Border.all(color: Colors.grey.shade300, width: 1) : null,
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode ? Colors.black87 :  Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(1, 1),
                      ),
                    ]),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox( height: 80, width:80, child: Image.asset(taches[index].img)),
                        Expanded(
                          child: Text(
                            taches[index].descr,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.green[200],
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.restart_alt, color: Colors.green,),
                        const SizedBox(width: 8),
                        Text(S.of(context).labelDaily, style: const TextStyle(fontStyle: FontStyle.italic),),
                        const SizedBox(width: 4),
                      ],
                    ),

                  ],
                ),
              ),
            );
          }),
    );
  }
}

  String getImage(){
    int rnd = Random().nextInt(3);
    switch(rnd){
      case 0:
        return 'assets/images/bird.png';
      case 1:
        return 'assets/images/face_male.png';
      case 2:
        return 'assets/images/smiley_laughing.png';
      default:
        return 'assets/images/bird.png';
    }
  }
