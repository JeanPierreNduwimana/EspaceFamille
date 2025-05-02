import 'dart:io';
import 'package:espace_famille/utils/app_service.dart';
import 'package:espace_famille/utils/error_handling_service.dart';
import 'package:espace_famille/services/groceries_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../generated/l10n.dart';
import '../models/transfer_models.dart';
import '../utils/form_controllers.dart';

class GroceriesWidgets {
  GroceriesWidgets();

  File? imageToUpload;
  Image? uploadedImage;
  final _foodNameFormKey = GlobalKey<FormState>();

  void dialogAjoutAliment(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> foodItems = [
      {"name": "Pomme", "image": "assets/images/naruto.jpg", "quantity": 0},
      {"name": "Banane", "image": "assets/images/naruto.jpg", "quantity": 0},
      {"name": "Orange", "image": "assets/images/naruto.jpg", "quantity": 0},
    ];

    uploadedImage = null;
    FormController.nom_aliment_controller.text = '';
    FormController.descr_aliment_controller.text = '';
    FormController.quantite_aliment_controller.text = '';

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height *
                0.9, // prend 90% de la hauteur de l'appareil,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: DefaultTabController(
                        length: 2, // Nombre d'onglets
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize
                                .min, // Adapte la hauteur au contenu
                            children: [
                              // Onglets (TabBar)
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
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
                                        Form(
                                          key: _foodNameFormKey,
                                          child: TextFormField(
                                            controller: FormController
                                                .nom_aliment_controller,
                                            cursorColor: Colors.redAccent,
                                            keyboardType: TextInputType.name,
                                            maxLength: 16,
                                            decoration: InputDecoration(
                                                hintText:
                                                    S.of(context).labelFoodName,
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                  color: Colors
                                                      .cyan, // Change border color here
                                                  width: 2.0, // Border width
                                                ))),
                                            validator: (value) =>
                                                ErrorHandling().errorEmptyField(
                                                    FormController
                                                        .nom_aliment_controller
                                                        .text),
                                          ),
                                        ),
                                        TextField(
                                          controller: FormController
                                              .quantite_aliment_controller,
                                          cursorColor: Colors.redAccent,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(
                                              signed: false, decimal: false),
                                          maxLength: 2,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly, // Autorise uniquement les chiffres
                                          ],
                                          decoration: InputDecoration(
                                              hintText:
                                                  '${S.of(context).labelQuantityLong} ${S.of(context).labelOptionnal}',
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: Colors
                                                    .cyan, // Change border color here
                                                width: 2.0, // Border width
                                              ))),
                                        ),
                                        TextField(
                                          controller: FormController
                                              .descr_aliment_controller,
                                          cursorColor: Colors.redAccent,
                                          keyboardType: TextInputType.name,
                                          maxLength: 16,
                                          decoration: InputDecoration(
                                              hintText: S
                                                  .of(context)
                                                  .labelDescriptionOptional,
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: Colors
                                                    .cyan, // Change border color here
                                                width: 2.0, // Border width
                                              ))),
                                        ),
                                        uploadedImage != null
                                            ? Container(
                                                height: 120,
                                                width: 120,
                                                margin: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: uploadedImage!)
                                            : const SizedBox(),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.red,
                                                backgroundColor: Colors.white,
                                                elevation: 0,
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Colors.red
                                                        .withOpacity(0.2))),
                                            onPressed: () async {
                                              var result =
                                                  await AppService().getImage();
                                              if (result != null) {
                                                setState(() {
                                                  imageToUpload = result;
                                                  uploadedImage = Image.file(
                                                    result,
                                                    fit: BoxFit.cover,
                                                  );
                                                });
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                    Icons.upload_outlined),
                                                const SizedBox(width: 4),
                                                Text(S
                                                    .of(context)
                                                    .buttonUploadImage)
                                              ],
                                            )),
                                        uploadedImage != null
                                            ? ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.redAccent,
                                                    backgroundColor:
                                                        Colors.red.shade50),
                                                onPressed: () {
                                                  AppService()
                                                      .removeImage(setState);
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.delete_outlined),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(S
                                                        .of(context)
                                                        .buttonDeleteImage),
                                                  ],
                                                ))
                                            : const SizedBox(),
                                        const SizedBox(height: 12),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: Colors.red,
                                            ),
                                            onPressed: () async {
                                              addFoodButton(context);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.add),
                                                const SizedBox(width: 4),
                                                Text(S
                                                    .of(context)
                                                    .buttonAddFood),
                                              ],
                                            )),
                                      ],
                                    ),
                                    // Contenu pour l'onglet 2
                                    ListView.builder(
                                      itemCount: foodItems.length,
                                      itemBuilder: (context, index) {
                                        final food = foodItems[index];
                                        return Card(
                                          margin: const EdgeInsets.all(8),
                                          color: isDarkMode
                                              ? Colors.black26
                                              : null,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 24),
                                                    child: GestureDetector(
                                                        onTap: () {},
                                                        child: const Icon(
                                                            Icons
                                                                .delete_outlined,
                                                            color: Colors
                                                                .redAccent))),
                                                // Image de l'aliment
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 16, top: 4),
                                                        child: Text(
                                                          food['name'],
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                if (food[
                                                                        'quantity'] >
                                                                    0) {
                                                                  food[
                                                                      'quantity']--;
                                                                }
                                                              });
                                                            },
                                                            icon: const Icon(Icons
                                                                .remove_circle_outline),
                                                            color: Colors.grey,
                                                          ),
                                                          Text(
                                                            '${food['quantity']}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                food[
                                                                    'quantity']++;
                                                              });
                                                            },
                                                            icon: const Icon(Icons
                                                                .add_circle_outline),
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
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          '${food['name']} ajouté au panier!'),
                                                    ));
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    foregroundColor:
                                                        Colors.white,
                                                  ),
                                                  child: Text(
                                                      S.of(context).buttonAdd),
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
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 60,
                      color: Colors.grey.withOpacity(0.2),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.close,
                            color: Colors.black,
                          )
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
                        setState(() {
                          foodSaved = !foodSaved;
                        });
                      },
                      icon: Icon(
                          foodSaved ? Icons.bookmark : Icons.bookmark_outline,
                          color: Colors.cyan),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        });
      },
    );
  }

  void addFoodButton(BuildContext context) async {
    if (_foodNameFormKey.currentState!.validate()) {
      try {
        Member member = Member(DateTime.now(), 5, 'A1AU6adC6H9d3777lIO1',
            'KkWXYpXzoPYhKVfwmAn56duScUr2', '', '', '');
        Food food = Food(
            member.id,
            DateTime.now().toUtc(),
            FormController.descr_aliment_controller.text,
            '',
            '',
            false,
            FormController.nom_aliment_controller.text,
            int.parse(FormController.quantite_aliment_controller.text));
        if (uploadedImage != null) {
          await GroceriesService()
              .addFoodToGrocery(food, imageToUpload!, member, context);
        }
      } finally {
        Navigator.of(context).pop();
      }
    }
  }
}
