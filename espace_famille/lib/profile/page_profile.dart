import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profile'),
        backgroundColor: Colors.cyan,
      ),

      body: const Center(
        child: Text('La page Main Profile marche'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        tooltip: 'justunbouton',
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, '/accfam');
        },
      ),
    );
  }
}
