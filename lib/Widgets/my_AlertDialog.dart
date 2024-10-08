import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Text(
        "Delete",
        style: TextStyle(color: Theme.of(context).colorScheme.surface),
      ),
      content: Text(
        "Are You Sure You Want To Delete That ?",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.surface),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            dialogbutton(
                context: context,
                name: "Y E S",
                padding: EdgeInsets.only(left: 30),
                color: Theme.of(context).colorScheme.surface,
                booling: true),
            dialogbutton(
                context: context,
                name: "N O",
                padding: EdgeInsets.only(right: 30),
                color: Theme.of(context).colorScheme.surface,
                booling: false),
          ],
        )
      ],
    );
  }
}

Padding dialogbutton(
    {required BuildContext context,
    required String name,
    required EdgeInsetsGeometry padding,
    required Color color,
    required bool booling}) {
  return Padding(
    padding: padding,
    child: InkWell(
      onTap: () => Navigator.of(context).pop(booling),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: color),
        child: Text(
          name,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
