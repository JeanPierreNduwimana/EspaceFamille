import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_services/widget_service.dart';

class Horaire extends StatefulWidget {
  const Horaire({super.key});

  @override
  State<Horaire> createState() => _HoraireState();
}
WidgetService _designService = WidgetService();
bool zoom = false;

class _HoraireState extends State<Horaire> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight, // Optional
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: zoom ? null : _designService.appBar(context,'Horaire', false,Colors.purple),
      body: buildBody(),
      bottomNavigationBar: zoom ? null : _designService.navigationBar(context, 4, setState),
      //drawer: const NavMenu(),
    );
  }

  Widget buildBody(){
    return Center(
      child: GestureDetector(
        onDoubleTap: (){
          setState(() {
            zoom = !zoom;
          });
        },
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          minScale: 1.0, //minimum zoom scale
          maxScale: 4.0, //maximum zoom scale
          child: Image.asset('assets/images/horaire.jpg', fit: BoxFit.contain,),
        ),
      ),
    );
  }
}
