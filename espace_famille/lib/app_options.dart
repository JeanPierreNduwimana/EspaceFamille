import 'package:espace_famille/profile/page_profile.dart';
import 'package:espace_famille/services/design_service.dart';
import 'package:flutter/material.dart';

class AppOptions extends StatefulWidget {
  const AppOptions({super.key});

  @override
  State<AppOptions> createState() => _AppOptionsState();
}
DesignService _designService = DesignService();
bool orgExist = false;
class _AppOptionsState extends State<AppOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar(context, 'Profile', true),
      body: ListView(
        children: [
          _buildListTile(
            context,
            Container(
              height: 38,
              width: 38,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/cat_profile_img.jpg',
                  semanticLabel: 'Image du profil',
                  fit: BoxFit.cover,),
              ),
            ),
            'Mon Profil',
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
            Container(
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
            'Ma famille',
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
            Icon(Icons.notifications, color: Colors.green),
            'Notifications',
            Colors.green,
                () {
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );*/
            },
          ),
          _buildListTile(
            context,
            Icon(Icons.settings, color: Colors.cyan),
            'Parameters',
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
            Icon(Icons.exit_to_app, color: Colors.redAccent),
            'Deconnexion',
            Colors.redAccent,
                () {
              _showLogoutDialog(context);
            },
          ),
          _buildListTile(
            context,
            Icon(Icons.info, color: Colors.blueAccent),
            'About Us',
            Colors.blueAccent,
                () {
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );*/
            },
          ),
        ],
      ),
      bottomNavigationBar: _designService.navigationBar(context, 0, setState),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildListTile(
      BuildContext context, Widget? icon, String title, Color iconColor, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: iconColor.withOpacity(0.2),
              child: icon,
            ),
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 20),
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
          backgroundColor: Colors.white,
          title: Text('Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement the logout action
                Navigator.pushNamed(context, '/connexion'); // Close dialog
                // Navigate to login page or perform logout action
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

}

// Dummy pages for each option
class ParametersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parameters')),
      body: Center(child: Text('Settings and preferences')),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Center(child: Text('Information about the app')),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: Center(child: Text('Manage your notifications')),
    );
  }
}
