import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/delete_cubit/delete_cubit.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_cubit.dart';
import 'package:notes/pages/cubits/home_cubit/home_cubit.dart';

class ItemDeletedNote extends StatelessWidget {
  final NoteModel deletedNote;
  const ItemDeletedNote({required this.deletedNote, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
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
                      deletedNote.title,
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
                    deletedNote.content,
                    style: TextStyle(color: Colors.black45, fontSize: 17.sp),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        await context.read<DeleteCubit>().deleteNote(
                          note: deletedNote,
                        );
                        context.read<HomeCubit>().fetchAllNotes();
                        context.read<DeleteCubit>().fetchAllDeletedNotes();
                      },
                      icon: Icon(FontAwesomeIcons.trash),
                    ),
                    IconButton(
                      onPressed: () async {
                        // remove frome delet
                        await context.read<DeleteCubit>().deleteNote(
                          note: deletedNote,
                        );
                        // add note to list
                        await context.read<HomeCubit>().addNoteToList(
                          note: deletedNote,
                        );
                        // restart lists
                        context.read<DeleteCubit>().fetchAllDeletedNotes();
                        context.read<HomeCubit>().fetchAllNotes();
                        ////////////////////////////////////////////////////////
                        context.read<FavorietCubit>().fetchAllFavorietNotes(); 
                      },
                      icon: Icon(Icons.refresh, color: secondaryColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CircleAvatar(
                        backgroundColor: Color(deletedNote.color),
                      ),
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
