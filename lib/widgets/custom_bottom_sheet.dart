import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:notes/const.dart';
import 'package:notes/l10n/app_localizations.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/cubits/bottm_sheet_cubit/bottom_sheet_cubit.dart';
import 'package:notes/pages/cubits/home_cubit/home_cubit.dart';
import 'package:notes/widgets/custom_colors_list_view.dart';
import 'package:notes/widgets/custom_edit_text_field.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const CustomColorsListView(),
            CustomEditTextField(
              hint: locale.title,
              isTitle: true,
              controller: titleController,
            ),
            CustomEditTextField(
              hint: locale.note,
              isTitle: false,
              controller: noteController,
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () async {
                  String date = DateFormat('yyyy/mm/dd').format(DateTime.now());
                  int color = context.read<BottomSheetCubit>().color;
                  NoteModel note = NoteModel(
                    title: titleController.text,
                    content: noteController.text,
                    date: date,
                    color: color,
                  );
                  context.read<BottomSheetCubit>().addNote(note: note);
                  context.read<HomeCubit>().fetchAllNotes();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                ),
                child: Text(
                  locale.add,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
