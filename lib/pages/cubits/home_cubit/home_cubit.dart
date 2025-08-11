import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  // logic ..
  List<NoteModel> notes = [];

  void fetchAllNotes({Box<NoteModel>? noteBox}) {
    Box<NoteModel> notesBox = noteBox ?? Hive.box<NoteModel>(kNotesBox);
    notes = notesBox.values.toList();
    emit(HomeSuccess(notes: notes));
  }

  Future<void> deleteNote({required NoteModel note}) async {
    await note.delete();
  }

  Future<void> addNoteToDeletedList({required NoteModel note}) async {
    Box<NoteModel> deletedNotes = Hive.box(kDeletedNotes);
    await deletedNotes.add(note);
  }

  Future<void> addNoteToList({required NoteModel note}) async {
    Box<NoteModel> notesBox = Hive.box<NoteModel>(kNotesBox);
    await notesBox.add(note);
  }
}
