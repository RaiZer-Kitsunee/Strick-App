// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:strick_app/Services/backUpService.dart';
import 'package:strick_app/Shared/allTheLists.dart';

Map<String, dynamic> data = {
  "tasks": filteredDailyTasks
      .map(
        (task) => task.toJson(),
      )
      .toList(),
  "notes": notesList
      .map(
        (note) => note.toJson(),
      )
      .toList(),
  "profile": profilelist
      .map(
        (profile) => profile.toJson(),
      )
      .toList(),
  "project": projectsList
      .map(
        (project) => project.toJson(),
      )
      .toList(),
};

void mybackUpBSheet({
  required BuildContext context,
  required VoidCallback refrech,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 170,
          child: Column(
            children: [
              //* title
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Text(
                  "What you want to do:",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //* button of save
                  backUpButton(
                    context: context,
                    icon: Icons.create_new_folder_rounded,
                    title: "Save BackUp",
                    onTap: () => saveBackup(data, context),
                  ),

                  SizedBox(width: 40),

                  //* button of load
                  backUpButton(
                    context: context,
                    icon: Icons.drive_folder_upload,
                    title: "Load BackUp",
                    onTap: () => loadBackup(context, () => refrech),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

GestureDetector backUpButton({
  required BuildContext context,
  required void Function()? onTap,
  required String title,
  required IconData? icon,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Icon(
            icon,
            size: 50,
          )
        ],
      ),
    ),
  );
}
