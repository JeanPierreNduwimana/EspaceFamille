import 'package:espace_famille/screens/app_options_screen.dart';
import 'package:espace_famille/screens/events_screen.dart';
import 'package:espace_famille/screens/home_page_screen.dart';
import 'package:espace_famille/screens/signin_screen.dart';
import 'package:espace_famille/screens/event_details_screen.dart';
import 'package:espace_famille/screens/member_tasks_ratings_screen.dart';
import 'package:espace_famille/screens/members_ranking_screen.dart';
import 'package:espace_famille/screens/events_schedule_screen.dart';
import 'package:espace_famille/screens/signup_screen.dart';
import 'package:espace_famille/screens/member_profile_edit_screen.dart';
import 'package:espace_famille/screens/member_profile_screen.dart';
import 'package:espace_famille/screens/notification_screen.dart';
import 'package:espace_famille/screens/splash_screen.dart';
import 'package:espace_famille/screens/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'screens/posts_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/groceries_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const SplashScreen(),
      routes: {
        '/accfam': (context) => const PostsScreen(),
        '/pageprofile': (context) => const MemberProfileScreen(),
        '/listetaches': (context) => const ListeTaches(),
        '/listevaluation': (context) => const MemberTasksRatingsScreen(),
        '/classement': (context) => const MembersRankingScreen(),
        '/horaire': (context) => const EventsScheduleScreen(),
        '/liste_epicerie': (context) => const GroceriesScreen(),
        '/connexion': (context) => const SignInScreen(),
        '/inscription': (context) => const SignUpScreen(),
        '/acceuil': (context) => const HomePageScreen(),
        '/app_options': (context) => const AppOptionsScreen(),
        '/edit_profile': (context) => const MemberProfileEditScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/events_list': (context) => const EventsScreen(),
        '/event_detail': (context) => const EventDetailsScreen()
      },
    );
  }
}
