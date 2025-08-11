import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_cubit.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_state.dart';
import 'package:notes/pages/cubits/home_cubit/home_cubit.dart';
import 'package:notes/pages/cubits/home_cubit/home_state.dart';

void main() {
  late Box<NoteModel> noteBox;
  late Box<NoteModel> favorietNoteBox;
  setUp(() async {
    await setUpTestHive();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NoteModelAdapter());
    }
    noteBox = await Hive.openBox<NoteModel>('notesBox');
    favorietNoteBox = await Hive.openBox<NoteModel>('favorietNoteBox');
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  // Test HomeCubit
  group('testing HomeCubit methods ', () {
    blocTest<HomeCubit, HomeState>(
      'should emit HomeSuccess when notes are fetched ',
      build: () => HomeCubit(),
      act: (cubit) => cubit.fetchAllNotes(noteBox: noteBox),
      expect: () => [isA<HomeSuccess>()],
    );

    test('should be add note to List', () async {
      final noteBox = await Hive.openBox<NoteModel>(kNotesBox);
      final homeCubit = HomeCubit();
      final note = NoteModel(
        title: 'title',
        content: 'content',
        date: 'date',
        color: 0xffffff,
      );
      await homeCubit.addNoteToList(note: note);

      // اجراء التحقق
      expect(noteBox.values.length, 1);
      expect(noteBox.values.first.title, 'title');
    });

    test('should be add note to deleteNotesList', () async {
      final deleteNoteBox = await Hive.openBox<NoteModel>(kDeletedNotes);
      final homeCubit = HomeCubit();
      final note = NoteModel(
        title: 'title',
        content: 'content',
        date: 'date',
        color: 0xffffff,
      );

      await deleteNoteBox.clear();
      await homeCubit.addNoteToDeletedList(note: note);

      // اجراء التحقق
      expect(deleteNoteBox.values.length, 1);
      expect(deleteNoteBox.values.first.content, equals('content'));
    });

    test('should be delet note from notesBox', () async {
      final notesBox = await Hive.openBox<NoteModel>(kNotesBox);
      final homeCubit = HomeCubit();
      final note = NoteModel(
        title: 'title',
        content: 'content',
        date: 'date',
        color: 0xffffff,
      );
      await notesBox.clear();
      await notesBox.add(note);
      expect(notesBox.values.length, 1);

      await homeCubit.deleteNote(note: note);
      expect(notesBox.values.isEmpty, true);
    });
  });

  // test FavorietCubit
  group('testing methods in FavorietCubit', () {
    setUp(() {
      favorietNoteBox.add(
        NoteModel(
          title: 'favorietNote',
          content: 'note',
          date: '2025',
          color: 0xff0000,
          isFavoriet: true,
        ),
      );
    });
    blocTest<FavorietCubit, FavorietState>(
      'should emit FavorietSucess when notes are fetched',
      build: () => FavorietCubit(),
      act: (cubit) => cubit.fetchAllFavorietNotes(noteBox: favorietNoteBox),
      expect: () => [isA<FavorietSucess>()],
    );
  });
}
