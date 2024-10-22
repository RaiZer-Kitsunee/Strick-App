import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Models/projectTasks.dart';
import 'package:strick_app/Models/projectsModel.dart';
import 'package:strick_app/Shared/allTheLists.dart';

Future<void> saveIntoSp() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  //convert the data to json
  List<Map<String, dynamic>> jsonStringList =
      projectsList.map((element) => element.toJson()).toList();

  //convert the json to string
  String jsonString = jsonEncode(jsonStringList);

  //save the data into the shared preferences
  await pref.setString(projectKey, jsonString);
}

//* so that how to create add a project box
void addProject({required String title, required String object}) {
  projectsList.add(
    Projects(
      title: title,
      object: object,
      inerTasks: [],
    ),
  );
  saveIntoSp();
}

//* and this to delete Projects
void deleteProject({required int index}) {
  projectsList.removeAt(index);
  saveIntoSp();
}

int? fkindex;

int isIndex({required int index}) {
  return fkindex = index;
}

//* what is i dont like the title
void updateProjectTitle({required int projectIndex, required String newTitle}) {
  projectsList[projectIndex].title = newTitle;
  saveIntoSp();
}

//* this will add a task to the project
void addProjectTask({
  required int projectIndex,
  required String title,
}) {
  projectsList[projectIndex].inerTasks.add(
        ProjectTasks(
          title: title,
          isFirst: fkindex == 0 ? true : false,
          isLast: fkindex == projectsList[projectIndex].inerTasks.length - 1
              ? true
              : false,
          isDone: false,
        ),
      );
  saveIntoSp();
}

//* let delete some Project tasks
void deleteProjectTask({required int projectIndex, required int taskIndex}) {
  projectsList[projectIndex].inerTasks.removeAt(taskIndex);
  saveIntoSp();
}

//* wana change that okey
void updateProjectTask({
  required int projectIndex,
  required int taskIndex,
  required String newTitle,
}) {
  projectsList[projectIndex].inerTasks[taskIndex].title = newTitle;
  saveIntoSp();
}
