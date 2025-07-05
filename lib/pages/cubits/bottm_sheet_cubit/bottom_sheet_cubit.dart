import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/bottm_sheet_cubit/bottom_sheet_state.dart';

class BottomSheetCubit extends Cubit<BottomSheetState> {
  BottomSheetCubit() : super(BottomSheetInitial());
  
  int color = 0xff669bbc;
  Future<void> addNote({required NoteModel note})async{
    Box<NoteModel> notesBox = Hive.box<NoteModel>(kNotesBox);
    await notesBox.add(note);
    
  }
}
