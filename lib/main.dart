import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/delete_cubit/delete_cubit.dart';
import 'package:notes/pages/cubits/display_cubit/display_cubit.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_cubit.dart';
import 'package:notes/pages/cubits/home_cubit/home_cubit.dart';
import 'package:notes/pages/home_page.dart';
import 'package:notes/pages/splash.dart';
import 'package:notes/sipmle_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Bloc.observer = SipmleBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);
  await Hive.openBox<NoteModel>(kFavorietNotes);
  await Hive.openBox<NoteModel>(kDeletedNotes);
  runApp(Notes());
}

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => DisplayCubit()),
        BlocProvider(create: (context) => FavorietCubit()),
        BlocProvider(create: (context) => DeleteCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Splash.pageRoute,
        routes: {
          Splash.pageRoute: (context) => const Splash(),
          HomePage.pageRoute: (context) => const HomePage(),
        },
      ),
    );
  }
}
