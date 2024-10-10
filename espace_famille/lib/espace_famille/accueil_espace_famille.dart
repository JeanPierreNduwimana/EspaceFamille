import 'package:espace_famille/services/basic_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String image = 'assets/images/naruto.jpg';
BasicService _basicService = BasicService();

class AccueilEspaceFammille extends StatefulWidget {
  const AccueilEspaceFammille({super.key});

  @override
  State<AccueilEspaceFammille> createState() => _AccueilEspaceFammilleState();
}

class _AccueilEspaceFammilleState extends State<AccueilEspaceFammille> {
  final List<annonce> listannonces = [
    annonce('jeanpierre', 'Quel belle journée aujourd\'hui', ''),
    annonce('Mario', 'Ne prennez pas mon sandwich que j\'ai laissé au frigo', image),
    annonce('Henry','Qui veut regarder les magas avec moi ce soir????', ''),
    annonce('jeanpierre', 'Quel belle journée aujourd\'hui', ''),
    annonce('Mario', 'Ne prennez pas mon sandwich que j\'ai laissé au frigo', image),
    annonce('Henry','Qui veut regarder les magas avec moi ce soir????', ''),
    annonce('jeanpierre', 'Quel belle journée aujourd\'hui', ''),
    annonce('Mario', 'Ne prennez pas mon sandwich que j\'ai laissé au frigo', image),
    annonce('Henry','Qui veut regarder les magas avec moi ce soir????', '')
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _basicService.appBar(),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: (){
          Navigator.pushNamed(context, '/pageprofile');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody(){
    return ListView.builder(
        itemBuilder: (BuildContext context, int index){

          if(index < listannonces.length){
            return Column(
              children: [
                const SizedBox(height: 12,),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  //padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.cyan[50],borderRadius: BorderRadius.circular(10),/* border: Border.all(color: Colors.grey, width: 1) */),
                  child: ListTile(
                      title: Row(
                        children: [
                          Expanded(child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
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
                                  const SizedBox(width: 12,),
                                  Text(listannonces[index].username, style: const TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(listannonces[index].description),
                              SizedBox(height: 4,)
                            ],
                          ) ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_horiz),
                                  onSelected: (String value){
                                    print('Selected: $value');
                                  },
                                  itemBuilder: (BuildContext context){
                                    return const [
                                      PopupMenuItem<String>(
                                        value: 'Modifier',
                                        child: Row(
                                          children: [
                                            Text('Modifier', style: TextStyle(fontSize: 16),),
                                            SizedBox(width: 4,),
                                            Icon(Icons.edit, size: 16,)
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'Supprimer',
                                        child: Row(
                                          children: [
                                            Text('Supprimer', style: TextStyle(fontSize: 16),),
                                            SizedBox(width: 4,),
                                            Icon(Icons.delete, size: 16,)
                                          ],
                                        ),
                                      )
                                    ];
                                  }),
                              SizedBox(height: 4,),
                              Container(
                                  height: 60,
                                  width: 60,
                                  child:  getImage(listannonces[index].url)
                              ),
                            ],
                          )
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          const Divider(
                            thickness: 1,
                            color: Colors.black38,
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(Icons.favorite, color: Colors.deepOrange[400],),
                              Text(listannonces[index].Favs.toString(), style: TextStyle(color: Colors.deepOrange[400]),),
                              SizedBox(width: 8),
                              Icon(Icons.comment, color: Colors.cyan[600],),
                              Text(listannonces[index].Comments.toString(), style: TextStyle(color: Colors.cyan[600]),),
                              Expanded(child: Align(alignment: Alignment.centerRight, child: Text(listannonces[index].date.toString(), style: const TextStyle(fontStyle: FontStyle.italic),)))
                            ],
                          ),
                        ],
                      )
                  ),
                )
              ],
            );
          }

        });
  }

  getImage(String url){
    if(url != ''){
      return Image.asset(url, fit: BoxFit.cover,);
    }
    return null;
  }
}

class annonce {

  annonce(String _username,String _descr, String img_url){
    username = _username;
    description = _descr;
    url = img_url;
  }
  String username = '';
  String description = '';
  DateTime date = new DateTime.now();
  int Comments = 2;
  int Favs = 4;
  String url = '';
}
