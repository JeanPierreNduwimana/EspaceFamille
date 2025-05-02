import 'package:espace_famille/models/transfer_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:shimmer/shimmer.dart';
import '../generated/l10n.dart';
import '../utils/form_controllers.dart';
import '../utils/app_service.dart';

/*  CECI UNE CLASS QUI RETOURNE PLUSIEURS WIDGETS À TRAVERS DES METHODES. EX: AppBar, Dialog, etc... */

class WidgetService {
  WidgetService();

  final ScrollController _scrollController = ScrollController();
  final AppService _appService = AppService();
  Image? uploadedImage;
  int currentPage = -1;
  bool orgExist = true;

  //region Widget utilisé pour la navigation en bas de l'écran
  BottomNavigationBar navigationBar(
      BuildContext context, int _selectedIndex, StateSetter setState) {
    currentPage = _selectedIndex;

    // Méthode qui vérifie si l'utilisateur se trouve à la meme page
    bool onTheSamePage(String pageName) {
      // Obtenir le nom de la route actuelle
      final currentRoute = ModalRoute.of(context)?.settings.name;
      // Vérifier si vous êtes déjà sur la page '/acceuil'
      if (currentRoute != pageName) {
        return false; // on est pas sur la même page
      } else {
        return true; // on est sur la meme page
      }
    }

    // Retour du Widget
    return BottomNavigationBar(
      currentIndex: _selectedIndex, // Ajout pour suivre l'onglet actif
      onTap: (index) {
        setState(() {
          _selectedIndex = index; // Met à jour l'onglet actif
        });

        switch (index) {
          case 0:
            //Navigation vers Espace
            if (!onTheSamePage('/acceuil')) {
              Navigator.pushNamed(context, '/acceuil');
            }
            break;
          case 1:
            //Navigation vers Épicerie
            if (!onTheSamePage('/liste_epicerie')) {
              Navigator.pushNamed(context, '/liste_epicerie');
            }
            break;
          case 2:
            //Navigation vers Acceuil
            if (!onTheSamePage('/accfam')) {
              Navigator.pushNamed(context, '/accfam');
            }
            break;
          case 3:
            //Navigation vers Taches
            if (!onTheSamePage('/listetaches')) {
              Navigator.pushNamed(context, '/listetaches');
            }
            break;
          case 4:
            //Navigation vers Evenements
            if (!onTheSamePage('/events_list')) {
              Navigator.pushNamed(context, '/events_list');
            }
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(
              Icons.dashboard_outlined), // Icône représentative pour Accueil
          activeIcon: const Icon(Icons.dashboard,
              color: Colors.cyan), // Icône pour l'état actif
          label: S.of(context).bottomNavHome,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons
              .shopping_cart_outlined), // Icône représentative pour Accueil
          activeIcon: const Icon(Icons.shopping_cart,
              color: Colors.redAccent), // Icône pour l'état actif
          label: S.of(context).appBarGroceriePageTitle,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons
              .people_alt_outlined), // Icône plus moderne pour un espace famille
          activeIcon: const Icon(
            Icons.people_alt,
            color: Colors.cyan,
          ), // Icône pour l'état actif
          label: S.of(context).bottomNavSpaceFamily,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
              Icons.task_alt_outlined), // Icône plus moderne pour Profil
          activeIcon: const Icon(Icons.task_alt,
              color: Colors.green), // Icône pour l'état actif
          label: S.of(context).homePageTitleTask,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
              Icons.calendar_month_outlined), // Icône plus moderne pour Profil
          activeIcon: const Icon(Icons.calendar_month,
              color: Colors.purple), // Icône pour l'état actif
          label: S.of(context).homePageTitleEvents,
        ),
      ],
      selectedItemColor: (_selectedIndex == 0
          ? Colors.cyan
          : _selectedIndex == 1
              ? Colors.redAccent
              : _selectedIndex == 2
                  ? Colors.cyan
                  : _selectedIndex == 3
                      ? Colors.green
                      : Colors.purple),
      // Couleur des icônes actives
      unselectedItemColor: Colors.grey, // Couleur des icônes inactives
      type: BottomNavigationBarType.fixed, // Assure un comportement stable
      elevation: 8, // Ajoute une ombre pour un meilleur visuel
    );
  }
  //endregion

  // ce dialog sert à afficher n'importe quel image en grand.
  void dialogAfficherImage(BuildContext context, String image) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(image));
        });
  }

  void dialogEvaluerTacheDetailsProfile(
      bool visitor, BuildContext context, Tache t, double value) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                decoration: BoxDecoration(
                  color: !isDarkMode
                      ? Colors.white
                      : null, // Your desired background color
                  borderRadius: const BorderRadius.vertical(
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
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                S.of(context).buttonCancel,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            visitor
                                ? Text(
                                    S
                                        .of(context)
                                        .dialogRatingTitle('Jean Pierre'),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                : Text(S.of(context).dialogTaskDetailTitle,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok')),
                          ]),
                      const SizedBox(
                        height: 24,
                      ),
                      Image.asset(t.img),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        t.descr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        //Sous Taches
                        margin: t.sous_taches.isNotEmpty
                            ? const EdgeInsets.only(top: 12, bottom: 12)
                            : const EdgeInsets.only(bottom: 24),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: t.sous_taches.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int i) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_circle,
                                        color: Colors.grey, size: 16),
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
                      (visitor
                          ? RatingStars(
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
                              animationDuration:
                                  const Duration(milliseconds: 1000),
                              valueLabelPadding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 8),
                              valueLabelMargin: const EdgeInsets.only(right: 8),
                              starOffColor: const Color(0xffe7e8ea),
                              starColor: Colors.yellow.shade700,
                            )
                          : const SizedBox()),
                      (!visitor
                          ? Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.black26
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: !isDarkMode
                                      ? Border.all(
                                          color: Colors.grey.shade300, width: 1)
                                      : null,
                                  boxShadow: !isDarkMode
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(1,
                                                1), // Décalage horizontal et vertical de l'ombre
                                          ),
                                        ]
                                      : null),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        S.of(context).labelToBeDoneBy,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isDarkMode
                                              ? Colors.grey.shade300
                                              : Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        S.of(context).labelTaksLate,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const Text(
                                        '5',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 36,
                                          color: Colors
                                              .cyan, // Accentuation avec Cyan
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        S.of(context).labelDay,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: isDarkMode
                                              ? Colors.grey.shade300
                                              : Colors.black87,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Jusqu\'au 25-02-2024',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: isDarkMode
                                                ? Colors.grey.shade300
                                                : Colors.black54,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox()),
                      const SizedBox(height: 8),
                      (visitor
                          ? TextField(
                              controller: FormController.comment_controller,
                              keyboardType: TextInputType.text,
                              maxLength: 100,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                hintText: S.of(context).labelOptionalComment,
                                border: const OutlineInputBorder(),
                              ),
                            )
                          : const SizedBox()),
                      (visitor
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      isDarkMode ? Colors.black45 : null),
                              child: value < 2.5
                                  ? const Text('👎👎')
                                  : (value == 3
                                      ? const Text('Meh 🥱')
                                      : (value == 4
                                          ? Text(
                                              '${S.of(context).labelBravo} 👏')
                                          : Text(
                                              '${S.of(context).labelBravo}!! 😃'))),
                              onPressed: () => Navigator.pop(context),
                            )
                          : Container(
                              margin: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: isDarkMode
                                            ? Colors.black38
                                            : Colors.white,
                                        foregroundColor: Colors.red,
                                        side: !isDarkMode
                                            ? BorderSide(
                                                color:
                                                    Colors.red.withOpacity(0.2))
                                            : null,
                                        elevation: 0),
                                    onPressed: () => Navigator.pop(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(S.of(context).labelTaskGiveUp),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.dangerous)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: isDarkMode
                                            ? Colors.black38
                                            : Colors.white,
                                        foregroundColor: Colors.purple,
                                        side: !isDarkMode
                                            ? BorderSide(
                                                color: Colors.purple
                                                    .withOpacity(0.5))
                                            : null,
                                        elevation: 0),
                                    onPressed: () async {
                                      if (orgExist) {
                                        dialogTransferTache(context);
                                      } else {
                                        bool? result =
                                            await dialogJoinorCreatFam(context);
                                        if (result != null) {
                                          if (result) {
                                            dialogJoinOrganizationDialog(
                                                context);
                                          } else {
                                            dialogCreateOrganizationDialog(
                                                context);
                                          }
                                        }
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(S.of(context).buttonTaskTransfer),
                                        const SizedBox(width: 12),
                                        const Icon(Icons.compare_arrows)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: isDarkMode
                                            ? Colors.green.shade800
                                            : Colors.green,
                                        foregroundColor: Colors.white),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(S.of(context).buttonTaskDone),
                                  )
                                ],
                              ),
                            ))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void dialogCreerAnnonce(
      BuildContext context, String editMessage, Image? currentImage) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    bool isEditMessage = editMessage != '';
    FormController.controllerContenuAnnonce.text = editMessage;
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
                  decoration: BoxDecoration(
                    color: !isDarkMode
                        ? Colors.white
                        : null, // Your desired background color
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20.0), // Same radius as the shape
                    ),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: Text(
                                    S.of(context).buttonCancel,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: isEditMessage
                                          ? Colors.orangeAccent
                                          : Colors.cyan,
                                      backgroundColor: isEditMessage
                                          ? Colors.orange.shade50
                                          : Colors.cyan.shade50),
                                  onPressed: () {
                                    if (FormController
                                            .controllerContenuAnnonce.text
                                            .trim() ==
                                        '') {
                                      afficheMessage(context,
                                          S.of(context).labelErrorFieldEmpty);
                                    }
                                  },
                                  child: isEditMessage
                                      ? const Icon(Icons.mode_edit_outlined)
                                      : const Icon(Icons.send)),
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
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          height: 200,
                          child: TextField(
                            controller: FormController.controllerContenuAnnonce,
                            cursorColor: Colors.cyan,
                            maxLines: null,
                            keyboardType: TextInputType.text,
                            expands: true,
                            maxLength: 200,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: S.of(context).labelHintWhatsUp,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Colors.cyan, // Change border color here
                                  width: 2.0, // Border width
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.cyan,
                              backgroundColor: isDarkMode
                                  ? Colors.black
                                  : Colors.cyan.shade50,
                            ),
                            onPressed: () async {
                              var result = await _appService.getImage();
                              if (result != null) {
                                setState(() {
                                  uploadedImage = Image.file(
                                    result,
                                    fit: BoxFit.cover,
                                  );
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.upload_outlined),
                                const SizedBox(width: 4),
                                Text(S.of(context).buttonUploadImage)
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 12),
                                height: 200,
                                width: 200,
                                child: uploadedImage != null
                                    ? uploadedImage!
                                    : const SizedBox())
                          ],
                        ),
                        uploadedImage != null
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.redAccent,
                                    backgroundColor: Colors.red.shade50),
                                onPressed: () {
                                  _appService.removeImage(setState);
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.delete_outlined),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(S.of(context).buttonDeleteImage),
                                  ],
                                ))
                            : const SizedBox(),
                      ],
                    ),
                  )),
            );
          },
        );
      },
    );
  }

  void dialogCreateEvent(BuildContext context) {
    clearController();
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                  decoration: BoxDecoration(
                    color: !isDarkMode
                        ? Colors.white
                        : null, // Your desired background color
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20.0), // Same radius as the shape
                    ),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: (() {
                                    FormController.controllerTitleEvent.clear();
                                    FormController.controllerDateEvent.clear();
                                    FormController.controllerDescriptionEvent
                                        .clear();
                                    Navigator.pop(context);
                                  }),
                                  child: Text(S.of(context).buttonCancel,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.purple,
                                      backgroundColor: isDarkMode
                                          ? Colors.black87
                                          : Colors.purple.shade50),
                                  onPressed: () {
                                    if (FormController
                                                .controllerDescriptionEvent.text
                                                .trim() ==
                                            '' ||
                                        FormController.controllerTitleEvent.text
                                                .trim() ==
                                            '' ||
                                        FormController.controllerDateEvent.text
                                                .trim() ==
                                            '') {
                                      afficheMessage(context,
                                          S.of(context).labelErrorFieldEmpty);
                                    }
                                  },
                                  child: const Icon(Icons.send)),
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
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: TextFormField(
                            controller: FormController.controllerTitleEvent,
                            cursorColor: Colors.purple,
                            keyboardType: TextInputType.text,
                            maxLength: 28,
                            autofocus: true,
                            decoration: const InputDecoration(
                              label: Text('Titre'),
                              hintText: 'Titre de l\'evenement',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Colors.purple, // Change border color here
                                  width: 2.0, // Border width
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          height: 145,
                          child: TextFormField(
                            controller:
                                FormController.controllerDescriptionEvent,
                            cursorColor: Colors.purple,
                            maxLines: null,
                            keyboardType: TextInputType.text,
                            expands: true,
                            maxLength: 145,
                            decoration: const InputDecoration(
                              label: Text('Description'),
                              hintText: 'De quoi s\'agit votre evenement?',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Colors.purple, // Change border color here
                                  width: 2.0, // Border width
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 12),
                          child: TextFormField(
                            controller: FormController.controllerDateEvent,
                            cursorColor: Colors.purple,
                            readOnly: true,
                            decoration: const InputDecoration(
                              label: Text('Date de l\'evenemnt'),
                              hintText: 'jour-mois-année',
                              suffixIcon: Icon(Icons.calendar_today,
                                  color: Colors.purple),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Colors.purple, // Change border color here
                                  width: 2.0, // Border width
                                ),
                              ),
                            ),
                            onTap: () async {
                              String date = await _appService.getDatepicker(
                                  context, Colors.purple, true);
                              if (date != "") {
                                FormController.controllerDateEvent.text = date;
                              }
                            },
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.purple,
                              backgroundColor: isDarkMode
                                  ? Colors.black
                                  : Colors.purple.shade50,
                            ),
                            onPressed: () async {
                              var result = await _appService.getImage();
                              if (result != null) {
                                setState(() {
                                  uploadedImage = Image.file(
                                    result,
                                    fit: BoxFit.cover,
                                  );
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.upload_outlined),
                                const SizedBox(width: 4),
                                Text(S.of(context).buttonUploadImage)
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 12),
                                height: 200,
                                width: 200,
                                child: uploadedImage != null
                                    ? uploadedImage!
                                    : const SizedBox())
                          ],
                        ),
                        uploadedImage != null
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.redAccent,
                                    backgroundColor: Colors.red.shade50),
                                onPressed: () {
                                  _appService.removeImage(setState);
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.delete_outlined),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(S.of(context).buttonDeleteImage),
                                  ],
                                ))
                            : const SizedBox(),
                      ],
                    ),
                  )),
            );
          },
        );
      },
    );
  }

  void dialogCreateTask(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final TextEditingController controllerTaskName = TextEditingController();
    final TextEditingController controllerSubTaskName = TextEditingController();
    final List<String> taskTypeOptions = [
      S.of(context).labelOneTime,
      S.of(context).labelDaily,
      S.of(context).labelWeekly,
      S.of(context).labelAnnually,
      S.of(context).labelPeriodic
    ];
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
                  height: MediaQuery.of(context).size.height *
                      0.9, // prend 90% de la hauteur de l'appareil,
                  decoration: BoxDecoration(
                    color: !isDarkMode
                        ? Colors.white
                        : null, // Your desired background color
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20.0), // Same radius as the shape
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: (() {
                                  Navigator.pop(context);
                                }),
                                child: Text(
                                  S.of(context).buttonCancel,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  controllerTaskName.text.trim() == ''
                                      ? afficheMessage(
                                          context,
                                          S
                                              .of(context)
                                              .messageAddTaskDescription)
                                      : null;
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: isDarkMode
                                      ? Colors.green.shade700
                                      : Colors
                                          .green.shade400, // Color of the icon
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Rounded corners
                                  ),
                                ),
                                child: Text(
                                  S.of(context).buttonAdd,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ),
                      TextField(
                        controller: controllerTaskName,
                        cursorColor: Colors.green.shade700,
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        minLines: 1,
                        maxLength: 64,
                        decoration: InputDecoration(
                          hintText: S.of(context).labelHintTaskName,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .green.shade700, // Change border color here
                              width: 2.0, // Border width
                            ),
                          ),
                        ),
                      ),
                      subTask
                          ? Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 16, right: 16, top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${S.of(context).labelSubTaskAdded} (${subTaskAdded.length}/3)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green.shade700),
                                      ),
                                      const SizedBox(width: 8),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              subTask = !subTask;
                                            });
                                            subTaskAdded = [];
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.orangeAccent,
                                          ))
                                    ],
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxHeight: 200),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 18),
                                      child: ListView.builder(
                                          itemCount: subTaskAdded.length,
                                          shrinkWrap: true,
                                          controller: _scrollController,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 4,
                                                      child: Text(
                                                          subTaskAdded[index])),
                                                  Expanded(
                                                      flex: 1,
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              subTaskAdded.remove(
                                                                  subTaskAdded[
                                                                      index]);
                                                              controllerSubTaskName
                                                                  .text = '';
                                                            });
                                                          },
                                                          child: const Icon(
                                                              Icons.close,
                                                              size: 28)))
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                                subTaskAdded.length < 3
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: TextField(
                                                controller:
                                                    controllerSubTaskName,
                                                cursorColor:
                                                    Colors.green.shade700,
                                                keyboardType:
                                                    TextInputType.text,
                                                minLines: 1,
                                                maxLength: 64,
                                                decoration: InputDecoration(
                                                  hintText: S
                                                      .of(context)
                                                      .labelSubTaskHint,
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.green
                                                          .shade700, // Change border color here
                                                      width:
                                                          2.0, // Border width
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      if (controllerSubTaskName
                                                              .text
                                                              .trim() ==
                                                          '') {
                                                        afficheMessage(
                                                            context,
                                                            S
                                                                .of(context)
                                                                .messageSubTaskError);
                                                        return;
                                                      }
                                                      setState(() {
                                                        subTaskAdded.add(
                                                            controllerSubTaskName
                                                                .text);
                                                      });
                                                      controllerSubTaskName
                                                          .text = '';
                                                      _scrollController
                                                          .animateTo(
                                                        _scrollController
                                                            .position
                                                            .maxScrollExtent, // Maximum scroll extent (bottom)
                                                        duration: const Duration(
                                                            milliseconds:
                                                                300), // Animation duration
                                                        curve: Curves
                                                            .easeInOut, // Animation curve
                                                      );
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 32,
                                                      color:
                                                          Colors.green.shade700,
                                                    )))
                                          ],
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            )
                          : Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.green.shade700,
                                    backgroundColor: isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      subTask = !subTask;
                                    });
                                  },
                                  child: Text(S.of(context).buttonAddSubTask)),
                            ),
                      Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Text(
                          S.of(context).labelChooseRecurrence,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 64,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: taskTypeOptions.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (() {
                                  _selectedOption = taskTypeOptions[index];
                                  periodique = taskTypeOptions[index] ==
                                      S.of(context).labelPeriodic;
                                  setState(() {});
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _selectedOption ==
                                            taskTypeOptions[index]
                                        ? isDarkMode
                                            ? Colors.black26
                                            : Colors.green.shade50
                                        : isDarkMode
                                            ? Colors.black87
                                            : Colors.white,
                                    border: !isDarkMode
                                        ? Border.all(
                                            color: _selectedOption ==
                                                    taskTypeOptions[index]
                                                ? Colors.green.shade200
                                                : Colors.grey,
                                          )
                                        : null,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio<String>(
                                        value: taskTypeOptions[index],
                                        groupValue: _selectedOption,
                                        activeColor: Colors.green.shade700,
                                        onChanged: (value) {
                                          _selectedOption = value;
                                          periodique = taskTypeOptions[index] ==
                                              S.of(context).labelPeriodic;
                                          setState(() {});
                                        },
                                      ),
                                      Expanded(
                                          child: Text(
                                        taskTypeOptions[index],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: _selectedOption ==
                                                    taskTypeOptions[index]
                                                ? Colors.green.shade700
                                                : isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontWeight: _selectedOption ==
                                                    taskTypeOptions[index]
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          periodique
                              ? Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).labelPeriodicConfigure,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green.shade700),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownButton<int>(
                                              value: _selectedNumber,
                                              items: _numbers
                                                  .map((number) =>
                                                      DropdownMenuItem<int>(
                                                        value: number,
                                                        child: Text(
                                                          number.toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
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
                                                  .map((type) =>
                                                      DropdownMenuItem<String>(
                                                        value: type,
                                                        child: Text(
                                                          type,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
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
                              : const SizedBox(),
                          Column(
                            children: [
                              uploadedImage != null
                                  ? Container(
                                      height: 120,
                                      width: 120,
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: uploadedImage!)
                                  : const SizedBox(),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.green.shade700,
                                      backgroundColor: isDarkMode
                                          ? Colors.black
                                          : Colors.green.shade50),
                                  onPressed: () async {
                                    var result = await _appService.getImage();
                                    if (result != null) {
                                      setState(() {
                                        uploadedImage = Image.file(
                                          result,
                                          fit: BoxFit.cover,
                                        );
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.upload_outlined),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(S.of(context).buttonUploadImage),
                                    ],
                                  )),
                              uploadedImage != null
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.redAccent,
                                          backgroundColor: isDarkMode
                                              ? Colors.black
                                              : Colors.red.shade50),
                                      onPressed: () {
                                        _appService.removeImage(setState);
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(Icons.delete_outlined),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(S.of(context).buttonDeleteImage),
                                        ],
                                      ))
                                  : const SizedBox(),
                            ],
                          )
                        ],
                      ),
                    ],
                  )),
            );
          },
        );
      },
    );
  }

  void dialogRepondreCommentaire(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // Ajustement pour le clavier
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: !isDarkMode ? Colors.white : null,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Ajuste la hauteur au contenu
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
                            controller:
                                FormController.controllercommentRepondre,
                            cursorColor: Colors.cyan,
                            maxLines: 8, // Makes the TextField multiline
                            keyboardType: TextInputType.multiline,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: S.of(context).labelYourAnswer,
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.cyan, width: 1.0)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.cyan),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.send),
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

  void dialogTransferTache(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
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
                        child: const Text(
                          'À qui voulez-vous transferer cette tâche?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 7,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
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
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: selectedIndex == index
                                          ? Colors.purple
                                          : null,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            height: 80,
                                            width: 80,
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            child: ClipOval(
                                              child: Image.asset(
                                                'assets/images/cat_profile_img.jpg',
                                                semanticLabel:
                                                    'Image du profil',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          //const SizedBox(height: 4),
                                          Text(
                                            'Jean Pierre',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: selectedIndex == index
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    selectedIndex != -1
                        ? const Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('Transferer à Jean Pierre',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))))
                        : const Expanded(child: SizedBox()),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          bottom: 12, left: 16, right: 16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: selectedIndex == -1
                                ? Colors.grey
                                : Colors.purple,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          if (selectedIndex != -1) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Transferer'),
                      ),
                    )
                  ],
                );
              }),
            ));
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
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
              ),
              onPressed: () {
                String organizationName = orgNameController.text.trim();
                if (organizationName.isNotEmpty) {
                  Navigator.pop(context);
                }
              },
              child:
                  const Text('Create', style: TextStyle(color: Colors.white)),
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
            'Join Organization',
            style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
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
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan, foregroundColor: Colors.white),
              onPressed: () {
                String organizationCode = orgCodeController.text.trim();
                if (organizationCode.isNotEmpty) {
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

  // Ce widget retourne des étoiles d'évaluation
  RatingStars getRatingStars(double value, bool afficheValeur) {
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
      valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      valueLabelMargin: const EdgeInsets.only(right: 8),
      starOffColor: const Color(0xffe7e8ea),
      starColor: Colors.yellow,
    );
  }

  //region Ici se trouve les dialogs qui affichent les messages d'alertes
  Future<bool?> dialogYesorNo(BuildContext context, String message) async {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
              color: !isDarkMode ? Colors.white : null,
              borderRadius: BorderRadius.circular(20),
              boxShadow: !isDarkMode
                  ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : null,
            ),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: !isDarkMode ? Colors.black87 : null,
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
                        backgroundColor:
                            isDarkMode ? Colors.cyan.shade900 : Colors.cyan,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: Text(S.of(context).labelYes,
                          style: const TextStyle(fontSize: 16)),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        backgroundColor: !isDarkMode ? Colors.white : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: Text(S.of(context).labelNon,
                          style: const TextStyle(fontSize: 16)),
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
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
              color: !isDarkMode ? Colors.white : null,
              borderRadius: BorderRadius.circular(20),
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
                        //color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Veuillez joindre ou créer la votre.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        //color: Colors.black87,
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
                          backgroundColor:
                              isDarkMode ? Colors.cyan.shade700 : Colors.cyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Joindre',
                            style: TextStyle(fontSize: 16)),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child:
                            const Text('Créer', style: TextStyle(fontSize: 16)),
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

  void afficheMessage(BuildContext context, String message) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: !isDarkMode
              ? Colors.white
              : null, // Set background color to white
          title: Text(
            S.of(context).labelError,
            style: const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold), // Cyan text color for title
          ),
          content: Text(
            message,
            style: TextStyle(
                color: isDarkMode
                    ? Colors.white
                    : Colors.black), // Cyan text color for the message
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                    color: Colors.cyan), // Cyan text color for the button
              ),
            ),
          ],
        );
      },
    );
  }
  //endregion

  //region Ici se trouve les widgets Shimmer qui s'affiche comme un squelette lors du chargement d'une page
  Widget shimmerAcceuil(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.black54 : Colors.grey.shade300,
      highlightColor: isDarkMode ? Colors.black : Colors.grey.shade100,
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

  Widget shimmerEspaceFamille(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.black54 : Colors.grey.shade300,
      highlightColor: isDarkMode ? Colors.black : Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
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

  Widget shimmerCommentairesAnnonce(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.black54 : Colors.grey.shade300,
      highlightColor: isDarkMode ? Colors.black : Colors.grey.shade100,
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

  Widget shimmerEpiceire(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.black54 : Colors.grey.shade300,
      highlightColor: isDarkMode ? Colors.black : Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return index == 0
              ? const SizedBox(
                  height: 210,
                )
              : Container(
                  height: 90,
                  margin:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
        },
      ),
    );
  }

  Widget shimmerTaches(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.black54 : Colors.grey.shade300,
      highlightColor: isDarkMode ? Colors.black : Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return index == 0
              ? const SizedBox(
                  height: 210,
                )
              : Container(
                  height: 150,
                  margin:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
        },
      ),
    );
  }

  Widget shimmerProfil(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.black54 : Colors.grey.shade300,
      highlightColor: isDarkMode ? Colors.black : Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return index == 0
              ? Container(
                  height: 240,
                  margin: const EdgeInsets.only(
                      top: 24, left: 8, right: 8, bottom: 40),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              : Container(
                  height: 100,
                  margin:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
        },
      ),
    );
  }

  Widget shimmerListeEvaluation(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.black54 : Colors.grey.shade300,
      highlightColor: isDarkMode ? Colors.black : Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return index == 0
              ? const SizedBox(
                  height: 180,
                )
              : Container(
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
  //endregion

  // endregion

  void clearController() {
    FormController().clearAllControllers();
  }
}
