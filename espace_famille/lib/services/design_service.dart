import 'dart:io';
import 'package:espace_famille/taches/details_tache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:image_picker/image_picker.dart';
import '../taches/model_tache.dart';

class DesignService {

  DesignService();

  final TextEditingController comment_controller = TextEditingController();
  final TextEditingController controllercommentRepondre = TextEditingController();
  final TextEditingController controllerContenuAnnonce = TextEditingController();
  ScrollController _scrollController = ScrollController();
  Image? uploadedImage;

/*
  PreferredSize appBar(String title){
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0), // Hauteur de l'AppBar
      child: AppBar(
        backgroundColor: Colors.cyan,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
*/
  AppBar appBar(String title){
    return AppBar(
      backgroundColor: Colors.cyan,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  Future<bool?> dialogYesorNo(BuildContext context, String message) async {

    return showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.cyan,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: Text('Oui', style: TextStyle(fontSize: 16)),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: Text('Non', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );


  }
  void dialogAfficherImage(BuildContext context, String image){
    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          
          child: Image.asset(image));
    });
  }
  void dialogEvaluerTacheDetailsProfile(bool visitor, BuildContext context, Tache t, double value){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 800,
                decoration: const BoxDecoration(
                  color: Colors.white, // Your desired background color
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0), // Same radius as the shape
                  ),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 24,),
                      visitor? const Text('Evaluer JeanPierre pour cette tache', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),) :
                      const Text('Informations sur ma tâche', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      const SizedBox(height: 24,),
                      Image.asset(t.img),
                      const SizedBox(height: 12,),
                      Text(t.descr),
                      Container( //Sous Taches
                        margin: t.sous_taches.isNotEmpty? const EdgeInsets.only(top: 12, bottom: 12) : const EdgeInsets.only(bottom: 24),
                        child: ListView.builder(shrinkWrap: true,itemCount: t.sous_taches.length, itemBuilder: (BuildContext context, int i){
                          return Text('\n• ${t.sous_taches[i]}');
                        }),
                      ),
                      (visitor?RatingStars(
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
                        starOffColor: const Color(0xffe7e8ea),
                        starColor: Colors.yellow,
                      ) : const SizedBox()),
                      (!visitor?Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(12),
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
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('À effectuer d\'ici'),
                                Text('En retard')
                              ],
                            ),
                            Row(
                              children: [
                                Text('5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32,),textAlign: TextAlign.end,),
                                Text('   Jours Restants',),
                                Expanded(child: Text('Jusqu\'au 25--302-24', textAlign: TextAlign.end,))
                              ],
                            ),
                          ],
                        ),
                      ) : const SizedBox()),
                      const SizedBox(height: 8),
                      (visitor? TextField(
                        controller: comment_controller,
                        keyboardType: TextInputType.text,
                        maxLength: 100,
                        maxLines: null,
                        minLines: 1,
                        decoration: const InputDecoration(
                            hintText: 'commentaire facultatif',
                            hintStyle: TextStyle(color: Colors.black38),
                            border: OutlineInputBorder(),
                        ),
                      ) : const SizedBox()),
                      (visitor?ElevatedButton(
                        child: value < 2.5? const Text('👎👎') : (value == 3? const Text('Meh 🥱') : (value == 4 ? const Text('Bravo 👏') : const Text('Bravo!! 😃'))),
                        onPressed: () => Navigator.pop(context),
                      ) :
                      Container(
                        margin: const EdgeInsets.only(left: 8,right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: (){
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DetailsTache(tache: t)));
                                      //Navigator.pop(context);
                                    },
                                    child: const Text('Consulter 🧐')),
                                ElevatedButton(onPressed: ()=> Navigator.pop(context), child: const Text('Compris! 👍'))
                              ],
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(onPressed: ()=> Navigator.pop(context), child: const Text('La tache est fait! 👌'),)
                          ],
                        ),
                      ))

                    ],),),),
            );},);},);
  }
  void dialogCreerAnnonce(BuildContext context, String editMessage, Image? currentImage){

    bool isEditMessage = editMessage != '';
    controllerContenuAnnonce.text = editMessage;
    currentImage != null ? uploadedImage = currentImage : uploadedImage = null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 800,
                decoration: const BoxDecoration(
                  color: Colors.white, // Your desired background color
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0), // Same radius as the shape
                  ),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:4, right: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: ((){
                                Navigator.pop(context);
                              }),
                              child: const Text('Annuler', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: isEditMessage ? Colors.orangeAccent : Colors.cyan,
                                    backgroundColor: isEditMessage ? Colors.orange.shade50 : Colors.cyan.shade50
                                ),
                                onPressed: (){
                                  if(controllerContenuAnnonce.text.trim() == ''){
                                    afficheMessage(context, 'Le champs ne peut pas être vide 😠');
                                  }
                                },
                                child: isEditMessage ? Icon(Icons.mode_edit_outlined) : Icon(Icons.send)),

                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/cat_profile_img.jpg',
                            semanticLabel: 'Image du profil',
                            fit: BoxFit.cover,),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        height: 200,
                        child: TextField(
                          controller: controllerContenuAnnonce,
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          expands: true,
                          maxLength: 200,
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'Quoi de neuf ?',
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.cyan, // Change border color here
                                width: 2.0, // Border width
                              ),
                            ),
                          ),

                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.cyan,
                            backgroundColor: Colors.cyan.shade50,
                          ),
                          onPressed: () async{
                            getImage(setState);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_outlined),
                              SizedBox(width: 4),
                              Text('Ajouter une image')
                            ],
                          )),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 200, width: 200,
                              child: uploadedImage != null? uploadedImage! : const SizedBox())
                        ],
                      )
                    ],
                  ),
                )),
            ); },);},);
  }
  void dialogCreerTache(BuildContext context){

    final TextEditingController controllerTaskName = TextEditingController();
    final TextEditingController controllerSubTaskName = TextEditingController();
    final List<String> taskTypeOptions = ['une fois', 'Quotidien', 'Hebdo', 'Annuelle', 'Periodique'];
    String? _selectedOption;
    List<String> subTaskAdded = [];
    bool periodique = false;
    int _selectedNumber = 2;
    String _selectedType = 'Day';
    bool subTask = false;
    uploadedImage = null;


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final List<int> _numbers = [2, 3, 4, 5, 6];
            final List<String> _types = ['Day', 'Week', 'Year'];
            return SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.9, // prend 90% de la hauteur de l'appareil,
                    decoration: const BoxDecoration(
                      color: Colors.white, // Your desired background color
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0), // Same radius as the shape
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:4, right: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: ((){
                                    Navigator.pop(context);
                                  }),
                                  child: const Text('Annuler', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                              ElevatedButton(
                                onPressed: () {
                                  controllerTaskName.text.trim() == '' ? afficheMessage(context, 'La description de la tâche ne peut être vide') : null;
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: Colors.cyan.shade400, // Color of the icon
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12), // Rounded corners
                                  ),
                                ),
                                child: const Text('Ajouter', style: TextStyle(fontWeight: FontWeight.bold),)
                              )

                            ],
                          ),
                        ),
                        TextField(
                          controller: controllerTaskName,
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          minLines: 1,
                          maxLength: 64,
                          decoration: const InputDecoration(
                            hintText: 'Quel est votre tâche?',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.cyan, // Change border color here
                                width: 2.0, // Border width
                              ),
                            ),
                          ),
                        ),
                        subTask ? Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                              child: Row(
                                children: [
                                  Text(
                                    'Ajouter des sous-tâches (${subTaskAdded.length}/3)',
                                    style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.cyan),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                      onTap: (){
                                        setState((){
                                          subTask = !subTask;
                                        });
                                        subTaskAdded = [];
                                      },
                                      child: const Icon(Icons.close, color: Colors.orangeAccent,))
                                ],
                              ),
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 200
                              ),
                              child: Container(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 18),
                                  child: ListView.builder(
                                      itemCount: subTaskAdded.length,
                                      shrinkWrap: true,
                                      controller: _scrollController,
                                      itemBuilder: (BuildContext context, int index){
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(flex: 4,child: Text(subTaskAdded[index])),
                                              Expanded(
                                                  flex: 1,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      setState((){
                                                        subTaskAdded.remove(subTaskAdded[index]);
                                                        controllerSubTaskName.text = '';
                                                      });
                                                    },
                                                    child: const Icon(Icons.close, size: 28)))
                                            ],
                                          ),
                                        )
                                        ;
                                      }),
                                ),
                              ),
                            ),
                            subTaskAdded.length < 3 ?
                            Container(
                              margin: const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: TextField(
                                      controller: controllerSubTaskName,
                                      keyboardType: TextInputType.text,
                                      minLines: 1,
                                      maxLength: 64,
                                      decoration: const InputDecoration(
                                          hintText: 'Quel est votre sous-tâche?',
                                          hintStyle: TextStyle(color: Colors.grey),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.cyan, // Change border color here
                                              width: 2.0, // Border width
                                            ),
                                          ),
                                      ),
                                    ),
                                  ),
                                  Expanded(flex: 1,
                                      child: GestureDetector(
                                          onTap: (){
                                            if(controllerSubTaskName.text.trim() == ''){
                                              afficheMessage(context, 'Sub-task name cannot be empty!');
                                              return;
                                            }
                                            setState((){subTaskAdded.add(controllerSubTaskName.text);});
                                            controllerSubTaskName.text = '';
                                            _scrollController.animateTo(
                                              _scrollController.position.maxScrollExtent, // Maximum scroll extent (bottom)
                                              duration: Duration(milliseconds: 300), // Animation duration
                                              curve: Curves.easeInOut, // Animation curve
                                            );
                                          },
                                          child: Icon(Icons.add, size: 32, color: Colors.cyan,)
                                      )
                                  )
                                ],
                              ),
                            ) : const SizedBox()
                          ],
                        ) :
                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(left:16,right: 16),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.cyan.shade400, backgroundColor: Colors.white,
                                ),
                                onPressed: (){
                              setState((){
                                subTask = !subTask;
                              });
                              },
                                child: const Text('Ajouter des sous-tâches')),
                          ),
                        Container(
                          margin: EdgeInsets.only(top: 12, bottom: 12),
                          child: const Text(
                            "Choisissez la recurrence:",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisExtent: 64,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: taskTypeOptions.length,
                              itemBuilder: (context, index){
                                return GestureDetector(
                                  onTap: ((){
                                    _selectedOption = taskTypeOptions[index];
                                    periodique = taskTypeOptions[index] == 'Periodique';
                                    setState((){});
                                  }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _selectedOption == taskTypeOptions[index]
                                          ? Colors.cyan.shade50
                                          : Colors.white,
                                      border: Border.all(
                                        color: _selectedOption == taskTypeOptions[index]
                                            ? Colors.cyan.shade200
                                            : Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Radio<String>(
                                          value: taskTypeOptions[index],
                                          groupValue: _selectedOption,
                                          activeColor: Colors.cyan,
                                          onChanged: (value){
                                            _selectedOption = value;
                                            periodique = taskTypeOptions[index] == 'Periodique';
                                            setState((){});
                                          },
                                        ),
                                        Expanded(
                                            child: Text(
                                              taskTypeOptions[index],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: _selectedOption == taskTypeOptions[index] ? Colors.cyan : Colors.black,
                                                fontWeight: _selectedOption == taskTypeOptions[index] ? FontWeight.bold : FontWeight.normal
                                              ),
                                              overflow: TextOverflow.ellipsis,))
                                      ],
                                      ),
                                  ),
                                )
                                ;
                              }),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            periodique ?
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Configurer la periodique',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton<int>(
                                          value: _selectedNumber,
                                          items: _numbers
                                              .map((number) => DropdownMenuItem<int>(
                                            value: number,
                                            child: Text(
                                              number.toString(),
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          ))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedNumber = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton<String>(
                                          value: _selectedType,
                                          items: _types
                                              .map((type) => DropdownMenuItem<String>(
                                            value: type,
                                            child: Text(
                                              type,
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          ))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedType = value!;
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                                :
                            const SizedBox(),
                            Column(
                              children: [
                                uploadedImage != null ?
                                Container(
                                    height:120, width:120,
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: uploadedImage!) : const SizedBox(),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.cyan,
                                        backgroundColor: Colors.cyan.shade50
                                    ),
                                    onPressed: (){
                                      getImage(setState);
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.upload_outlined),
                                        SizedBox(width: 5,),
                                        Text('Ajouter une image'),
                                      ],
                                    )),
                                uploadedImage != null ?
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.redAccent,
                                        backgroundColor: Colors.red.shade50
                                    ),
                                    onPressed: (){
                                      removeImage(setState);
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.delete_outlined),
                                        SizedBox(width: 5,),
                                        Text('Supprimer l\'image'),
                                      ],
                                    )) : const SizedBox(),

                              ],
                            )
                          ],
                        ),
                      ],
                    )),
              );
            },);},);
  }
  void dialogRepondreCommentaire(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permet de s'ajuster au clavier
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, // Ajustement pour le clavier
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ajuste la hauteur au contenu
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/cat_profile_img.jpg',
                                        semanticLabel: 'Image du profil',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Nom de la personne',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    '2024-04-03',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: const Text(
                                  'bl bablabl abla blabla b lab blablal abb al blablabl babalbl',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controllercommentRepondre,
                            maxLines: null,  // Makes the TextField multiline
                            keyboardType: TextInputType.multiline,
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: 'Votre réponse...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Action lorsque le bouton "Rep" est pressé
                            Navigator.pop(context);
                          },
                          child: const Text('Rep'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  RatingStars getRatingStars(double value, bool afficheValeur){
    return RatingStars(
      value: value,
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
      valueLabelVisibility: afficheValeur,
      animationDuration: const Duration(milliseconds: 1000),
      valueLabelPadding:
      const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      valueLabelMargin: const EdgeInsets.only(right: 8),
      starOffColor: const Color(0xffe7e8ea),
      starColor: Colors.yellow,
    );
  }
  //verification booléen de longueur maximale des description des tache
  String maximumString(String descrTache, int max){
    if(descrTache.length > max){
      String stringAEnvoyer = '';
      int index = 0;
      while(index < max){
        stringAEnvoyer += descrTache[index];
        index++;
      }
      return ('$stringAEnvoyer...');

    }else{
      return descrTache;
    }
  }
  void afficheMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set background color to white
          title: const Text(
            'Erreur',
            style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold), // Cyan text color for title
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.black), // Cyan text color for the message
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.cyan), // Cyan text color for the button
              ),
            ),
          ],
        );
      },
    );
  }
  void getImage(StateSetter setState) async{
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    String? imagePath = pickedImage!.path;

    if(imagePath != ""){
      uploadedImage = Image.file(File(imagePath),fit: BoxFit.cover,);
      setState((){});
    }
  }

  void removeImage(StateSetter setState){
    uploadedImage = null;
    setState((){});
  }

}

