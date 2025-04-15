import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import '../utils/shared_helpers.dart';
import 'grocery_list_widgets.dart';

PreferredSizeWidget groceryListAppBar(BuildContext context, bool isloading) {
  return AppBar(
    leading: null,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            S.of(context).appBarGroceriePageTitle,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (!isloading) {
                  GroceryListWidgets().dialogAjoutAliment(context);
                }
              },
              child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color:
                        isloading ? Colors.grey : Colors.red.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18,
                  )),
            ),
            const SizedBox(width: 18),
            PopupMenuButton<String>(
                surfaceTintColor: Colors.white,
                onSelected: (value) {
                  // Action à exécuter selon l'option sélectionnée
                  if (!isloading) {
                    if (value == 'Date') {
                    } else if (value == 'Achat') {}
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem(
                          enabled: false,
                          child: Text(
                            S.of(context).labelSortBy,
                            style: const TextStyle(color: Colors.redAccent),
                          )),
                      //const PopupMenuDivider(),
                      const PopupMenuItem<String>(
                        value: 'Date',
                        child: Text(
                          'Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Achat',
                        child: Text(S.of(context).labelAchat,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                icon: Row(
                  children: [
                    Text(
                      S.of(context).labelSort,
                      style: TextStyle(
                          fontSize: 14,
                          color: isloading ? Colors.grey : Colors.redAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.sort,
                        color: isloading ? Colors.grey : Colors.redAccent),
                  ],
                ) // Icône à trois points
                ),
            const SizedBox(width: 32),
            GestureDetector(
              onTap: () {
                if (!isloading) {
                  Navigator.pushNamed(context, '/app_options');
                }
              },
              child: SizedBox(
                height: 32,
                width: 32,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/cat_profile_img.jpg',
                    semanticLabel: 'Image du profil',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}
