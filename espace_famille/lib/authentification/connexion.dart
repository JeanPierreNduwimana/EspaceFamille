import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/design_service.dart';

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<Connection> createState() => _ConnectionState();
}
DesignService _designService = DesignService();
final TextEditingController username_controller = TextEditingController();
final TextEditingController password_controller = TextEditingController();
class _ConnectionState extends State<Connection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar(context,'Connexion', true),
      body: buildBody(),
    );
  }

  Widget buildBody(){
    return SingleChildScrollView(
      child: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Column(
                children: [
                  Text('Se connecter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                  const SizedBox(height: 24),
                  TextField(
                    controller: username_controller,
                    keyboardType: TextInputType.name,
                    maxLength: 16,
                    decoration:  const InputDecoration(
                        hintText:'username',
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
                    controller: password_controller,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                        hintText: 'Mot de passe',
                        hintStyle: TextStyle(color: Colors.black38),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.cyan, // Change border color here
                              width: 2.0, // Border width
                            )
                        )
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          //Navigator.pushNamed(context, '/acceuil');
                          Navigator.popAndPushNamed(context, '/acceuil');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white
                        ),
                        child: Text('Connection'),
                      ),
                      const SizedBox(height: 12,),
                      ElevatedButton(
                        onPressed: () async {
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.cyan
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Connexion avec'),
                            const SizedBox(width: 16),
                            SizedBox(height: 20, child: Image.asset('assets/images/google_image_logo.png',)),
                          ],
                        )
                      ),
                      //const SizedBox(height: 24,),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Expanded(child: const Divider(thickness: 1, color: Colors.grey)),
                            const SizedBox(width: 16),
                            Text('Ou'),
                            const SizedBox(width: 16),
                            Expanded(child: const Divider(thickness: 1, color: Colors.grey)),
                          ],
                        ),
                      ),
                      //const SizedBox(height: 24,),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, '/inscription');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.cyan,
                          elevation: 0,
                          side: BorderSide(
                            width: 1,
                            color: Colors.cyan.withOpacity(0.5)
                          )
                        ),

                        child: Text('Créer un compte'),
                      ),
                      /* const SizedBox(height: 12,),
                      GestureDetector(
                          onTap: (){},
                          child: Text('Je ne suis pas inscrit', textAlign: TextAlign.center,)) */

                    ],
                  )

                ],
              ),
            ),
          )
      ),
    );
  }
}
