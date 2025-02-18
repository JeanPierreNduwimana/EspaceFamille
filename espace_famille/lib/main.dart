import 'package:espace_famille/app_management/app_options.dart';
import 'package:espace_famille/authentification/connexion.dart';
import 'package:espace_famille/authentification/inscription.dart';
import 'package:espace_famille/epicerie/liste_epicerie.dart';
import 'package:espace_famille/events/event_details.dart';
import 'package:espace_famille/events/events_list.dart';
import 'package:espace_famille/profile/classement_profile.dart';
import 'package:espace_famille/profile/page_edit_profile.dart';
import 'package:espace_famille/profile/page_profile.dart';
import 'package:espace_famille/events/horaire.dart';
import 'package:espace_famille/taches/liste_evaluation.dart';
import 'package:espace_famille/taches/liste_taches.dart';
import 'package:flutter/material.dart';
import 'app_management/accueil.dart';
import 'app_management/notification_page.dart';
import 'espace_famille/accueil_espace_famille.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() {
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // Spanish, no country code
      ],
      title: 'Flutter Demo',
      theme: ThemeData.light(), // Mode clair
      darkTheme: ThemeData.dark(), // Mode sombre
      themeMode: ThemeMode.system, // Hérite le mode du système
      home: const Connection(),
      routes: {
        '/accfam': (context) => const AccueilEspaceFammille(),
        '/pageprofile': (context) => const PageProfile(),
        '/listetaches' : (context) => const ListeTaches(),
        '/listevaluation' : (context) => const ListeEvaluation(),
        '/classement' : (context) => const ClassementProfiles(),
        '/horaire' : (context) => const Horaire(),
        '/liste_epicerie' : (context) => const ListeEpicerie(),
        '/connexion' : (context) => const Connection(),
        '/inscription' : (context) => const Inscription(),
        '/acceuil' : (context) => const Accueil(),
        '/app_options' : (context) => const AppOptions(),
        '/edit_profile' : (context) => const EditProfilePage(),
        '/notifications' : (context) => const NotificationsPage(),
        '/events_list' : (context) => const EventsList(),
        '/event_detail' : (context) => const EventDetailsPage()
      },

    );
  }
}