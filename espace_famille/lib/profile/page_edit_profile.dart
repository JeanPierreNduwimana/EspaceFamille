import 'package:flutter/material.dart';

import '../services/widget_service.dart';

class EditProfilePage extends StatefulWidget {

  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _profileImage = 'assets/images/naruto.jpg'; // Image par défaut
  WidgetService _designService = WidgetService();
  Image? uploadedImage = null;

  @override
  Widget build(BuildContext context) {
    _usernameController.text = 'Jean Pierre';
    _descriptionController.text = 'ceci est la descruption de mon profil';
    return Scaffold(
      appBar: _designService.appBar(context, 'Modifier votre profil', true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Photo de profil
           /* Container(
              color: Colors.red,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        color: Colors.green,
                        //height: double.infinity,
                        margin: const EdgeInsets.only(top:16, left: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_back_ios_new)
                            )
                          ],
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      //_showChangePhotoDialog();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(_profileImage),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(Icons.camera_alt, color: Colors.grey),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox())
                ],
              ),
            ), */
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
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Nom d'utilisateur
                  TextField(
                    controller: _usernameController,
                    cursorColor: Colors.cyan,
                    decoration: const InputDecoration(
                      labelText: 'Nom d\'utilisateur',
                      labelStyle: TextStyle(
                        color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
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
                    decoration: const InputDecoration(
                      labelText: 'Description',
                        labelStyle: TextStyle(
                            color: Colors.grey
                        ),
                      focusedBorder: OutlineInputBorder(
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
                    child: Text('Enregistrer', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
      bottomNavigationBar: _designService.navigationBar(context, 0, setState),
    );
  }

  void _showChangePhotoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Changer la photo de profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choisir depuis la galerie'),
                onTap: () {
                  setState(() {
                    _profileImage = 'assets/images/naruto.jpg'; // Simule un changement
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Prendre une photo'),
                onTap: () {
                  // Simuler l'ajout d'une photo prise
                  setState(() {
                    _profileImage = 'assets/images/default_profile.jpg';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveProfile() {
    final String username = _usernameController.text;
    final String description = _descriptionController.text;

    // Simule la sauvegarde des informations (à remplacer par une logique réelle)
    if (username.isNotEmpty && description.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil mis à jour avec succès!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
    }
  }
}
