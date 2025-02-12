// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:strick_app/Models/dailyTaskModel.dart';
import 'package:strick_app/Services/dailyTasksService.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/myAlertBSheet.dart';

Dismissible MyDoneDismissible(
    {required BuildContext context,
    required int index,
    required Widget child,
    required VoidCallback refrech}) {
  return Dismissible(
      confirmDismiss: (direction) {
        return myAlertBSheet(context: context);
      },
      onDismissed: (direction) {
        deleteDoneDailyTasks(index: index);
        refrech();
      },
      background: Container(
        margin: EdgeInsets.only(bottom: 10, right: 15, left: 15),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      key: ValueKey<DailyTask>(doneDailyTaskList[index]),
      child: child);
}
