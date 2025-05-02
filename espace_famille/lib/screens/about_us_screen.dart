import 'package:flutter/material.dart';

import '../widgets/widget_service.dart';
import '../generated/l10n.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

WidgetService _designService = WidgetService();

class _AboutUsScreenState extends State<AboutUsScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // Fonction pour afficher le Dialog pour les suggestions
    void _showFeedbackDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: !isDarkMode ? Colors.white : null,
            title: Text(S.of(context).dialogUserSuggestionsTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).dialogUserSuggestionsSubTitle,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _messageController,
                  cursorColor: Colors.cyan,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: S.of(context).labelHintMessage,
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan, width: 1.0)),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).buttonCancel,
                    style: const TextStyle(color: Colors.cyan)),
              ),
              TextButton(
                onPressed: () {
                  _messageController.clear();
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).buttonSend,
                    style: const TextStyle(color: Colors.cyan)),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: _designService.appBar(
          context, S.of(context).appBaraboutUsPageTitle, false, Colors.cyan),
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
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).AboutUsText,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showFeedbackDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: Text(
                  S.of(context).buttonSendCommentOrSuggestions,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _designService.navigationBar(context, 0, setState),
    );
  }
}
