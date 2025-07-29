import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final shortestSide = MediaQuery.of(context).size.shortestSide;
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
                  fontSize: shortestSide < 600 ? 18.sp : 36.sp,
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
                padding: const EdgeInsets.all(15),
                child: CustomSearchBar(notes: notes),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OrientationBuilder(
                    builder: (context, orientation) {
                      return GridView.builder(
                        itemCount: notes.length,
                        gridDelegate:
                            orientation == Orientation.portrait &&
                                shortestSide < 600
                            ? SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 6,
                                crossAxisSpacing: 6,
                                childAspectRatio: 0.9,
                              )
                            : SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 250,
                                mainAxisSpacing: 6,
                                crossAxisSpacing: 6,
                                childAspectRatio: 0.9,
                              ),
                        itemBuilder: (context, index) {
                          return ItemNote(note: notes[index]);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
