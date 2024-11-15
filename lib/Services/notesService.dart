import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Models/noteModel.dart';
import 'package:strick_app/Shared/allTheLists.dart';

Future<void> saveIntoSp() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  //convert the data to json
  List<Map<String, dynamic>> jsonStringList =
      notesList.map((element) => element.toJson()).toList();
  print(jsonStringList);
  //convert the json to string
  String jsonString = jsonEncode(jsonStringList);
  print(jsonString);

  //save the data into the shared preferences
  await pref.setString(notesKey, jsonString);
}

void addNote({
  required String title,
  required String note,
}) {
  notesList.add(
    Note(
      title: title,
      note: note,
      color: Colors.transparent,
    ),
  );
  saveIntoSp();
  print("save done");
}

void updateNote({
  required int index,
  required String newTitle,
  required String newNote,
}) {
  notesList[index].title = newTitle;
  notesList[index].note = newNote;
  saveIntoSp();
  print("save done");
}

void deleteNote({required int index}) {
  notesList.removeAt(index);
  saveIntoSp();
  print("save done");
}
