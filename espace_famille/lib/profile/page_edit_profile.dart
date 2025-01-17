import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../services/widget_service.dart';

class EditProfilePage extends StatefulWidget {

  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final WidgetService _designService = WidgetService();
  Image? uploadedImage;

  @override
  Widget build(BuildContext context) {
    _usernameController.text = 'Jean Pierre';
    _descriptionController.text = 'ceci est la descruption de mon profil';
    return Scaffold(
      appBar: _designService.appBar(context, S.of(context).appOptionEditProfile, true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row( // rangé contenant l'image
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back_ios_new)
                          )
                        ],
                      )),
                  GestureDetector(
                    onTap: () async{
                      //_showChangePhotoDialog();

                      Image? result = await _designService.getImage();
                      if(result != null){
                        setState((){
                          uploadedImage = result;
                        });
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          margin: const EdgeInsets.only(top: 20),
                          child: ClipOval(
                            child: uploadedImage == null ? Image.asset(
                              'assets/images/cat_profile_img.jpg',
                              semanticLabel: 'Image du profil',
                              fit: BoxFit.cover,) : uploadedImage!,
                          ),
                        ),
                        Positioned(
                            bottom: 8,
                            right: 8,
                            child: Icon(Icons.camera_alt, color: Colors.cyan.shade800,))
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox())
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  // Nom d'utilisateur
                  TextField(
                    controller: _usernameController,
                    cursorColor: Colors.cyan,
                    decoration: InputDecoration(
                      labelText: S.of(context).labelUsername,
                      labelStyle: const TextStyle(
                        color: Colors.grey
                      ),
                      focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                    color: Colors.cyan, // Change border color here
                      width: 2.0, // Border width
                    )
                  )
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Description du profil
                  TextField(
                    controller: _descriptionController,
                    cursorColor: Colors.cyan,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: S.of(context).labelDescription,
                        labelStyle: const TextStyle(
                            color: Colors.grey
                        ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyan, // Change border color here
                            width: 2.0, // Border width
                          )
                      )

                    ),
                  ),
                  const SizedBox(height: 32),
                  // Bouton Enregistrer
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    ),
                    onPressed: () {
                      _saveProfile();
                    },
                    child: Text(S.of(context).buttonSave, style: const TextStyle(fontSize: 18)),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
      bottomNavigationBar: _designService.navigationBar(context, 0, setState),
    );
  }


  void _saveProfile() {
    final String username = _usernameController.text;
    final String description = _descriptionController.text;

    // Simule la sauvegarde des informations (à remplacer par une logique réelle)
    if (username.isNotEmpty && description.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil mis à jour avec succès!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
    }
  }
}
