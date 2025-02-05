import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../services/widget_service.dart';

class EventsList extends StatefulWidget {
  const EventsList({super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}
WidgetService _widgetService = WidgetService();

class _EventsListState extends State<EventsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _widgetService.appBar(context,S.of(context).homePageTitleEvents, false,Colors.purple),
      body: buildBody(),
      bottomNavigationBar: _widgetService.navigationBar(context, 4, setState),
    );
  }

  Widget buildBody() {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    bool showDescription = false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
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
                      color: Colors.purple.shade700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(' 10-10-2025 ', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
