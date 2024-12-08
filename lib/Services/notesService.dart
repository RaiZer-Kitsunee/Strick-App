// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Models/noteModel.dart';
import 'package:strick_app/Shared/allTheLists.dart';

Future<void> saveNotesIntoSp() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  //convert the data to json
  List<Map<String, dynamic>> jsonStringList =
      notesList.map((element) => element.toJson()).toList();
  //convert the json to string
  String jsonString = jsonEncode(jsonStringList);

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
  saveNotesIntoSp();
  print("save done");
}

void updateNote({
  required int index,
  required String newTitle,
  required String newNote,
}) {
  notesList[index].title = newTitle;
  notesList[index].note = newNote;
  saveNotesIntoSp();
  print("save done");
}

void deleteNote({required int index}) {
  notesList.removeAt(index);
  saveNotesIntoSp();
  print("save done");
}
