import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/display_note.dart';

class CustomSearchBar extends StatefulWidget {
  final List<NoteModel> notes;
  const CustomSearchBar({required this.notes, super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  SearchController searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: secondaryColor,
          selectionHandleColor: secondaryColor,
        ),
      ),
      child: SearchAnchor.bar(
        barBackgroundColor: WidgetStatePropertyAll(primaryColor),
        barShape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20),
          ),
        ),
        barHintText: 'Search',
        barPadding: WidgetStatePropertyAll(EdgeInsets.all(15)),
        barTextStyle: WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.bold),
        ),
        barHintStyle: WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
        ),
        barLeading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, color: secondaryColor),
        ),
        barTrailing: [
          IconButton(
            onPressed: () {
              searchController.clear();
            },
            icon: Icon(Icons.clear, color: secondaryColor),
          ),
        ],

        barOverlayColor: WidgetStatePropertyAll(
          primaryColor,
        ), // whern get out from bar
        barSide: WidgetStatePropertyAll(BorderSide(color: primaryColor)),
        viewBackgroundColor: primaryColor,
        searchController: searchController,
        suggestionsBuilder: (context, controller) {
          final query = controller.text.toLowerCase();
          final filtred = widget.notes
              .where((note) => note.title.toLowerCase().contains(query))
              .toList();

          final results = filtred.map((note) {
            return ListTile(
              title: Text(
                note.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                searchController.closeView(note.title);
                searchController.clear();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => DisplayNote(note: note),
                  ),
                );
                // go to item ..
              },
            );
          }).toList();
          if (results.isEmpty) {
            return [
              ListTile(
                title: Text(
                  'No Notes',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ];
          }
          return results;
        },
      ),
    );
  }
}
