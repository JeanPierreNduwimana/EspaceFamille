import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../generated/l10n.dart';
import '../services/widget_service.dart';

WidgetService _designService = WidgetService();
bool test = false;
bool isloading = true;
TextEditingController _evaluationInstantaneController = TextEditingController();
class ListeEvaluation extends StatefulWidget {
  const ListeEvaluation({super.key});

  @override
  State<ListeEvaluation> createState() => _ListeEvaluationState();
}
double value = 3.0;
class _ListeEvaluationState extends State<ListeEvaluation> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp // Optional
    ]);
    loadPage();
  }

  void loadPage()async{
    await fetchData();
  }

  Future<void> fetchData() async {
    setState(() { isloading = true;});
    await Future.delayed(const Duration(seconds: 1));
    setState(() {isloading = false;});
  }
  Future<void> _onRefresh() async {
    await fetchData();
  }
  void _showFeedbackDialog() {
    _evaluationInstantaneController.text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(S.of(context).dialogQuickRatingTitle('JeanPierre')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RatingStars(
                    value: value,
                    onValueChanged: (v) {
                      //
                      setState(() {
                        value = v;
                      });
                    },
                    starBuilder: (index, color) => Icon(
                      Icons.star,
                      color: color,
                    ),
                    starCount: 5,
                    starSize: 20,
                    valueLabelColor: const Color(0xff9b9b9b),
                    valueLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                    valueLabelRadius: 10,
                    maxValue: 5,
                    starSpacing: 2,
                    maxValueVisibility: true,
                    valueLabelVisibility: true,
                    animationDuration: const Duration(milliseconds: 1000),
                    valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                    valueLabelMargin: const EdgeInsets.only(right: 8),
                    starOffColor: Colors.grey,
                    starColor: Colors.yellow.shade700,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _evaluationInstantaneController,
                    cursorColor: Colors.cyan,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: S.of(context).labelHintMessage,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.cyan,
                              width: 1.0
                          )
                      ),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).buttonCancel, style: const TextStyle(color: Colors.cyan)),
                ),
                TextButton(
                  onPressed: () {
                    // Logique pour envoyer le message (ici, on l'affiche dans la console)
                    _evaluationInstantaneController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).buttonSend, style: const TextStyle(color: Colors.cyan)),
                ),
              ],
            );
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar(context,S.of(context).evaluationProfilePageTitle('JeanPierre'), false,Colors.cyan),
      body: isloading ? _designService.shimmerListeEvaluation(context) : buildBody(),
      bottomNavigationBar: _designService.navigationBar(context, 2, setState),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isloading ? Colors.grey : Colors.cyan,
        foregroundColor: Colors.white,
        onPressed: (){
          // TODO: Ajouter un dialog qui permet de faire un commentaire instanté à un profil
          if(!isloading){
            _showFeedbackDialog();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: Colors.cyan,
      child: ListView.builder(
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            //au premier index on affiche les info du profil
            if(index == 0){
              return Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/cat_profile_img.jpg',
                          semanticLabel: 'Image du profil',
                          fit: BoxFit.cover,),
                      ),
                    ),
                    const SizedBox(height: 12),
                    //Text('Jean Pierre', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.cyan),),
                    _designService.getRatingStars(value, false),
                    const SizedBox(height: 12),
                  ],
                ),
              );
            }
            return Container( // Contient les element de chaque listtile
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      // Couleur de l'ombre avec opacité
                      spreadRadius: 2,
                      // Rayonnement de l'ombre
                      blurRadius: 2,
                      // Rayon du flou de l'ombre
                      offset: const Offset(1, 1), // Décalage horizontal et vertical de l'ombre
                    ),
                  ]),
              padding: const EdgeInsets.all(8),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/cat_profile_img.jpg',
                          semanticLabel: 'Image du profil',
                          fit: BoxFit.cover,),
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox(),),
                    Expanded(
                      flex: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nom de la personne', style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 2,),
                        _designService.getRatingStars(3, false),
                        const Column(
                          children: [
                            SizedBox(height: 10,),
                            Text('ce que je pense de ca ce que je pense de ca ce que je pense de ca ce que je pense de ca ce que je pense de ca ce que je pense de ca' ,
                              textAlign: TextAlign.left, style: TextStyle(color: Colors.black,),),
                          ],
                        ),
                      ],
                                ),
                    )]
                ),
              ),
            );
          }),
    );
  }
}
