import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_state.dart';

class FavorietCubit extends Cubit<FavorietState> {
  FavorietCubit() : super(FavorietInitial());

  List<NoteModel> favorietNotesList = [];
  void fetchAllFavorietNotes({Box<NoteModel>? noteBox }) {
    Box<NoteModel> notesBox = noteBox ?? Hive.box<NoteModel>(kNotesBox);
    favorietNotesList = notesBox.values.where((note) => note.isFavoriet == true ).toList();
    emit(FavorietSucess(favorietNotes: favorietNotesList));
  }
}
