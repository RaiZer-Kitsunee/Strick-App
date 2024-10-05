import 'package:flutter/material.dart';
import 'package:strick_app/Models/simpleTaskModel.dart';
import 'package:strick_app/Services/simpleTasksService.dart';
import 'package:strick_app/Shared/allTheLists.dart';

Dismissible MyDismissible(
    {required BuildContext context,
    required int index,
    required Widget child,
    required VoidCallback refrech}) {
  return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
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
                      color: Colors.black,
                      booling: true),
                  dialogbutton(
                      context: context,
                      name: "N O",
                      padding: EdgeInsets.only(right: 30),
                      color: Colors.black,
                      booling: false),
                ],
              )
            ],
          ),
        );
      },
      onDismissed: (direction) {
        deleteSimpleTasks(index: index);
        refrech();
      },
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      key: ValueKey<SimpleTask>(simpleTasksList[index]),
      child: child);
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
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    ),
  );
}
