// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Models/dailyTaskModel.dart';
import 'package:strick_app/Models/noteModel.dart';
import 'package:strick_app/Models/projectsModel.dart';
import 'package:strick_app/Screens/Original/startPage.dart';
import 'package:strick_app/Shared/allTheLists.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SharedPreferences pref;
  readTasksFromSp() async {
    pref = await SharedPreferences.getInstance();
    //* For simple tasks
    String? loadedStringList = pref.getString(dailyTaskKey);
    String? loadedStringDoneList = pref.getString(doneDailyTaskKey);
    String? loadedStringProjectList = pref.getString(projectKey);

    List<dynamic>? loadedJsonList = jsonDecode(loadedStringList!);
    List<dynamic>? loadedJsonDoneList = jsonDecode(loadedStringDoneList!);
    List<dynamic>? loadedJsonProjectList = jsonDecode(loadedStringProjectList!);

    filteredDailyTasks = dailyTasksList =
        loadedJsonList!.map((element) => DailyTask.fromJson(element)).toList();
    doneDailyTaskList = loadedJsonDoneList!
        .map((element) => DailyTask.fromJson(element))
        .toList();
    projectsList = loadedJsonProjectList!
        .map((element) => Projects.fromJson(element))
        .toList();
    setState(() {});
  }

  readNotesFromSp() async {
    //* for simple notes
    pref = await SharedPreferences.getInstance();
    String? loadedStringList = pref.getString(notesKey);
    if (loadedStringList != null) {
      List<dynamic> loadedJsonList = jsonDecode(loadedStringList);
      notesList =
          loadedJsonList.map((element) => Note.fromJson(element)).toList();
      setState(() {});
    }
  }

  readLevelFromSp() async {
    pref = await SharedPreferences.getInstance();
    myProfile.xp = pref.getInt(xpKey)!;
    myProfile.level = pref.getInt(levelKey)!;
    myProfile.xpToNextLevel = pref.getInt(xpToNextLevelKey)!;
  }

  void loadImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    myProfile.image = pref.getString("Pimage") ?? "";
  }

  void loadName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    myProfile.name = pref.getString("PName") ?? "ME!!";
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
    readTasksFromSp();
    readNotesFromSp();
    readLevelFromSp();
    loadImage();
    loadName();
    Future.delayed(
      Duration(milliseconds: 50),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => StartPage(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 195),
              child: Image.asset(
                "assets/cube-3d.png",
                scale: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Text(
                "S T R I C K",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
