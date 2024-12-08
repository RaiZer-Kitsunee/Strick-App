// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MySettingTile extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Widget? prefix;
  final bool isCustom;
  const MySettingTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.isCustom,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isCustom ? () {} : onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            isCustom
                ? prefix!
                : const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20,
                  )
          ],
        ),
      ),
    );
  }
}
