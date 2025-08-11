import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/const.dart';
import 'package:notes/l10n/app_localizations.dart';
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
    final locale = AppLocalizations.of(context)!;
    final FocusScopeNode focusNode = FocusScopeNode();
    bool didJustDismis = false;
    return Theme(
      key: const Key(customSearchBarKey),
      data: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: secondaryColor,
          selectionHandleColor: secondaryColor,
        ),
      ),
      child: FocusScope(
        key: const Key(focusScopeKey),
        node: focusNode,
        onFocusChange: (isFocused) {
          if (didJustDismis & isFocused) {
            didJustDismis = false;
            focusNode.unfocus();
          }
        },
        child: SearchAnchor.bar(
          barBackgroundColor: const WidgetStatePropertyAll(primaryColor),
          barShape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20.r),
            ),
          ),
          barHintText: locale.search,
          barPadding: const WidgetStatePropertyAll(EdgeInsets.all(15)),
          barTextStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.bold),
          ),
          barHintStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
          ),
          barLeading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: secondaryColor),
          ),
          barTrailing: [
            IconButton(
              onPressed: () {
                searchController.clear();
              },
              icon: const Icon(Icons.clear, color: secondaryColor),
            ),
          ],

          barOverlayColor: const WidgetStatePropertyAll(
            primaryColor,
          ), // whern get out from bar
          barSide: const WidgetStatePropertyAll(BorderSide(color: primaryColor)),
          viewBackgroundColor: primaryColor,
          searchController: searchController,
          suggestionsBuilder: (context, controller) {
            final query = controller.text.toLowerCase();

            final filtred = widget.notes
                .where((note) => note.title.toLowerCase().contains(query))
                .toList();

            final results = filtred.map((note) {
              return ListTile(
                key: const Key(listTileResultSearchSuccessKey),
                title: Text(
                  note.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  didJustDismis = true;
                  controller.closeView(null);
                  FocusScope.of(context).unfocus();
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
                  key: const Key(listTileResultSearchFailureKey),
                  title: Text(
                    locale.no_notes,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ];
            }
            return results;
          },
        ),
      ),
    );
  }
}
