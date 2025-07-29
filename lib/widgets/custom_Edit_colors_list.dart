import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/const.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/widgets/item_color.dart';

class CustomEditColorsList extends StatefulWidget {
  final NoteModel note;

  const CustomEditColorsList({required this.note, super.key});

  @override
  State<CustomEditColorsList> createState() => _CustomEditColorsListState();
}

class _CustomEditColorsListState extends State<CustomEditColorsList> {
  late int currentItem;

  @override
  void initState() {
    super.initState();
    currentItem = kColors.indexOf(widget.note.color);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: (44 * 2).h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: kColors.length,
          itemBuilder: (context, index) {
            bool isSelected = currentItem == index;
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: GestureDetector(
                onTap: () {
                  currentItem = index;
                  widget.note.color = kColors[currentItem];
                  setState(() {});
                },
                child: ItemColor(color: kColors[index], isSelected: isSelected),
              ),
            );
          },
        ),
      ),
    );
  }
}
