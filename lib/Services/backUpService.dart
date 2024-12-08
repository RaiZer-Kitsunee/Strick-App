// ignore_for_file: avoid_print, avoid_returning_null_for_void, unnecessary_string_interpolations, use_build_context_synchronously, file_names

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Models/dailyTaskModel.dart';
import 'package:strick_app/Models/noteModel.dart';
import 'package:strick_app/Models/profileModel.dart';
import 'package:strick_app/Models/projectsModel.dart';
import 'package:strick_app/Services/dailyTasksService.dart';
import 'package:strick_app/Services/notesService.dart';
import 'package:strick_app/Services/projectService.dart';
import 'package:strick_app/Shared/allTheLists.dart';

void saveProfileToSp(Profile myProfile) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("Pimage", myProfile.image);
  pref.setString("PName", myProfile.name);
  pref.setInt(levelKey, myProfile.level);
  pref.setInt(xpKey, myProfile.xp);
  pref.setInt(xpToNextLevelKey, myProfile.xpToNextLevel);
}

Future<void> saveBackup(Map<String, dynamic> data, BuildContext context) async {
  try {
    // Request storage permission
    var status = await Permission.storage.request();
    if (status.isGranted) {
      print('Storage permission granted.');
    } else if (status.isDenied) {
      print('Storage permission denied.');
    } else if (status.isPermanentlyDenied) {
      print('Storage permission permanently denied.');
      // Open app settings to let the user manually enable permission
      await openAppSettings();
    }

    String? jsonString = jsonEncode(data);

    //* select the directory place
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      // Create the file path
      String filePath = '$selectedDirectory/tasks_backup.json';

      // Save the JSON string to the file
      File file = File(filePath);
      await file.writeAsString(jsonString);

      print('Backup saved at: ${file.path}');

      //* show a dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Backup save secsessfly"),
          content: Text("${file.path}"),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    } else {
      print('No directory selected.');
    }
  } catch (e) {
    //* show a dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error saving backup"),
        content: Text("$e"),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
    print("Error saving backup: $e");
  }
}

Future<void> loadBackup(BuildContext context, VoidCallback refrech) async {
  try {
    // Pick backup file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result != null) {
      print("No file selected");
      // Get the file path
      String? filePath = result.files.single.path;
      if (filePath != null) {
        File file = File(filePath);
        String content = await file.readAsString();

        // Parse JSON data
        Map<String, dynamic> data = jsonDecode(content);

        dailyTasksList = (data['tasks'] as List)
            .map(
              (taskjson) => DailyTask.fromJson(taskjson),
            )
            .toList();

        notesList = (data['notes'] as List)
            .map(
              (notejson) => Note.fromJson(notejson),
            )
            .toList();

        profilelist = (data['profile'] as List)
            .map(
              (profilejson) => Profile.fromJson(profilejson),
            )
            .toList();

        myProfile = profilelist[0];

        projectsList = (data['project'] as List)
            .map(
              (projectjson) => Projects.fromJson(projectjson),
            )
            .toList();

        print("Backup loaded successfully");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Backup loaded secsessfly"),
            content: Text("${file.path}"),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
        saveNotesIntoSp();
        saveProjectIntoSp();
        saveTasksIntoSp();
        saveProfileToSp(myProfile);
      }
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error loading backup"),
        content: Text("$e"),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
    print("Error loading backup: $e");
  }
}
