import 'package:flutter/material.dart';

import '../services/design_service.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}
DesignService _designService = DesignService();

class _AboutUsPageState extends State<AboutUsPage> {
  final TextEditingController _messageController = TextEditingController();

  // Fonction pour afficher le Dialog pour les suggestions
  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nous aimerions avoir votre avis'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Veuillez nous faire part de vos commentaires ou suggestions.',
                style: TextStyle(fontSize: 14),
              ),
              TextField(
                controller: _messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Votre message...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Logique pour envoyer le message (ici, on l'affiche dans la console)
                print("Message envoyé: ${_messageController.text}");
                _messageController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Envoyer'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/cat_profile_img.jpg',
                  semanticLabel: 'Image du profil',
                  fit: BoxFit.cover,),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Cette application a été créée par Jean Pierre Nduwimana. Jean Pierre est étudiant en ingénierie informatique et passionné par le développement d\'applications mobiles. Cette application a été développée de son plein gré dans le cadre de son apprentissage personnel.',
              style: TextStyle(fontSize: 16,),
            ),
            const SizedBox(height: 16),
            const Text(
              'Jean Pierre aimerait en savoir plus sur ce que vous pensez de cette application. Vos commentaires et suggestions sont les bienvenus pour l\'aider à améliorer et développer de nouvelles fonctionnalités.',
              style: TextStyle(fontSize: 16),
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
    );
  }
}
