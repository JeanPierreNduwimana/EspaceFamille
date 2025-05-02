import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/widget_service.dart';

class EventsScheduleScreen extends StatefulWidget {
  const EventsScheduleScreen({super.key});

  @override
  State<EventsScheduleScreen> createState() => _EventsScheduleScreenState();
}

WidgetService _designService = WidgetService();
bool zoom = false;

class _EventsScheduleScreenState extends State<EventsScheduleScreen> {
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
      appBar: zoom
          ? null
          : _designService.appBar(context, 'Horaire', false, Colors.purple),
      body: buildBody(),
      bottomNavigationBar:
          zoom ? null : _designService.navigationBar(context, 4, setState),
      //drawer: const NavMenu(),
    );
  }

  Widget buildBody() {
    return Center(
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            zoom = !zoom;
          });
        },
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          minScale: 1.0, //minimum zoom scale
          maxScale: 4.0, //maximum zoom scale
          child: Image.asset(
            'assets/images/horaire.jpg',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
