import 'package:notes/models/note_model.dart';

abstract class DisplayState {}

class DisplayInitial extends DisplayState {}

class DisplaySuccess extends DisplayState {
  final NoteModel note;
  DisplaySuccess({required this.note});
}
