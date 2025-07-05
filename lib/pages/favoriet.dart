import 'package:flutter/material.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/widgets/custom_body.dart';

class Favoriet extends StatelessWidget {
  final List<NoteModel> favorietNotes;
  const Favoriet({required this.favorietNotes, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          'Favoriet',
          style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
        ),
        backgroundColor: primaryColor,
      ),
      body: CustomBody(notes: favorietNotes),
    );
  }
}
