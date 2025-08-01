import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/const.dart';

class CustomEditTextField extends StatelessWidget {
  final String hint;
  final bool isTitle;
  final TextEditingController controller;
  const CustomEditTextField({
    required this.hint,
    required this.isTitle,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Theme(
        data: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: secondaryColor,
            selectionColor: Colors.green.shade200,
          ),
        ),
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.newline,
          maxLines: null,
          cursorColor: secondaryColor,
          style: TextStyle(
            fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
            color: Colors.black87,
          ),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            border: isTitle
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: const BorderSide(color: secondaryColor),
                  )
                : const UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor),
                  ),
            focusedBorder: isTitle
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide:const BorderSide(color: secondaryColor),
                  )
                : const UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor),
                  ),
            enabledBorder: isTitle
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: const BorderSide(color: Colors.grey),
                  )
                : const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
          ),
        ),
      ),
    );
  }
}