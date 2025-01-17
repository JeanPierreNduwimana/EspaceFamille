import 'package:flutter/material.dart';

import '../services/widget_service.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}
WidgetService _designService = WidgetService();

class _AboutUsPageState extends State<AboutUsPage> {
  final TextEditingController _messageController = TextEditingController();

  // Fonction pour afficher le Dialog pour les suggestions
  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Nous aimerions avoir votre avis'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Veuillez nous faire part de vos commentaires ou suggestions.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _messageController,
                cursorColor: Colors.cyan,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Votre message...',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.cyan,
                          width: 1.0
                      )
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler', style: TextStyle(color: Colors.cyan)),
            ),
            TextButton(
              onPressed: () {
                // Logique pour envoyer le message (ici, on l'affiche dans la console)
                print("Message envoyé: ${_messageController.text}");
                _messageController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Envoyer', style: TextStyle(color: Colors.cyan)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar(context, 'À propos de l\'Espace Famille ', false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/cat_profile_img.jpg',
                    semanticLabel: 'Image du profil',
                    fit: BoxFit.cover,),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "L'application Espace Famille a été conçue et développée par Jean Pierre Nduwimana, "
                "un étudiant en ingénierie informatique passionné par l'univers des applications mobiles."
                "L'application a été créée en 2025 dans le cadre de son apprentissage personnel et de son "
                "désir d'acquérir de nouvelles compétences. \n \n"
                "Jean Pierre a mis tout son savoir-faire et son enthousiasme dans la création de cette application,"
                "avec l'objectif de proposer une expérience utilisateur fluide et intuitive. Cette application reflète"
                "son engagement à apprendre, à expérimenter et à créer des solutions pratiques qui répondent aux besoins des utilisateurs. \n \n"
                "En tant que développeur en constante évolution, Jean Pierre serait ravi de recevoir vos commentaires et suggestions qui seront essentiels pour l'amélioration continue de l'application."
                "Merci d'utiliser l'application Espace Famille et de faire partie de ce projet en pleine croissance !",
                style: TextStyle(fontSize: 16,),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showFeedbackDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: const Text(
                  'Envoyer vos commentaires ou suggestions',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _designService.navigationBar(context, 0, setState),
      backgroundColor: Colors.white,
    );
  }
}
