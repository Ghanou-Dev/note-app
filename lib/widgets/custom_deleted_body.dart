import 'package:flutter/material.dart';
import 'package:notes/const.dart';
import 'package:notes/l10n/app_localizations.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/widgets/custom_search_bar.dart';
import 'package:notes/widgets/item_deleted_note.dart';

class CustomDeletedBody extends StatelessWidget {
    final List<NoteModel> deletedNotes;

  const CustomDeletedBody({required this.deletedNotes,super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return deletedNotes.isEmpty
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomSearchBar(notes: deletedNotes),
              ),
              Spacer(),
              Text(
                locale.no_notes,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
              Spacer(),
            ],
          )
        : Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomSearchBar(notes: deletedNotes),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: deletedNotes.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      return ItemDeletedNote(
                       deletedNote: deletedNotes[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}