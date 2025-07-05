import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20.0),
        child: Row(
          children: <Widget>[
            Icon(icon, color: secondaryColor),
            SizedBox(width: 15),
            Text(
              hint,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black87,
              ),
            ),
            Spacer(),
            len > 0
                ? CircleAvatar(
                    radius: 13,
                    backgroundColor: forthColor,
                    child: Text(
                      '$len',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  )
                : Spacer(),
          ],
        ),
      ),
    );
  }
}
