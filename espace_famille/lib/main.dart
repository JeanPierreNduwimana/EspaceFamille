import 'package:espace_famille/profile/page_profile.dart';
import 'package:flutter/material.dart';

import 'espace_famille/accueil_espace_famille.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PageProfile(),

      routes: {
        '/accfam': (context) => const AccueilEspaceFammille(),
        '/pageprofile': (context) => const PageProfile()
      },

    );
  }
}