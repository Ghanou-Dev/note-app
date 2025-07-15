import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/l10n/app_localizations.dart';
import 'package:notes/pages/cubits/display_cubit/display_cubit.dart';
import 'package:notes/pages/cubits/display_cubit/display_state.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_cubit.dart';
import 'package:notes/pages/cubits/home_cubit/home_cubit.dart';
import 'package:notes/widgets/custom_Edit_colors_list.dart';
import '../const.dart';
import '../models/note_model.dart';
import '../widgets/custom_edit_text_field.dart';

class DisplayNote extends StatefulWidget {
  final NoteModel note;
  const DisplayNote({required this.note, super.key});

  @override
  State<DisplayNote> createState() => _DisplayNoteState();
}

class _DisplayNoteState extends State<DisplayNote> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  /////////////////////////////////////////////
  late NoteModel editableNote;
  /////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
    /////////////////////////////////////////////
    editableNote = NoteModel(
      title: widget.note.title,
      content: widget.note.content,
      date: widget.note.date,
      color: widget.note.color,
      isFavoriet: widget.note.isFavoriet,
    );
    /////////////////////////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayCubit, DisplayState>(
      builder: (context, state) {
        if (state is DisplaySuccess) {
          NoteModel noteItem = state.note;
          return displayBody(context, note: noteItem);
        }
        return displayBody(context, note: widget.note);
      },
    );
  }

  Scaffold displayBody(BuildContext context, {required NoteModel note}) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          locale.edit,
          style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              editableNote.isFavoriet = !editableNote.isFavoriet;
              //////////////////////////////////////////////////////////////////
              context.read<HomeCubit>().fetchAllNotes();
              context.read<FavorietCubit>().fetchAllFavorietNotes();
              //////////////////////////////////////////////////////////////////
              setState(() {});
            },
            icon: Icon(
              editableNote.isFavoriet ? Icons.star : Icons.star_border,
              color: secondaryColor,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        onPressed: () async {
          // 1. اجلب النص من الحقول وضعه داخل editableNote
          editableNote.title = titleController.text;
          editableNote.content = contentController.text;
          // استدعاء Cubit لفصل المنطق عن الواجهة
          await context.read<DisplayCubit>().editNote(
            note: widget.note, // الكائن الأصلي من Hive
            title: editableNote.title,
            content: editableNote.content,
            color: editableNote.color,
            isFavoriet: editableNote.isFavoriet,
          );
          // حدّث الصفحة الرئيسيّة
          context.read<HomeCubit>().fetchAllNotes();
          // fetch all favoriet notes ....
          context.read<FavorietCubit>().fetchAllFavorietNotes();
          Navigator.pop(context);
        },
        child: Icon(FontAwesomeIcons.check, color: primaryColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomEditColorsList(note: editableNote),
            CustomEditTextField(
              hint: locale.title,
              controller: titleController,
              isTitle: true,
            ),
            CustomEditTextField(
              hint: locale.note,
              controller: contentController,
              isTitle: false,
            ),
          ],
        ),
      ),
    );
  }
}
