import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/const.dart';
import 'package:notes/l10n/app_localizations.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_cubit.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_state.dart';
import 'package:notes/widgets/custom_body.dart';

class Favoriet extends StatelessWidget {
  final List<NoteModel> favorietNotes;
  const Favoriet({required this.favorietNotes, super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          locale.favoriets,
          style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
        ),
        backgroundColor: primaryColor,
      ),
      body: BlocBuilder<FavorietCubit, FavorietState>(
        builder: (context, state) {
          if (state is FavorietSucess) {
            List<NoteModel> listFavoriet = state.favorietNotes;
            return CustomBody(notes: listFavoriet);
          }
          return CustomBody(notes: favorietNotes);
        },
      ),
    );
  }
}
