import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../services/widget_service.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}
WidgetService _widgetService = WidgetService();

class _CreateEventState extends State<CreateEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _widgetService.appBar(context,S.of(context).homePageTitleEvents, false,Colors.purple),
      body: buildBody(),
      bottomNavigationBar: _widgetService.navigationBar(context, 4, setState),
    );
  }

  Widget buildBody() {
    return Center();
  }
}
