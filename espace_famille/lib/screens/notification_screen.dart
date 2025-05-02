import 'package:espace_famille/widgets/shared_app_bar.dart';
import 'package:flutter/material.dart';
import '../widgets/widget_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

WidgetService _designService = WidgetService();

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Nouveau message',
      'description': 'Vous avez reçu un nouveau message de Jean.',
      'date': '15 Janvier 2025',
      'read': false,
      'important': false,
    },
    {
      'title': 'Mise à jour disponible',
      'description':
          'Une nouvelle mise à jour est disponible pour votre application.',
      'date': '14 Janvier 2025',
      'read': true,
      'important': true,
    },
    {
      'title': 'Alerte de sécurité',
      'description': 'Connexion suspecte détectée dans votre compte.',
      'date': '13 Janvier 2025',
      'read': false,
      'important': false,
    },
    {
      'title': 'Bienvenue !',
      'description': 'Merci de vous être inscrit à notre application.',
      'date': '12 Janvier 2025',
      'read': true,
      'important': false,
    },
  ];

  void markAsRead(int index) {
    setState(() {
      notifications[index]['read'] = true;
    });
  }

  void removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(title: 'Notification', titleColor: Colors.cyan),
      bottomNavigationBar: _designService.navigationBar(context, 0, setState),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'Aucune notification',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.horizontal,
                  confirmDismiss: (direction) async {
                    if (notification['important']) {
                      bool? result = await _designService.dialogYesorNo(
                          context, 'Notification importante! \n Le supprimer?');
                      if (result != null) {
                        return result;
                      }
                    } else {
                      return true;
                    }
                  },
                  onDismissed: (direction) async {
                    removeNotification(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${notification['title']} supprimée.'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: Icon(
                      notification['read']
                          ? Icons.notifications
                          : Icons.notifications_active,
                      color: notification['read'] ? Colors.grey : Colors.cyan,
                    ),
                    title: Text(
                      notification['title'],
                      style: TextStyle(
                        fontWeight: notification['read']
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(notification['description']),
                    trailing: Text(
                      notification['date'],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    onTap: () {
                      if (!notification['read']) {
                        markAsRead(index);
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
