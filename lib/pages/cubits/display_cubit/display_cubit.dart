import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/display_cubit/display_state.dart';

class DisplayCubit extends Cubit<DisplayState> {
  DisplayCubit() : super(DisplayInitial());

  // logic
  Future<void> editNote({
    required NoteModel note,
    required String title,
    required String content,
    required int color,
    required bool isFavoriet,
  }) async {
    note.title = title;
    note.content = content;
    note.color = color;
    note.isFavoriet = isFavoriet;

    await note.save();
    emit(DisplaySuccess(note: note));
  }

  // Future<void> addDeletedNoteToFavorietList({required NoteModel note}) async {
  //   bool isSelected = note.isFavoriet;
  //   Box<NoteModel> favorietNotes = Hive.box(kFavorietNotes);
    
  // }
}
