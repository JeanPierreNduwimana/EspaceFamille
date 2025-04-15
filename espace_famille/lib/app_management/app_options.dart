import 'package:espace_famille/app_management/about_us_page.dart';
import 'package:espace_famille/profile/page_profile.dart';
import 'package:espace_famille/authentification/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import '../app_services/widget_service.dart';
import '../authentification/connexion.dart';
import '../generated/l10n.dart';
import 'notification_page.dart';

class AppOptions extends StatefulWidget {
  const AppOptions({super.key});

  @override
  State<AppOptions> createState() => _AppOptionsState();
}
WidgetService _designService = WidgetService();
bool orgExist = false;
class _AppOptionsState extends State<AppOptions> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: _designService.appBar(context, 'Profile', true,Colors.cyan),
      body: ListView(
        children: [
          _buildListTile(
            context,
            SizedBox(
              height: 38,
              width: 38,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/cat_profile_img.jpg',
                  semanticLabel: 'Image du profil',
                  fit: BoxFit.cover,),
              ),
            ),
            S.of(context).appOptionProfile,
            Colors.cyan,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PageProfile()),
              );
            },
          ),
          _buildListTile(
            context,
            SizedBox(
              height: 36,
              width: 36,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'assets/images/cat_profile_img.jpg',
                  semanticLabel: 'Image du profil',
                  fit: BoxFit.cover,),
              ),
            ),
            S.of(context).appOptionFamily,
            Colors.cyan,
                () async {

              if(orgExist){

              }else{
                bool? result = await _designService.dialogJoinorCreatFam(context);
                if(result != null){
                  if(result){
                    _designService.dialogJoinOrganizationDialog(context);
                  }else{
                    _designService.dialogCreateOrganizationDialog(context);
                  }
                }
              }
              /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PageProfile()),
              ); */
            },
          ),
          _buildListTile(
            context,
            const Icon(Icons.notifications, color: Colors.green),
            S.of(context).appOptionNotifications,
            Colors.green,
                () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsPage()),
              );
            },
          ),
          _buildListTile(
            context,
            const Icon(Icons.settings, color: Colors.cyan),
            S.of(context).appOptionEditProfile,
            Colors.cyan,
                () {

              Navigator.pushNamed(context, '/edit_profile');

              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ParametersPage()),
              );*/
            },
          ),

          _buildListTile(
            context,
            const Icon(Icons.exit_to_app, color: Colors.redAccent),
            S.of(context).appOptionDeconnexion,
            Colors.redAccent,
                () {
              _showLogoutDialog(context);
            },
          ),
          _buildListTile(
            context,
            const Icon(Icons.info, color: Colors.blueAccent),
            S.of(context).appOptionAboutUs,
            Colors.blueAccent,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsPage()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: _designService.navigationBar(context, 0, setState),
      backgroundColor: !isDarkMode ? Colors.white : null,
    );
  }

  Widget _buildListTile(
      BuildContext context, Widget? icon, String title, Color iconColor, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: iconColor.withOpacity(0.2),
              child: icon,
            ),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20),
            onTap: onTap,
          ),
          Divider(thickness: 1, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  // Logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.cyan),),
            ),
            TextButton(
              onPressed: () async {
               // final prefs = await SharedPreferences.getInstance();
               // prefs.remove('username');
               // prefs.remove('password');
                await FirebaseAuthService().signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Connection()), (Route<dynamic> route) => false,
                );
              },
              child: const Text('Logout', style: TextStyle(color: Colors.cyan),),
            ),
          ],
        );
      },
    );
  }

}

