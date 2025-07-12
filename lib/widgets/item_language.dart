import 'package:flutter/material.dart';

class ItemLanguage extends StatelessWidget {
  final String language;
  final bool isActive;
  final void Function() onTap;
  const ItemLanguage({
    required this.language,
    required this.onTap,
    required this.isActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Icon(Icons.language),
            const SizedBox(width: 10),
            Text(language),
            const Spacer(),
            Checkbox(
              value: isActive,
              onChanged: (value) {
                onTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}
