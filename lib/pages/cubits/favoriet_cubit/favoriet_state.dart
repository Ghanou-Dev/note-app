import 'package:notes/models/note_model.dart';

abstract class FavorietState {}

class FavorietInitial extends FavorietState {}

class FavorietSucess extends FavorietState {
  final List<NoteModel> favorietNotes;
  FavorietSucess({required this.favorietNotes});
}
