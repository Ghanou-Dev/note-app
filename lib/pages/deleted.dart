import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/delete_cubit/delete_cubit.dart';
import 'package:notes/pages/cubits/delete_cubit/delete_state.dart';
import 'package:notes/widgets/custom_deleted_body.dart';

class Deleted extends StatefulWidget {
  final List<NoteModel> deletedNotes;
  const Deleted({required this.deletedNotes, super.key});

  @override
  State<Deleted> createState() => _DeletedState();
}

class _DeletedState extends State<Deleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          'Deleted',
          style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
        ),
        backgroundColor: primaryColor,
      ),
      body: BlocBuilder<DeleteCubit, DeletedState>(
        builder: (context, state) {
          if (state is DeletedSuccess) {
            List<NoteModel> deletedNotes = state.deletedNotes;
            return CustomDeletedBody(deletedNotes: deletedNotes);
          }
          return CustomDeletedBody(deletedNotes: widget.deletedNotes);
        },
      ),
    );
  }
}
