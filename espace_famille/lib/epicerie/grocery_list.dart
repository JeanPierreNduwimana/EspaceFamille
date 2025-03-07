import 'package:espace_famille/epicerie/firebase_food_service.dart';
import 'package:espace_famille/epicerie/grocery_list_widgets.dart';
import 'package:espace_famille/epicerie/widget_grocery_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../generated/l10n.dart';
import '../app_services/widget_service.dart';
import '../models/transfer_models.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}
WidgetService _designService = WidgetService();

bool isloading = true;
Member member = Member(DateTime.now(),5,'A1AU6adC6H9d3777lIO1','','','','');
List<Food> groceryList = [];
class _GroceryListState extends State<GroceryList> {

  Food foodforindex0 = Food('blabla', DateTime.now(), 'genericimage',
      'biuwebiwv','',false, 'Mais souffé', 8);

  void loadGroceries()async{
    setState(() {
      isloading = true;
    });
    try{
      var result = await FirebaseFoodService().getGroceryList(member, context);
      groceryList = [];
      groceryList.add(foodforindex0);
      groceryList.insertAll(1, result);
    }finally{
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp // Optional
    ]);
    loadGroceries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: groceryListAppBar(context, isloading),
      body: isloading ? _designService.shimmerEpiceire(context) : buildBody(),
      bottomNavigationBar: _designService.navigationBar(context, 1, setState),
    );
  }

  Widget buildBody(){
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Future<void> onRefresh() async {
      loadGroceries();
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Colors.redAccent,
      child: ListView.builder(
        itemCount: groceryList.length,
        itemBuilder: (context, index) {
          return index == 0 ?
           Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(height: 32),
                const Icon(Icons.dinner_dining, color: Colors.redAccent, size: 54,),
                const SizedBox(height: 32),
                Text(S.of(context).groceriePageTitle, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(S.of(context).groceriePageSubTitle,textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 24),
              ],
            ),
          )
          :
          Dismissible(
            key: Key(groceryList[index].name),
            background: Container(
              margin: const EdgeInsets.symmetric(vertical: 18),
              color: Colors.greenAccent,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20.0),
              child: const Icon(Icons.check, color: Colors.white),
            ),
            secondaryBackground: Container(
              margin: const EdgeInsets.symmetric(vertical: 18),
              color: Colors.red.withOpacity(0.6),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                // Item glissé vers la droite : Validation d'achat
                Food? food = await FirebaseFoodService().setPurchasedFood( groceryList[index], member, context);
                if(food != null){
                  setState(() {
                    groceryList[index].isPurchased = food.isPurchased;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          duration: const Duration(seconds: 3),
                          content: Text(
                              groceryList[index].isPurchased ? 'Cet aliment a été acheté : ${groceryList[index].name}'
                                  : 'L\'achat de cet aliment est annulé : ${groceryList[index].name}' ))
                  );
                }

                return false;

              } else if (direction == DismissDirection.endToStart) {
                // Action quand l'utilisateur glisse vers la gauche
                bool? result = await _designService.dialogYesorNo(context, 'Supprimer cette aliment');
                if(result != null && result){
                    return true;
                }
              }
              return null;
            },
            onDismissed: (direction) async {
             await FirebaseFoodService().deleteFoodFromGrocery(groceryList[index], member, context);
             loadGroceries();
            },
            child: GestureDetector(
              onTap: (){
                GroceryListWidgets().dialogDetailAliment(context);
              },
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                color:groceryList[index].isPurchased ? (isDarkMode ? Colors.black : Colors.grey.withOpacity(0.1)) : (isDarkMode ? Colors.grey.withOpacity(0.1) :  Colors.white),
                elevation: groceryList[index].isPurchased ? 0 :  1,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        height: 80, width: 80,
                        child: Image.network(groceryList[index].imgUrl, fit: BoxFit.cover,),
                      ),
                       Expanded(
                         flex: 2,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 groceryList[index].name,
                               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                          ),
                               const SizedBox(height: 8),
                               Row(
                                 children: [
                                   SizedBox(
                                     height: 20,
                                     width: 20,
                                     child: ClipOval(
                                       child: Image.network(
                                         groceryList[index].imgUrl,
                                         semanticLabel: 'Image du profil',
                                         fit: BoxFit.cover,),
                                     ),
                                   ),
                                   const SizedBox(width: 8),
                                   Text(S.of(context).labelMinutesPassed(2)),
                                 ],
                               ),
                             ],
                           ),
                       ),
                       Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            //border: ,
                            color: groceryList[index].isPurchased ? Colors.grey.withOpacity(0.3) : Colors.red.withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                groceryList[index].quantity == 0 ? '-' : groceryList[index].quantity.toString(),
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Text(
                                S.of(context).labelQuantityShorted,
                                style: const TextStyle(fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
