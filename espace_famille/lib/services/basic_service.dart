import 'package:flutter/material.dart';

class BasicService {

  BasicService(){}

  PreferredSize appBar(String title){
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0), // Hauteur de l'AppBar
      child: AppBar(
        backgroundColor: Colors.cyan,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

}