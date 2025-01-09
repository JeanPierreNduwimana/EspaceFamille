import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class NavMenu extends StatefulWidget {
  const NavMenu({super.key});

  @override
  State<NavMenu> createState() => _NavMenuState();
}

class _NavMenuState extends State<NavMenu> {

  Color _textColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _updateTextColor();
  }

  Future<void> _updateTextColor() async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      AssetImage('assets/images/naruto.jpg'),
    );

    // Vérifiez si l'image est sombre ou claire
    final dominantColor = paletteGenerator.dominantColor?.color ?? Colors.black;
    final brightness = ThemeData.estimateBrightnessForColor(dominantColor);

    setState(() {
      _textColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    });
  }
  @override
  Widget build(BuildContext context) {
    var listview = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.cyan.shade50],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Image de fond remplissant toute la section
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/naruto.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Optionnel : superposition d'une couleur pour le contraste
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      // Contenu au-dessus de l'image de fond
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.only(top: 20),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/cat_profile_img.jpg',
                                semanticLabel: 'Image du profil',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Jean Pierre',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.cyan,
                                ),
                              ),
                              Text('   |   ', style: TextStyle(fontSize: 12, color: _textColor)),
                              Text(
                                '16-03-1999',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: _textColor
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  dense: true,
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.groups, color: Colors.cyan, size: 20),
                  ),
                  title: const Text(
                    "Espace Famille",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: const Text(
                    "Connectez avec vos proches",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    Navigator.pushNamed(context, '/accfam');
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  dense: true,
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.shopping_cart_outlined, color: Colors.deepOrange, size: 18),
                  ),
                  title: const Text(
                    "Épicerie",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: const Text(
                    "Connectez avec vos proches",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    Navigator.pushNamed(context, '/liste_epicerie');
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                 // contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  dense: true,
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.task_alt, color: Colors.green, size: 20),
                  ),
                  title: const Text(
                    "Liste des tâches",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: const Text(
                    "S'organiser en famille",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    Navigator.pushNamed(context, '/listetaches');
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                 // contentPadding: const EdgeInsets.symmetric(horizontal: 16,),
                  dense: true,
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.emoji_events, color: Colors.orange, size: 20),
                  ),
                  title: const Text(
                    "Classement",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: const Text(
                    "Les meilleurs de la famille",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    Navigator.pushNamed(context, '/classement');
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  // contentPadding: const EdgeInsets.symmetric(horizontal: 16,),
                  dense: true,
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.calendar_month, color: Colors.deepPurple, size: 20),
                  ),
                  title: const Text(
                    "Horaire",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: const Text(
                    "L'agenda des tâches",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    Navigator.pushNamed(context, '/horaire');
                  },
                )
              ],
            ),
          ),
          const Divider(thickness: 1, color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.grey),
            title: const Text(
              "À Propos",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.grey),
            title: const Text(
              "Paramètres",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text(
              "Déconnexion",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            onTap: () {
              // Déconnexion logic
            },
          ),
        ],
      ),
    );
    return Drawer(
      child: Container(
        color: Colors.white,
        child: listview,
      ),
    );
  }

}
