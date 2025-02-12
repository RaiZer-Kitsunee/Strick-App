// ignore_for_file: file_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Models/dailyTaskModel.dart';
import 'package:strick_app/Shared/allTheLists.dart';

Future<void> saveTasksIntoSp() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  //convert the data to json
  List<Map<String, dynamic>> jsonStringList =
      dailyTasksList.map((element) => element.toJson()).toList();
  List<Map<String, dynamic>> jsonStringDoneList =
      doneDailyTaskList.map((element) => element.toJson()).toList();

  //convert the json to string
  String jsonString = jsonEncode(jsonStringList);
  String jsonStringDone = jsonEncode(jsonStringDoneList);

  //save the data into the shared preferences
  await pref.setString(doneDailyTaskKey, jsonStringDone);
  await pref.setString(dailyTaskKey, jsonString);
}

//* add Simple Tasks
void addDailyTasks(
    {required String name, required String descrption, required bool isMain}) {
  dailyTasksList.add(
    DailyTask(
      title: name,
      descrption: descrption,
      xp: myProfile.addRandomXp(true),
      isMain: isMain,
    ),
  );
  saveTasksIntoSp();
}

//* update Simple Tasks
void updateDailyTasks({
  required String newTilte,
  required String newDisciption,
  required int index,
}) {
  dailyTasksList[index].title = newTilte;
  dailyTasksList[index].descrption = newDisciption;
  saveTasksIntoSp();
}

//* delete Simple Tasks
void deleteDailyTasks({required int index}) {
  dailyTasksList.removeAt(index);
  saveTasksIntoSp();
}

//* delete Done Simple Tasks
void deleteDoneDailyTasks({required int index}) {
  doneDailyTaskList.removeAt(index);
  saveTasksIntoSp();
}
