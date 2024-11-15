import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Models/noteModel.dart';
import 'package:strick_app/Screens/Original/startPage.dart';
import 'package:strick_app/Shared/allTheLists.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  readNotesFromSp() async {
    //* for simple notes
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? loadedStringList = pref.getString(notesKey);
    List<dynamic> loadedJsonList = jsonDecode(loadedStringList!);
    notesList =
        loadedJsonList.map((element) => Note.fromJson(element)).toList();
    setState(() {});
  }

  void loadImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    myProfile.image = pref.getString("Pimage")!;
  }

  void loadName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    myProfile.name = pref.getString("PName")!;
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
    readNotesFromSp();
    loadImage();
    loadName();
    Future.delayed(
      Duration(seconds: 2),
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
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 205),
              child: Icon(
                Icons.app_registration,
                size: 120,
                color: Theme.of(context).colorScheme.surface,
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
