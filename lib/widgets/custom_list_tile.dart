import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/const.dart';

class CustomListTile extends StatelessWidget {
  final String hint;
  final int len;
  final IconData icon;
  final void Function()? onTap;
  const CustomListTile({
    required this.hint,
    required this.icon,
    required this.len,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.0.h),
        child: Row(
          children: <Widget>[
            Icon(icon, color: secondaryColor),
            SizedBox(width: 15.w),
            Text(
              hint,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            len > 0
                ? CircleAvatar(
                    radius: 13.r,
                    backgroundColor: forthColor,
                    child: Text(
                      '$len',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  )
                : const Spacer(),
          ],
        ),
      ),
    );
  }
}
