import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../services/widget_service.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}
WidgetService _designService = WidgetService();
final TextEditingController username_controller = TextEditingController();
final TextEditingController password_controller = TextEditingController();
final TextEditingController passwordConfirm_controller = TextEditingController();
DateTime? _selectedDate;
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

    void _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(2000), // Date par défaut
        firstDate: DateTime(1900),  // Date minimale
        lastDate: DateTime.now(),  // Date maximale
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              //primaryColor: Colors.cyan, // Accent sur les boutons
              colorScheme: isDarkMode ? const ColorScheme.dark(
                primary: Colors.cyan, // Header background color & buttons
                onPrimary: Colors.black, // Text color on header buttons
                onSurface: Colors.white, // Text color for dates
              ): const ColorScheme.light(
                primary: Colors.cyan, // Header background color & buttons
                onPrimary: Colors.white, // Text color on header buttons
                onSurface: Colors.black, // Text color for dates
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.cyan // Button text color
                ),
              ),
              dialogBackgroundColor: Colors.white, // Background color of the dialog
              scaffoldBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },
      );

      if (pickedDate != null && pickedDate != _selectedDate) {
        setState(() {
          _selectedDate = pickedDate;
          _dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        });
      }
    }

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
                  onTap: () => _selectDate(context),
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
