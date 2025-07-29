import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemColor extends StatefulWidget {
  final bool isSelected;
  final int color;
  const ItemColor({this.isSelected = false, required this.color, super.key});

  @override
  State<ItemColor> createState() => _ItemColorState();
}

class _ItemColorState extends State<ItemColor> {
  @override
  Widget build(BuildContext context) {
    return widget.isSelected
        ? CircleAvatar(
            backgroundColor: Colors.black87,
            radius: 38.r,
            child: CircleAvatar(
              backgroundColor: Color(widget.color),
              radius: 34.r,
            ),
          )
        : CircleAvatar(backgroundColor: Color(widget.color), radius: 38.r);
  }
}
