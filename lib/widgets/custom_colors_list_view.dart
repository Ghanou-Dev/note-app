import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/const.dart';
import 'package:notes/pages/cubits/bottm_sheet_cubit/bottom_sheet_cubit.dart';
import 'package:notes/widgets/item_color.dart';

class CustomColorsListView extends StatefulWidget {
  const CustomColorsListView({super.key});

  @override
  State<CustomColorsListView> createState() => _CustomColorsListViewState();
}

class _CustomColorsListViewState extends State<CustomColorsListView> {
  int currentItem = 0;

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
                  context.read<BottomSheetCubit>().color = kColors[currentItem];
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
