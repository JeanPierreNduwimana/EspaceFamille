import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../services/widget_service.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

final TextEditingController _controller = TextEditingController();
final List<String> _comments = [];
WidgetService _widgetService = WidgetService();

class _EventDetailsPageState extends State<EventDetailsPage> {
  final String title = 'Événement Spécial';
  final String date = '25 Février 2025';
  final String description = 'Ceci est une description détaillée de l\'événement. Rejoignez-nous pour une expérience inoubliable!';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {

    void _showCommentDelete(String comment) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(S.of(context).labelDeleteMyComment),
          content: Text(S.of(context).lebelDeleteMyCommentDescription),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.of(context).buttonCancel, style: TextStyle(color: Colors.purple)),
            ),
            TextButton(
              onPressed: (){
                setState(() {
                  _comments.remove(comment);
                });
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).labelDelete, style: TextStyle(color: Colors.purple)),
            ),
          ],
        ),
      );
    }

    Widget buildBody(){
      return Column(
        children: [
          Image.asset('assets/images/family_jump.jpg'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(date, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                GestureDetector(
                    onTap: (){
                      _showCommentDialog();
                    },
                    child: const Icon(Icons.maps_ugc_outlined, size: 32,))
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: (){
                      _showCommentDelete(_comments[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/cat_profile_img.jpg',
                                semanticLabel: 'Image du profil',
                                fit: BoxFit.cover,),
                            ),
                          ),
                          const SizedBox(width: 12),
                          _comments[index].length > 35 ? Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(_comments[index], style: const TextStyle(fontSize: 16, color: Colors.black)),
                                  Text('12/02/2015', textAlign: TextAlign.right,style: const TextStyle(fontSize: 12, color: Colors.black))
                                ],
                              ),
                            ),
                          ) : Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(_comments[index], style: const TextStyle(fontSize: 16, color: Colors.black)),
                                Text('12/02/2015', textAlign: TextAlign.left, style: const TextStyle(fontSize: 12, color: Colors.black))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
        ],
      );
    }

    return Scaffold(
      appBar: _widgetService.appBar(context,S.of(context).homePageTitleEvents, false,Colors.purple),
      body: buildBody(),
      bottomNavigationBar: _widgetService.navigationBar(context, 4, setState),
    );
  }

  void _addComment() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _comments.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _showCommentDialog() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).labelAddComment),
        content: SizedBox(
          height: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(S.of(context).labelCommentDescription),
              const SizedBox(height: 8),
              TextField(
                controller: _controller,
                maxLength: 145,
                cursorColor: Colors.purple,
                maxLines: 2,  // Makes the TextField multiline
                keyboardType: TextInputType.multiline,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: S.of(context).labelYourCommentHere,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.purple,
                          width: 1.0
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).buttonCancel, style: const TextStyle(color: Colors.purple)),
          ),
          TextButton(
            onPressed: (){
              _addComment();
              _controller.clear();
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).buttonSend, style: const TextStyle(color: Colors.purple)),
          ),
        ],
      ),
    );
  }

}
