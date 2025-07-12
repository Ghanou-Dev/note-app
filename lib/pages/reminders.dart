import 'package:flutter/material.dart';
import 'package:notes/const.dart';

class Reminders extends StatelessWidget {
  const Reminders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Reminders", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Text(
          'Soon ..',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: secondaryColor,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
