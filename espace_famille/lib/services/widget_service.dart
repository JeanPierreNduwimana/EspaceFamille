import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import '../taches/model_tache.dart';

class WidgetService {

  WidgetService();

  final TextEditingController comment_controller = TextEditingController();
  final TextEditingController controllercommentRepondre = TextEditingController();
  final TextEditingController controllerContenuAnnonce = TextEditingController();
  final TextEditingController nom_aliment_controller = TextEditingController();
  final TextEditingController descr_aliment_controller = TextEditingController();
  final TextEditingController quantite_aliment_controller = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  Image? uploadedImage;
  int currentPage = -1;
  bool orgExist = true;

  AppBar appBar(BuildContext context,String title, bool onProfilePage){
    return AppBar(
      leading: null,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Text(
            title,
            style: const TextStyle(
              color: Colors.cyan,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                onProfilePage ? const SizedBox() : GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/app_options');
                  },
                  child: SizedBox(
                    height: 32,
                    width: 32,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/cat_profile_img.jpg',
                        semanticLabel: 'Image du profil',
                        fit: BoxFit.cover,),
                    ),
                  ),
                )
              ],
            ),
          )

        ],
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
                  offset: const Offset(0, 5),
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
                const SizedBox(height: 20),
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
                      child: const Text('Oui', style: TextStyle(fontSize: 16)),
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
                      child: const Text('Non', style: TextStyle(fontSize: 16)),
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
  Future<bool?> dialogJoinorCreatFam(BuildContext context) async {

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
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Column(
                  children: [
                    Text(
                      'Votre compte n\'est pas associé à une famille',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Veuillez joindre ou créer la votre.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.cyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Joindre', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.cyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Créer', style: TextStyle(fontSize: 16)),
                      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: const Text('Annuler', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          ),
                          visitor? const Text('Evaluer JeanPierre', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),) :
                          const Text('Détails sur ma tâche', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  foregroundColor: Colors.white,
                              ),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok')),
                        ]
                      ),
                      const SizedBox(height: 24,),
                      Image.asset(t.img),
                      const SizedBox(height: 12,),
                      Text(t.descr, style: const TextStyle(fontWeight: FontWeight.bold),),
                      Container( //Sous Taches
                        margin: t.sous_taches.isNotEmpty? const EdgeInsets.only(top: 12, bottom: 12) : const EdgeInsets.only(bottom: 24),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: t.sous_taches.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int i){
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_circle, color: Colors.grey,size: 16),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        t.sous_taches[i],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                          //return Text('\n• ${t.sous_taches[i]}');
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
                        starColor: Colors.yellow.shade700,
                      ) : const SizedBox()),
                      (!visitor?Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
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
                            ]
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'À effectuer d\'ici',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  'En retard',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Text(
                                  '5',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36,
                                    color: Colors.cyan, // Accentuation avec Cyan
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Jours Restants',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Jusqu\'au 25-02-2024',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
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
                        margin: const EdgeInsets.only(left: 8,right: 8, top:8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.red,
                                  side: BorderSide(
                                      color: Colors.red.withOpacity(0.2)
                                  ),
                                elevation: 0
                              ),
                              onPressed: ()=> Navigator.pop(context),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Abandonner'),
                                  SizedBox(width: 8),
                                  Icon(Icons.dangerous)
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.purple,
                                side: BorderSide(
                                  color: Colors.purple.withOpacity(0.5)
                                ),
                                elevation: 0
                              ),
                              onPressed: () async {
                                if(orgExist){
                                  dialogTransferTache(context);
                                }else{
                                  bool? result = await dialogJoinorCreatFam(context);
                                  if(result != null){
                                    if(result){
                                      dialogJoinOrganizationDialog(context);
                                    }else{
                                      dialogCreateOrganizationDialog(context);
                                    }
                                  }
                                }

                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Tranferer'),
                                  SizedBox(width: 12),
                                  Icon(Icons.compare_arrows)
                                ],
                              ),),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white
                              ),
                              onPressed: ()=> Navigator.pop(context), child: const Text('La tache est fait! 👌'),)
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
                                child: isEditMessage ? const Icon(Icons.mode_edit_outlined) : const Icon(Icons.send)),

                          ],
                        ),
                      ),
                      SizedBox(
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
                           Image? result = await getImage();
                           if(result != null){
                             setState((){
                               uploadedImage = result;
                             });
                           }
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_outlined),
                              SizedBox(width: 4),
                              Text('Ajouter une image')
                            ],
                          )),
                      const SizedBox(height: 12),
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
                                              duration: const Duration(milliseconds: 300), // Animation duration
                                              curve: Curves.easeInOut, // Animation curve
                                            );
                                          },
                                          child: const Icon(Icons.add, size: 32, color: Colors.cyan,)
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
                          margin: const EdgeInsets.only(top: 12, bottom: 12),
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
                                    onPressed: ()async{
                                      Image? result = await getImage();
                                      if(result != null){
                                        setState((){
                                          uploadedImage = result;
                                        });
                                      }
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
                                  SizedBox(
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
        color: Colors.yellow.shade700,
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
            style: const TextStyle(color: Colors.black), // Cyan text color for the message
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
  Future<Image?> getImage() async{
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    String? imagePath = pickedImage!.path;

    if(imagePath != ""){
      return Image.file(File(imagePath),fit: BoxFit.cover,);
    }

    return null;
  }
  void removeImage(StateSetter setState){
    uploadedImage = null;
    setState((){});
  }
  void dialogTransferTache(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          int selectedIndex = -1;
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 300,
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 18, bottom: 8),
                            child: const Text('À qui voulez-vous transferer cette tâche?', style: TextStyle(fontWeight: FontWeight.bold),)),
                        Expanded(
                          flex: 3,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 7,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index){
                                return GestureDetector(
                                  onTap: (){
                                    setState((){
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    child: Stack(
                                      fit: StackFit.loose,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          height: 80,
                                          width: 80,
                                          margin: const EdgeInsets.only(top: 20),
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/images/cat_profile_img.jpg',
                                              semanticLabel: 'Image du profil',
                                              fit: BoxFit.cover,),
                                          ),
                                        ),
                                        Container(
                                          color: selectedIndex == index ? Colors.purple : null,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(12),
                                                height: 80,
                                                width: 80,
                                                margin: const EdgeInsets.only(top: 20),
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    'assets/images/cat_profile_img.jpg',
                                                    semanticLabel: 'Image du profil',
                                                    fit: BoxFit.cover,),
                                                ),
                                              ),
                                              //const SizedBox(height: 4),
                                              Text('Jean Pierre', textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color:  selectedIndex == index ? Colors.white : Colors.black,
                                                ),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        selectedIndex != -1 ? const Expanded(flex: 1, child: Align(alignment: Alignment.center,child: Text('Transferer à Jean Pierre', style: TextStyle(fontWeight: FontWeight.bold)))) : const Expanded(child: SizedBox()),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12,left: 16, right: 16),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: selectedIndex == -1 ? Colors.grey : Colors.purple,
                                foregroundColor: Colors.white
                            ),
                            onPressed: (){
                              if(selectedIndex != -1){
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('Transferer'),
                          ),
                        )

                      ],
                    );
                  }

                ),
              )
          );
        },
    );
  }
  void dialogAjoutAliment(BuildContext context){

    final List<Map<String, dynamic>> foodItems = [
      {"name": "Pomme", "image": "assets/images/naruto.jpg", "quantity": 0},
      {"name": "Banane", "image": "assets/images/naruto.jpg", "quantity": 0},
      {"name": "Orange", "image": "assets/images/naruto.jpg", "quantity": 0},
    ];

    uploadedImage = null;
    nom_aliment_controller.text = '';
    descr_aliment_controller.text = '';
    quantite_aliment_controller.text = '';

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context){
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9, // prend 90% de la hauteur de l'appareil,
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: DefaultTabController(
                        length: 2, // Nombre d'onglets
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Adapte la hauteur au contenu
                            children: [
                              // Onglets (TabBar)
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                                child: const TabBar(
                                  labelColor: Colors.redAccent,
                                  unselectedLabelColor: Colors.grey,
                                  indicatorColor: Colors.redAccent,
                                  tabs: [
                                    Tab(icon: Icon(Icons.add)),
                                    Tab(icon: Icon(Icons.tips_and_updates)),
                                  ],
                                ),
                              ),

                              // Contenu des onglets (TabBarView)
                              SizedBox(
                                height: 600, // Hauteur du contenu
                                child: TabBarView(
                                  children: [
                                    // Contenu pour l'onglet 1
                                    Column(
                                      children: [
                                        TextField(
                                          controller: nom_aliment_controller,
                                          keyboardType: TextInputType.name,
                                          maxLength: 16,
                                          decoration:  const InputDecoration(
                                              hintText:'Nom de l\'aliment',
                                              hintStyle: TextStyle(color: Colors.black38),
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.cyan, // Change border color here
                                                    width: 2.0, // Border width
                                                  )
                                              )
                                          ),
                                        ),
                                        TextField(
                                          controller: quantite_aliment_controller,
                                          keyboardType: TextInputType.number,
                                          maxLength: 2,
                                          decoration:  const InputDecoration(
                                              hintText:'Quantité',
                                              hintStyle: TextStyle(color: Colors.black38),
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.cyan, // Change border color here
                                                    width: 2.0, // Border width
                                                  )
                                              )
                                          ),
                                        ),
                                        TextField(
                                          controller: descr_aliment_controller,
                                          keyboardType: TextInputType.name,
                                          maxLength: 16,
                                          decoration:  const InputDecoration(
                                              hintText:'Description (facultatif)',
                                              hintStyle: TextStyle(color: Colors.black38),
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.cyan, // Change border color here
                                                    width: 2.0, // Border width
                                                  )
                                              )
                                          ),
                                        ),
                                        uploadedImage != null ?
                                        Container(
                                            height:120, width:120,
                                            margin: const EdgeInsets.only(bottom: 8),
                                            child: uploadedImage!) : const SizedBox(),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.red,
                                              backgroundColor: Colors.white,
                                              elevation: 0,
                                              side: BorderSide(
                                                width: 1,
                                                color: Colors.red.withOpacity(0.2)
                                              )
                                            ),
                                            onPressed: () async{
                                              Image? result = await getImage();
                                              if(result != null){
                                                setState((){
                                                  uploadedImage = result;
                                                });
                                              }
                                            },
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.upload_outlined),
                                                SizedBox(width: 4),
                                                Text('Ajouter une image')
                                              ],
                                            )
                                        ),
                                        const SizedBox(height: 12),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: Colors.red,
                                            ),
                                            onPressed: () async{
                                              Navigator.of(context).pop();
                                            },
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add),
                                                SizedBox(width: 4),
                                                Text('Ajouter l\'aliment'),
                                              ],
                                            )
                                        ),


                                      ],
                                    ),
                                    // Contenu pour l'onglet 2
                                    ListView.builder(
                                        itemCount: foodItems.length,
                                        itemBuilder: (context, index) {

                                          final food = foodItems[index];
                                          return Card(
                                            margin: const EdgeInsets.all(8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(right: 24),
                                                    child: GestureDetector(
                                                        onTap: (){

                                                        },
                                                        child: const Icon(Icons.delete_outlined, color: Colors.redAccent))),
                                                  // Image de l'aliment
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child: Image.asset(
                                                      food['image'],
                                                      height: 60,
                                                      width: 60,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  // Nom et contrôle de quantité
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          margin : const EdgeInsets.only(left: 16,top: 4),
                                                          child: Text(
                                                            food['name'],
                                                            style: const TextStyle(
                                                                fontWeight: FontWeight.bold, fontSize: 18),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  if (food['quantity'] > 0) {
                                                                    food['quantity']--;
                                                                  }
                                                                });
                                                              },
                                                              icon: const Icon(Icons.remove_circle_outline),
                                                              color: Colors.grey,
                                                            ),
                                                            Text(
                                                              '${food['quantity']}',
                                                              style: const TextStyle(fontSize: 16),
                                                            ),
                                                            IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  food['quantity']++;
                                                                });
                                                              },
                                                              icon: const Icon(Icons.add_circle_outline),
                                                              color: Colors.green,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  // Bouton d'ajout
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // Action à exécuter lors de l'ajout
                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                        content: Text('${food['name']} ajouté au panier!'),
                                                      ));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.redAccent,
                                                      foregroundColor: Colors.white,
                                                    ),
                                                    child: const Text('Ajouter'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 60,
                      color: Colors.grey.withOpacity(0.2),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close, color: Colors.black,)
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      );
    });

  }
  BottomNavigationBar navigationBar(BuildContext context, int _selectedIndex, StateSetter setState){
    currentPage = _selectedIndex;
    return BottomNavigationBar(
      currentIndex: _selectedIndex, // Ajout pour suivre l'onglet actif
      onTap: (index) {
        setState(() {
          _selectedIndex = index; // Met à jour l'onglet actif
        });

        switch(index){
          case 0 :
          //Navigation vers Espace
            Navigator.pushNamed(context, '/acceuil');
            break;
          case 1 :
          //Navigation vers Épicerie
            Navigator.pushNamed(context, '/liste_epicerie');
            break;
          case 2 :
          //Navigation vers Acceuil
            Navigator.pushNamed(context, '/accfam');
            break;
          case 3 :
          //Navigation vers Taches
            Navigator.pushNamed(context, '/listetaches');
            break;
          case 4 :
          //Navigation vers Evenements
            Navigator.pushNamed(context, '/events');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined), // Icône représentative pour Accueil
          activeIcon: Icon(Icons.dashboard,color: Colors.cyan), // Icône pour l'état actif
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined), // Icône représentative pour Accueil
          activeIcon: Icon(Icons.shopping_cart, color: Colors.redAccent), // Icône pour l'état actif
          label: 'Épicerie',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_outlined), // Icône plus moderne pour un espace famille
          activeIcon: Icon(Icons.people_alt, color: Colors.cyan,), // Icône pour l'état actif
          label: 'Espace',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task_alt_outlined), // Icône plus moderne pour Profil
          activeIcon: Icon(Icons.task_alt, color: Colors.green), // Icône pour l'état actif
          label: 'Taches',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined), // Icône plus moderne pour Profil
          activeIcon: Icon(Icons.calendar_month, color: Colors.purple), // Icône pour l'état actif
          label: 'Evenements',
        ),
      ],
      selectedItemColor: (
          _selectedIndex == 0 ? Colors.cyan
              : _selectedIndex == 1 ? Colors.redAccent
              : _selectedIndex == 2 ? Colors.cyan
              : _selectedIndex == 3 ? Colors.green
              : Colors.purple),
      // Couleur des icônes actives
      unselectedItemColor: Colors.grey, // Couleur des icônes inactives
      type: BottomNavigationBarType.fixed, // Assure un comportement stable
      elevation: 8, // Ajoute une ombre pour un meilleur visuel
    );
  }

  void dialogDetailAliment(BuildContext context) {
    bool foodSaved = false;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
           return Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
             child: Column(
               mainAxisSize: MainAxisSize.min,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Center(
                   child: Container(
                     width: 50,
                     height: 5,
                     decoration: BoxDecoration(
                       color: Colors.grey[300],
                       borderRadius: BorderRadius.circular(10),
                     ),
                   ),
                 ),
                 const SizedBox(height: 16),
                 const Text(
                   'Banane',
                   style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 const SizedBox(height: 8),
                 const Text(
                   'Ceci est une description de la banane',
                   style: TextStyle(
                     fontSize: 16,
                     color: Colors.grey,
                   ),
                 ),
                 const SizedBox(height: 16),
                 Center(
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(16),
                     child: Image.asset(
                       'assets/images/naruto.jpg',
                       height: 80,
                       width: 80,
                       fit: BoxFit.cover,
                     ),
                   ),
                 ),
                 const SizedBox(height: 16),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const Text(
                       'Quantité: 5',
                       style: TextStyle(fontSize: 16),
                     ),
                     IconButton(
                       onPressed: () {
                         setState((){
                           foodSaved = !foodSaved;
                         });
                       },
                       icon: Icon( foodSaved? Icons.bookmark : Icons.bookmark_outline, color: Colors.cyan),
                     ),
                   ],
                 ),
                 const SizedBox(height: 16),
               ],
             ),
           );
          }
        );
      },
    );
  }

  // Dialog to create an organization
  void dialogCreateOrganizationDialog(BuildContext context) {
    final TextEditingController orgNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Create Organization',
            style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: orgNameController,
            cursorColor: Colors.cyan,
            decoration: InputDecoration(
              labelText: 'Organization Name',
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.cyan, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
              ),
              onPressed: () {
                String organizationName = orgNameController.text.trim();
                if (organizationName.isNotEmpty) {
                  // Handle organization creation logic here
                  print('Organization Created: $organizationName');
                  Navigator.pop(context);
                }
              },
              child: const Text('Create', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Dialog to join an organization using a code
  void dialogJoinOrganizationDialog(BuildContext context) {
    final TextEditingController orgCodeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Join Organization',style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: orgCodeController,
            cursorColor: Colors.cyan,
            decoration: InputDecoration(
              labelText: 'Enter Code',
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.cyan, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white
              ),
              onPressed: () {
                String organizationCode = orgCodeController.text.trim();
                if (organizationCode.isNotEmpty) {
                  // Handle joining organization logic here
                  print('Joined Organization with Code: $organizationCode');
                  Navigator.pop(context);
                }
              },
              child: const Text('Join'),
            ),
          ],
        );
      },
    );
  }

  Widget shimmerAcceuil() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Exemple de titre shimmer
              Container(
                margin: const EdgeInsets.only(top: 32, bottom: 4),
                height: 28,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              // Exemple de bloc shimmer
              Container(
                height: 400,
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[300],
                ),
              ),
              // Un autre titre shimmer
              Container(
                margin: const EdgeInsets.only(top: 32, bottom: 16),
                height: 28,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              // Deux colonnes shimmer
              SizedBox(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Exemple d'une autre section shimmer
              Container(
                height: 200,
                margin: const EdgeInsets.only(top: 32, bottom: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerEspaceFamille(){
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context,index){
          return Container(
            height: 200,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          );

        },
      ),
    );
  }
  Widget shimmerCommentairesAnnonce(){
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        children: [
          Container(
          height: 200,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              ),
            ),
          )

        ],
      ),
    );
  }
  Widget shimmerEpiceire(){
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context,index){

          return index == 0 ?
          const SizedBox(
            height: 210,
          ) : Container(
                height: 90,
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              );

        },
      ),
    );
  }
  Widget shimmerTaches(){
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context,index){

          return index == 0 ?
          const SizedBox(
            height: 210,
          ) : Container(
            height: 150,
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          );

        },
      ),
    );
  }
  Widget shimmerProfil(){
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context,index){

          return index == 0 ?
          Container(
            height: 240,
            margin: const EdgeInsets.only(top: 24,left: 8,right: 8,bottom: 40),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ) : Container(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          );

        },
      ),
    );
  }
  Widget shimmerListeEvaluation(){
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context,index){

          return index == 0 ?
          const SizedBox(
            height: 180,
          ) : Container(
            height: 150,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          );

        },
      ),
    );
  }
}