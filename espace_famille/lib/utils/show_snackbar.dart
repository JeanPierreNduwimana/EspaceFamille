import 'package:flutter/material.dart';

class ShowSnackbar extends StatelessWidget {
  final String message;
  final int? duration;
  const ShowSnackbar({super.key, required this.message, this.duration});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration ?? 3),
    );
  }
}
