import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes/const.dart';
import 'package:notes/l10n/app_localizations.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/bottm_sheet_cubit/bottom_sheet_cubit.dart';
import 'package:notes/pages/cubits/delete_cubit/delete_cubit.dart';
import 'package:notes/pages/cubits/delete_cubit/delete_state.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_cubit.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_state.dart';
import 'package:notes/pages/cubits/home_cubit/home_cubit.dart';
import 'package:notes/pages/cubits/home_cubit/home_state.dart';
import 'package:notes/pages/deleted.dart';
import 'package:notes/pages/favoriet.dart';
import 'package:notes/pages/reminders.dart';
import 'package:notes/pages/settings.dart';
import 'package:notes/widgets/custom_body.dart';
import 'package:notes/widgets/custom_bottom_sheet.dart';
import 'package:notes/widgets/custom_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String pageRoute = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await precacheImage(const AssetImage('assets/images/logo.png'), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List<NoteModel> notesList = context.read<HomeCubit>().notes;
        List<NoteModel> favorietNotesList = context
            .read<FavorietCubit>()
            .favorietNotesList;
        List<NoteModel> deletedNotesList = context
            .read<DeleteCubit>()
            .deletedNotesList;
        if (state is HomeSuccess) {
          List<NoteModel> notes = state.notes;
          return homeBody(
            context,
            notes: notes,
            favorietNotes: favorietNotesList,
            deletedNotes: deletedNotesList,
            locale: locale,
          );
        }
        return homeBody(
          context,
          notes: notesList,
          favorietNotes: favorietNotesList,
          deletedNotes: deletedNotesList,
          locale: locale,
        );
      },
    );
  }

  Scaffold homeBody(
    BuildContext context, {
    required List<NoteModel> notes,
    required List<NoteModel> deletedNotes,
    required List<NoteModel> favorietNotes,
    required AppLocalizations locale,
  }) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          locale.keep_note,
          style: const TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
        ),
        iconTheme: const IconThemeData(color: secondaryColor),
        actions: [
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(40),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.light_mode, color: secondaryColor),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Stack(
                  alignment: locale.title == 'Title'
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.user,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: forthColor,
                            ),
                          ),
                          Text(
                            '${locale.to_day} : ${DateFormat('yyyy/MM/dd').format(DateTime.now())}',
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(color: forthColor),
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(HomePage.pageRoute);
                },
                hint: locale.all_notes,
                icon: FontAwesomeIcons.house,
                len: notes.length,
              ),
              BlocBuilder<FavorietCubit, FavorietState>(
                builder: (context, state) {
                  List<NoteModel> favorietNotes = context
                      .read<FavorietCubit>()
                      .favorietNotesList;
                  if (state is FavorietSucess) {
                    List<NoteModel> favorietNotes = state.favorietNotes;
                    return CustomListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Favoriet(favorietNotes: favorietNotes),
                          ),
                        );
                      },
                      hint: locale.favoriets,
                      icon: FontAwesomeIcons.star,
                      len: favorietNotes.length,
                    );
                  }
                  return CustomListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Favoriet(favorietNotes: favorietNotes),
                        ),
                      );
                    },
                    hint: locale.favoriets,
                    icon: FontAwesomeIcons.star,
                    len: favorietNotes.length,
                  );
                },
              ),
              CustomListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Reminders()),
                  );
                },
                hint: locale.reminders,
                icon: Icons.alarm,
                len: 0,
              ),
              BlocBuilder<DeleteCubit, DeletedState>(
                //////////////////////////////////////////////////
                builder: (context, state) {
                  List<NoteModel> deleteNotes = context
                      .read<DeleteCubit>()
                      .deletedNotesList;
                  if (state is DeletedSuccess) {
                    List<NoteModel> deleteNotes = state.deletedNotes;
                    return CustomListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Deleted(deletedNotes: deleteNotes),
                          ),
                        );
                      },
                      hint: locale.trash,
                      icon: FontAwesomeIcons.trash,
                      len: deleteNotes.length,
                    );
                  }
                  return CustomListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Deleted(deletedNotes: deleteNotes),
                        ),
                      );
                    },
                    hint: locale.trash,
                    icon: FontAwesomeIcons.trash,
                    len: deleteNotes.length,
                  );
                },
              ), /////////////////////////////////////////////////////////////////////////
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(color: forthColor),
              ),
              CustomListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                hint: locale.settings,
                icon: FontAwesomeIcons.gear,
                len: 0,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: BlocProvider(
                  create: (context) => BottomSheetCubit(),
                  child: const CustomBottomSheet(),
                ),
              );
            },
          );
        },
        backgroundColor: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CustomBody(notes: notes),
      ),
    );
  }
}
