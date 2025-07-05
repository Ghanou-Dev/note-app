import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes/const.dart';
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
  Widget build(BuildContext context) {
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
          );
        }
        return homeBody(
          context,
          notes: notesList,
          favorietNotes: favorietNotesList,
          deletedNotes: deletedNotesList,
        );
      },
    );
  }

  Scaffold homeBody(
    BuildContext context, {
    required List<NoteModel> notes,
    required List<NoteModel> deletedNotes,
    required List<NoteModel> favorietNotes,
  }) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Keep Note',
          style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
        ),
        iconTheme: IconThemeData(color: secondaryColor),
        actions: [
          InkWell(
            onTap: () {
              debugPrint('kkkkk');
            },
            borderRadius: BorderRadius.circular(40),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                radius: 24,
                child: Icon(FontAwesomeIcons.circleUser, color: therdColor),
              ),
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
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User ',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: forthColor,
                            ),
                          ),
                          Text(
                            'ToDay : ${DateFormat('yyyy/MM/dd').format(DateTime.now())}',
                            style: TextStyle(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(color: forthColor),
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(HomePage.pageRoute);
                },
                hint: 'All Notes',
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
                      hint: 'Favorites',
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
                    hint: 'Favorites',
                    icon: FontAwesomeIcons.star,
                    len: favorietNotes.length,
                  );
                },
              ),
              CustomListTile(
                onTap: () {},
                hint: 'Reminders',
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
                      hint: 'Trash',
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
                    hint: 'Trash',
                    icon: FontAwesomeIcons.trash,
                    len: deleteNotes.length,
                  );
                },
              ), /////////////////////////////////////////////////////////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(color: forthColor),
              ),
              CustomListTile(
                onTap: () {},
                hint: 'Settings',
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
              borderRadius: BorderRadius.circular(20),
            ),
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: BlocProvider(
                  create: (context) => BottomSheetCubit(),
                  child: CustomBottomSheet(),
                ),
              );
            },
          );
        },
        backgroundColor: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: CustomBody(notes: notes),
    );
  }
}
