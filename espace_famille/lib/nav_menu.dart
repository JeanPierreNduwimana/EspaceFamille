import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavMenu extends StatefulWidget {
  const NavMenu({super.key});

  @override
  State<NavMenu> createState() => _NavMenuState();
}

class _NavMenuState extends State<NavMenu> {
  @override
  Widget build(BuildContext context) {
    var listview = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 48),
                child: Column( //Informations d'utilisateur
                  children: [
                    Row( // rangé contenant l'image
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Expanded(child: SizedBox()),
                        Container(
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
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Expanded(child: Text('Jean Pierre',textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.cyan),)),
                        Text('   |   ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Expanded(child: Text('16-03-1999', textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)))
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [

                ],
              )
            ],
          ),
        )
      ],

    );

    return Drawer(
      child: Container(
        color: Colors.white,
        child: listview,
      ),
    );
  }
}
