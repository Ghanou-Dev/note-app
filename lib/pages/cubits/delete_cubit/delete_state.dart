import 'package:notes/models/note_model.dart';

abstract class DeletedState {}

class DeletedInitial extends DeletedState {}

class DeletedSuccess extends DeletedState {
  final List<NoteModel> deletedNotes;
  DeletedSuccess({required this.deletedNotes});
}
