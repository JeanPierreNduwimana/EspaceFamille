import 'package:espace_famille/models/transfer_models.dart';
import 'package:espace_famille/services/firebase_auth_service.dart';
import 'package:espace_famille/widgets/shared_app_bar.dart';
import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import '../utils/error_handling_service.dart';
import '../utils/form_controllers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isLoading = false;

class _LoginScreenState extends State<LoginScreen> {
  final _connexionFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(
          title: S.of(context).buttonConnexion,
          showProfileAction: false,
          titleColor: Colors.cyan),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          children: [
            Text(
              S.of(context).connexionPageTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 24),
            Form(
              key: _connexionFormKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: FormController.username_controller,
                      cursorColor: Colors.cyan,
                      keyboardType: TextInputType.name,
                      maxLength: 16,
                      decoration: InputDecoration(
                          hintText: S.of(context).labelUsername,
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.cyan, // Change border color here
                            width: 2.0, // Border width
                          ))),
                      validator: (value) => ErrorHandling()
                          .errorUsernameController(
                              FormController.username_controller.text)),
                  TextFormField(
                    controller: FormController.password_controller,
                    cursorColor: Colors.cyan,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: S.of(context).labelPassword,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.cyan, // Change border color here
                          width: 2.0, // Border width
                        ))),
                    validator: (value) => ErrorHandling().errorEmptyField(
                        FormController.password_controller.text),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (!isLoading) {
                      buttonConnectionRequest();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      foregroundColor: Colors.white),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white))
                      : Text(S.of(context).buttonConnexion),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () async {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isDarkMode ? Colors.black87 : Colors.white,
                        foregroundColor: Colors.cyan),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(S.of(context).buttonConnexionWith),
                        const SizedBox(width: 16),
                        SizedBox(
                            height: 20,
                            child: Image.asset(
                              'assets/images/google_image_logo.png',
                            )),
                      ],
                    )),
                //const SizedBox(height: 24,),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Divider(thickness: 1, color: Colors.grey)),
                      const SizedBox(width: 16),
                      Text(S.of(context).labelOr),
                      const SizedBox(width: 16),
                      const Expanded(
                          child: Divider(thickness: 1, color: Colors.grey)),
                    ],
                  ),
                ),
                //const SizedBox(height: 24,),
                ElevatedButton(
                  onPressed: () async {
                    FormController().clearAllControllers();
                    Navigator.pushNamed(context, '/inscription');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDarkMode ? Colors.black87 : Colors.white,
                      foregroundColor: Colors.cyan,
                      elevation: 0,
                      side: BorderSide(
                          width: 1, color: Colors.cyan.withOpacity(0.5))),
                  child: Text(S.of(context).buttonCreateAccont),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  void buttonConnectionRequest() async {
    setState(() {
      isLoading = true;
    });
    if (_connexionFormKey.currentState!.validate()) {
      LogInRequest logInRequest = LogInRequest(
          FormController.username_controller.text,
          FormController.password_controller.text);
      try {
        await FirebaseAuthService().logIn(logInRequest, context);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
