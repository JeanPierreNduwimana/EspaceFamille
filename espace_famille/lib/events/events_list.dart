import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../generated/l10n.dart';
import '../app_services/widget_service.dart';

class EventsList extends StatefulWidget {
  const EventsList({super.key});
  @override
  State<EventsList> createState() => _EventsListState();
}

WidgetService _widgetService = WidgetService();

bool showDescription = false;
class _EventsListState extends State<EventsList> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp // Optional
    ]);
  }

  @override
  Widget build(BuildContext context) {
    void showEventDialog(BuildContext contextState) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Coins arrondis
          ),
          content: const SizedBox(height: 10), // Espacement
          actions: [
            SizedBox(
              width: double.infinity, // Bouton pleine largeur
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Couleur principale
                  foregroundColor: Colors.white, // Texte en blanc
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Fermer ce dialog
                  Future.delayed(const Duration(milliseconds: 200), () {
                    _widgetService.dialogCreateEvent(contextState); // Ouvrir le nouveau dialog
                  });
                },
                child: Text(S.of(context).buttonCreateEvent),
              ),
            ),
            SizedBox(height: 10), // Espacement entre les boutons
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.purple, // Texte violet
                  side: BorderSide(color: Colors.purple, width: 2), // Bordure violette
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/horaire');
                },
                child: Text(S.of(context).buttonShowSchedure),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: _widgetService.appBar(context,S.of(context).homePageTitleEvents, false,Colors.purple),
      body: buildBody(),
      bottomNavigationBar: _widgetService.navigationBar(context, 4, setState),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade800,
        foregroundColor: Colors.white,
        onPressed: (){
          showEventDialog(context);
        },
        child: const Icon(Icons.calendar_month),
      ),
    );
  }

  Widget buildBody() {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              if(showDescription){
                Navigator.pushNamed(context, '/event_detail');
              }
              setState(() {
                showDescription = !showDescription;
              });
            },
            child: Stack(
              children: [
                Container(
                  height: 150,
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // Couleur de l'ombre avec opacité
                        spreadRadius: isDarkMode ? 1 :4, // Rayonnement de l'ombre
                        blurRadius: 6, // Rayon du flou de l'ombre
                        offset: isDarkMode ? const Offset(1,1) : const Offset(3, 3), // Décalage horizontal et vertical de l'ombre
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Image de la catégorie
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Opacity(
                            opacity: showDescription ? 0.3 : 1.0,
                            child: Image.asset(
                              'assets/images/family_jump.jpg',
                              fit: BoxFit.cover,
                            ),
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
                          'Nom de l\'evenement',
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
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(' 10-10-2025 ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                ),
                showDescription ? Positioned(
                    top: 12,
                    left: 10,
                    child: Container(
                        width: 250,
                        child: const Text(
                          'lorem ipsum, ceci est une description pour le prochain evenement, je suis trèes excité wow! il reste encore un peu d\'espace pour dire quelque',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        )
                    )
                ) : const SizedBox()
              ],
            ),
          );
        }
      ),
    );
  }


}
