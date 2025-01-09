import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../nav_menu.dart';
import '../services/design_service.dart';

class ListeEpicerie extends StatefulWidget {
  const ListeEpicerie({super.key});

  @override
  State<ListeEpicerie> createState() => _ListeEpicerieState();
}
DesignService _designService = DesignService();

class _ListeEpicerieState extends State<ListeEpicerie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar('Gestion d\'epicerie'),
      body: buildBody(),
      drawer: const NavMenu(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan.shade400,
        foregroundColor: Colors.white,
        onPressed: (){
          //dialog d'ajout d'un aliment
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody(){
    return Center();
  }
}
