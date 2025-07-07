import 'package:flutter/material.dart';
import 'package:notes/const.dart';
import 'package:notes/l10n/app_localizations.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/widgets/custom_search_bar.dart';
import 'package:notes/widgets/item_note.dart';

class CustomBody extends StatelessWidget {
  final List<NoteModel> notes;
  const CustomBody({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return notes.isEmpty
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomSearchBar(notes: notes),
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
                child: CustomSearchBar(notes: notes),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: notes.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      return ItemNote(
                        note: notes[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
