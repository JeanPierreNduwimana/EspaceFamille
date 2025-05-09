import 'package:espace_famille/authentification/connexion.dart';
import 'package:espace_famille/models/transfer_models.dart';
import 'package:espace_famille/app_services/app_service.dart';
import 'package:espace_famille/app_services/error_handling_service.dart';
import 'package:espace_famille/authentification/firebase_auth_service.dart';
import 'package:espace_famille/tools/form_controllers.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../app_services/widget_service.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}
WidgetService _designService = WidgetService();
AppService _appService = AppService();
bool isLoading = false;


class _InscriptionState extends State<Inscription> {
  final _signUpFormKey = GlobalKey<FormState>();
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
                Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: FormController.username_controller,
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
                        validator: (value) => ErrorHandling().errorUsernameController(FormController.username_controller.text)
                      ),
                      TextFormField(
                        controller: FormController.dateController,
                        readOnly: true,
                        cursorColor: Colors.cyan,
                        decoration: InputDecoration(
                          hintText: S.of(context).labelRegisterPageBirthDate,
                          suffixIcon: const Icon(Icons.calendar_today, color: Colors.cyan),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                        ),
                        validator: (value) => ErrorHandling().errorEmptyField(FormController.dateController.text),
                        onTap: () async {
                          String date = await _appService.getDatepicker(context, Colors.cyan, false);
                          if(date != ""){
                            FormController.dateController.text = date;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: FormController.password_controller,
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
                        validator: (value) => ErrorHandling().errorpasswordController(FormController.password_controller.text, FormController.passwordConfirm_controller.text),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: FormController.passwordConfirm_controller,
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
                        validator: (value) => ErrorHandling().errorpasswordController(FormController.password_controller.text, FormController.passwordConfirm_controller.text),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if(!isLoading){
                          buttonSignInResquest();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white
                      ),
                      child: isLoading ? const SizedBox( height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white,)) : Text(S.of(context).buttonCreateAccont),
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
                        FormController().clearAllControllers();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Connection()), (Route<dynamic> route) => false,
                        );
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

  void buttonSignInResquest()async{
    setState(() {
      isLoading = true;
    });
      if(_signUpFormKey.currentState!.validate()){
        SignUpRequest signUpRequest = SignUpRequest(
            FormController.username_controller.text,
            FormController.dateController.text,
            FormController.password_controller.text,
            FormController.passwordConfirm_controller.text);
        try{
          await FirebaseAuthService().signUp(signUpRequest, context);
        }finally{
          setState(() {
            isLoading = false;
          });
        }
      }else{
        setState(() {
          isLoading = false;
        });
      }
  }


}
