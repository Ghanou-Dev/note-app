import 'package:notes/models/note_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeInitial {
  final List<NoteModel> notes;
  HomeSuccess({required this.notes});
}
