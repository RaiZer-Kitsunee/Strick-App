import 'package:flutter/material.dart';
import 'package:strick_app/Models/simpleTaskModel.dart';
import 'package:strick_app/Services/simpleTasksService.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/my_AlertDialog.dart';

Dismissible MyDismissible(
    {required BuildContext context,
    required int index,
    required Widget child,
    required VoidCallback refrech}) {
  return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
            context: context, builder: (context) => MyAlertDialog());
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
