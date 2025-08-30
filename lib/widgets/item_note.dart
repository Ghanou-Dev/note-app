import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/const.dart';
import 'package:notes/l10n/app_localizations.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/delete_cubit/delete_cubit.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_cubit.dart';
import 'package:notes/pages/cubits/home_cubit/home_cubit.dart';
import 'package:notes/pages/display_note.dart';

class ItemNote extends StatelessWidget {
  final NoteModel note;
  const ItemNote({required this.note, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressUp: () {},
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DisplayNote(note: note)),
        );
      },
      child: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: const LinearGradient(colors: <Color>[therdColor, therdColor]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          note.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        note.content,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 17.sp,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return DeleteDialog(note: note);
                              },
                            );
                          },
                          icon: const Icon(FontAwesomeIcons.trash),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CircleAvatar(
                            backgroundColor: Color(note.color),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DeleteDialog extends StatelessWidget {
  final NoteModel note;
  const DeleteDialog({required this.note, super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocale = AppLocalizations.of(context)!;
    return AlertDialog(
      backgroundColor: primaryColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              appLocale.delete,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: secondaryColor,
              ),
            ),
          ),
          Text(appLocale.delete_dialog),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            foregroundColor: primaryColor,
          ),
          onPressed: () async {
            var homeCubit = context.read<HomeCubit>();
            // add note to dleted list ;
            await homeCubit.deleteNote(note: note);
            await homeCubit.addNoteToDeletedList(note: note);
            // fetch all delted notes ...
            context.read<DeleteCubit>().fetchAllDeletedNotes();
            homeCubit.fetchAllNotes();
            ////////////////////////////////////////////////////////////////////
            context.read<FavorietCubit>().fetchAllFavorietNotes();
            //////////////////////////////////////////////////////////////////
            Navigator.pop(context);
          },
          child: Text(appLocale.contine),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(appLocale.cancle),
        ),
      ],
    );
  }
}
