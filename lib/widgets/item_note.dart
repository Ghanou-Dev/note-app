import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/delete_cubit/delete_cubit.dart';
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: <Color>[therdColor, therdColor]),
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
                        fontSize: 18,
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
                    style: TextStyle(color: Colors.black45, fontSize: 17),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        var homeCubit = context.read<HomeCubit>();
                        // add note to dleted list ;
                        await homeCubit.deleteNote(note: note);
                        await homeCubit.addNoteToDeletedList(note: note);
                        // fetch all delted notes ...
                        context.read<DeleteCubit>().fetchAllDeletedNotes();
                        homeCubit.fetchAllNotes();
                      },
                      icon: Icon(FontAwesomeIcons.trash),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CircleAvatar(backgroundColor: Color(note.color)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
