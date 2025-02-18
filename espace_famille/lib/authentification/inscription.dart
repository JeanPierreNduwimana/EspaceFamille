import 'package:espace_famille/services/app_service.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../services/widget_service.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}
WidgetService _designService = WidgetService();
AppService _appService = AppService();

final TextEditingController username_controller = TextEditingController();
final TextEditingController password_controller = TextEditingController();
final TextEditingController passwordConfirm_controller = TextEditingController();
final TextEditingController _dateController = TextEditingController();

class _InscriptionState extends State<Inscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _designService.appBar(context,S.of(context).labelRegisterPageTitle, true,Colors.cyan),
      body: buildBody(),
    );
  }

  Widget buildBody(){
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Center(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              children: [
                Text(S.of(context).labelRegisterPageTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                const SizedBox(height: 24),
                TextField(
                  controller: username_controller,
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.cyan,
                  maxLength: 16,
                  decoration:  InputDecoration(
                      hintText:S.of(context).labelUsername,
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyan, // Change border color here
                            width: 2.0, // Border width
                          )
                      )
                  ),
                ),
                TextField(
                  controller: _dateController,
                  readOnly: true,
                  cursorColor: Colors.cyan,
                  decoration: InputDecoration(
                    hintText: S.of(context).labelRegisterPageBirthDate,
                    suffixIcon: const Icon(Icons.calendar_today, color: Colors.cyan),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                  ),
                  onTap: () async {
                    String date = await _appService.getDatepicker(context, Colors.cyan, false);
                    if(date != ""){
                      _dateController.text = date;
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: password_controller,
                  obscureText: true,
                  cursorColor: Colors.cyan,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: S.of(context).labelPassword,
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyan, // Change border color here
                            width: 2.0, // Border width
                          )
                      )
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordConfirm_controller,
                  obscureText: true,
                  cursorColor: Colors.cyan,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: S.of(context).labelPasswordConfirm,
                      focusedBorder: const UnderlineInputBorder(
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
                        Navigator.pushNamed(context, '/acceuil');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white
                      ),
                      child: Text(S.of(context).buttonCreateAccont),
                    ),
                    const SizedBox(height: 12,),
                    ElevatedButton(
                        onPressed: () async {
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: isDarkMode ? Colors.black87 : Colors.white,
                            foregroundColor: Colors.cyan
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(S.of(context).labelRegisterWith),
                            const SizedBox(width: 16),
                            SizedBox(height: 20, child: Image.asset('assets/images/google_image_logo.png',)),
                          ],
                        )
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                          const SizedBox(width: 16),
                          Text(S.of(context).labelOr),
                          const SizedBox(width: 16),
                          const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, '/connexion');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode ? Colors.black87 : Colors.white,
                          foregroundColor: Colors.cyan,
                          elevation: 0,
                          side: BorderSide(
                              width: 1,
                              color: Colors.cyan.withOpacity(0.5)
                          )
                      ),

                      child: Text(S.of(context).buttonConnexion),
                    ),

                  ],
                )

              ],
            ),
          )
      ),
    );

  }


}
