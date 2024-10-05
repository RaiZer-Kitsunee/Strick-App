// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Models/simpleTaskModel.dart';
import 'package:strick_app/Services/projectService.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/my_BSheet.dart';
import 'package:strick_app/Widgets/my_Dismissible.dart';
import 'package:strick_app/Widgets/my_SearchBar.dart';
import 'package:strick_app/Widgets/my_Slider.dart';
import 'package:strick_app/Widgets/my_TaskWidgat.dart';
import 'package:strick_app/Widgets/my_titles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool selected = false;

  TextEditingController projectsController = TextEditingController();

  late SharedPreferences pref;

  getShearedPref() async {
    pref = await SharedPreferences.getInstance();
    readFromSp();
  }

  readFromSp() {
    //* For simple tasks
    String? loadedStringList = pref.getString(simpleTaskKey);

    List<dynamic> loadedJsonList = jsonDecode(loadedStringList!);

    simpleTasksList =
        loadedJsonList.map((element) => SimpleTask.fromJson(element)).toList();
    setState(() {});
  }

  @override
  void initState() {
    getShearedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hey RaiZer !",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 250,
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              "Let's make some tasks",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              height: 60,
                              width: 60,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 45,
                          right: 65,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(top: 170, child: MySearchBar())
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 1.50,
            child: ListView(
              children: [
                MyTitles(
                  title1: "Projects",
                  title2: "Add Project",
                  selected: selected,
                  textEditingController: projectsController,
                  onPressedBack: () {
                    setState(() {
                      selected = !selected;
                      projectsController.clear();
                    });
                  },
                  onPressedAdd: () {
                    addProject(
                        title: projectsController.text,
                        object: "in till i do object");
                    setState(() {
                      projectsController.clear();
                      selected = !selected;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      _snakbar(),
                    );
                  },
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                ),
                const SizedBox(height: 10),
                const MySlider(),
                const SizedBox(height: 10),
                MyTitles(
                  title1: "Tasks",
                  title2: "Add Task",
                  selected: false,
                  textEditingController: projectsController,
                  onTap: () => myBSheet(context, () => setState(() {})),
                ),
                const SizedBox(height: 10),
                simpleTasksList.isEmpty
                    ? IfThereISNothing()
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: simpleTasksList.length,
                        itemBuilder: (context, index) {
                          return MyDismissible(
                            context: context,
                            index: index,
                            child: MyTaskWidget(
                              title: simpleTasksList[index].title,
                              simpleindex: index,
                              refrech: () => setState(() {}),
                            ),
                            refrech: () => setState(() {}),
                          );
                        })
              ],
            ),
          ),
        ],
      ),
    );
  }

  SnackBar _snakbar() {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 10),
      backgroundColor: Theme.of(context).colorScheme.surface,
      content: Text(
        "you have to go to setting or reset the app",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}

class IfThereISNothing extends StatelessWidget {
  const IfThereISNothing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Text(
              "Let Start With Simple Task",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            Icon(
              Icons.task,
              size: 30,
              color: Theme.of(context).colorScheme.surface,
            )
          ],
        ),
      ),
    );
  }
}
