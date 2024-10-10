import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Models/simpleTaskModel.dart';
import 'package:strick_app/Shared/allTheLists.dart';

Future<void> saveIntoSp() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  //convert the data to json
  List<Map<String, dynamic>> jsonStringList =
      simpleTasksList.map((element) => element.toJson()).toList();
  List<Map<String, dynamic>> jsonStringDoneList =
      doneSimpleTaskList.map((element) => element.toJson()).toList();

  //convert the json to string
  String jsonString = jsonEncode(jsonStringList);
  String jsonStringDone = jsonEncode(jsonStringDoneList);

  //save the data into the shared preferences
  await pref.setString(doneSimpleTaskKey, jsonStringDone);
  await pref.setString(simpleTaskKey, jsonString);
}

//* add Simple Tasks
void addSimpleTasks({required String name}) {
  simpleTasksList.add(SimpleTask(title: name));
  saveIntoSp();
}

//* update Simple Tasks
void updateSimpleTasks({required String newTilte, required int index}) {
  simpleTasksList[index].title = newTilte;
  saveIntoSp();
}

//* delete Simple Tasks
void deleteSimpleTasks({required int index}) {
  simpleTasksList.removeAt(index);
  saveIntoSp();
}

//* delete Done Simple Tasks
void deleteDoneSimpleTasks({required int index}) {
  doneSimpleTaskList.removeAt(index);
  saveIntoSp();
}
