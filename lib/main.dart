import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notes/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Bloc.observer = SipmleBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);
  await Hive.openBox<NoteModel>(kDeletedNotes);
  SharedPreferences prf = await SharedPreferences.getInstance();
  bool isEn = prf.getBool(kLangEn) ?? true;
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return Notes(isEn: isEn);
      },
    ),
  );
}

class Notes extends StatefulWidget {
  final bool isEn;
  const Notes({required this.isEn, super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _NotesState? state = context.findAncestorStateOfType<_NotesState>();
    state?.changeLocale(newLocale);
  }

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    setState(() {
      _locale = widget.isEn ? Locale('en') : Locale('ar');
    });
  }

  void changeLocale(Locale newLocal) {
    setState(() {
      _locale = newLocal;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return ScreenUtilInit(
      designSize: Size(width, height),
      minTextAdapt: true,

      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeCubit()),
            BlocProvider(create: (context) => DisplayCubit()),
            BlocProvider(create: (context) => FavorietCubit()),
            BlocProvider(create: (context) => DeleteCubit()),
          ],
          child: MaterialApp(
            locale: _locale,
            supportedLocales: [Locale('en'), Locale('ar')],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            ////////////////////////////////////////////////////////////////////////
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: Splash.pageRoute,
            routes: {
              Splash.pageRoute: (context) => const Splash(),
              HomePage.pageRoute: (context) => const HomePage(),
            },
          ),
        );
      },
    );
  }
}
