import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/widget_service.dart';
import 'model_profile.dart';

class ClassementProfiles extends StatefulWidget {
  const ClassementProfiles({super.key});

  @override
  State<ClassementProfiles> createState() => _ClassementProfilesState();
}
WidgetService _designService = WidgetService();

List<Profile> profiles = [
  Profile("Bruno", '28-04-2003', 4),
  Profile("Jean Pierre", '16-03-1999', 2),
  Profile("Mario", '24-07-2011', 4),
  Profile("Bruno", '28-04-2003', 4),
  Profile("Bruno", '28-04-2003', 4),
  Profile("Bruno", '28-04-2003', 4),
  Profile("Bruno", '28-04-2003', 4),
  Profile("Bruno", '28-04-2003', 4),
];

class _ClassementProfilesState extends State<ClassementProfiles> {

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
    return Scaffold(
      appBar: _designService.appBar(context,'Meilleurs membres', false),
      body: buildBody(),
      backgroundColor: Colors.white,
      bottomNavigationBar: _designService.navigationBar(context, 3, setState),
      //drawer: const NavMenu(),
    );
  }
}

Widget buildBody(){
  Future<void> _onRefresh() async {
  }
  return RefreshIndicator(
    onRefresh: _onRefresh,
    color: Colors.cyan,
    child: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (BuildContext context, int index) {
          if(index == 0){ // À l'index 0, on affiche le podium
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 2nd place
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/cat_profile_img.jpg',
                            fit: BoxFit.cover,
                            height: 48,
                            width: 48,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 120,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '2',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 1st place
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/cat_profile_img.jpg',
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 160,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade700,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '1',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 3rd place
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/cat_profile_img.jpg',
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 100,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.brown.shade400,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.brown.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '3',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );

          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: Colors.grey.shade300, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(1, 1), // Décalage horizontal et vertical de l'ombre
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Classement
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: index == 1 ? Colors.yellow.shade700 : (index == 2) ? Colors.grey.shade400 : (index == 3) ? Colors.brown.shade400 : Colors.cyan.shade200, shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 32),

                // Image de profil
                ClipOval(
                  child: Image.asset(
                    'assets/images/cat_profile_img.jpg',
                    semanticLabel: 'Image du profil',
                    fit: BoxFit.cover,
                    height: 56,
                    width: 56,
                  ),
                ),

                // Informations utilisateur
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        profiles[index].nom,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profiles[index].date,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _designService.getRatingStars(profiles[index].nbEtoiles, false),
                    ],
                  ),
                ),
              ],
            ),
          );

        }),
  );
}
