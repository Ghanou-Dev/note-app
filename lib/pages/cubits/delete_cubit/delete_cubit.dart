import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/delete_cubit/delete_state.dart';

class DeleteCubit extends Cubit<DeletedState> {
  DeleteCubit() : super(DeletedInitial());

  List<NoteModel> deletedNotesList = [];
  void fetchAllDeletedNotes() {
    Box<NoteModel> deletedNotesBox = Hive.box<NoteModel>(kDeletedNotes);
    deletedNotesList = deletedNotesBox.values.toList();
    emit(DeletedSuccess(deletedNotes: deletedNotesList));
  }

  Future<void> deleteNote({required NoteModel note}) async {
    await note.delete();
  }
}
