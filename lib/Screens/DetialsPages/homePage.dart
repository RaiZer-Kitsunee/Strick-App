// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Models/projectsModel.dart';
import 'package:strick_app/Models/dailyTaskModel.dart';
import 'package:strick_app/Services/projectService.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/my_BSheet.dart';
import 'package:strick_app/Widgets/my_Dismissible.dart';
import 'package:strick_app/Widgets/my_DoneDismissible.dart';
import 'package:strick_app/Widgets/my_DoneTaskWidget.dart';
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
  bool isOnlyTask = false;

  TextEditingController projectsController = TextEditingController();

  late SharedPreferences pref;

  getShearedPref() async {
    pref = await SharedPreferences.getInstance();
    readFromSp();
  }

  readFromSp() {
    //* For simple tasks
    String? loadedStringList = pref.getString(DailyTaskKey);
    String? loadedStringDoneList = pref.getString(doneDailyTaskKey);
    String? loadedStringProjectList = pref.getString(projectKey);

    List<dynamic> loadedJsonList = jsonDecode(loadedStringList!);
    List<dynamic> loadedJsonDoneList = jsonDecode(loadedStringDoneList!);
    List<dynamic> loadedJsonProjectList = jsonDecode(loadedStringProjectList!);

    dailyTasksList =
        loadedJsonList.map((element) => DailyTask.fromJson(element)).toList();
    doneDailyTaskList = loadedJsonDoneList
        .map((element) => DailyTask.fromJson(element))
        .toList();
    projectsList = loadedJsonProjectList
        .map((element) => Projects.fromJson(element))
        .toList();
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 1.50,
              child: ListView(
                children: [
                  isOnlyTask
                      ? SizedBox(height: 0)
                      : Column(
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
                              },
                              onTap: () {
                                setState(() {
                                  selected = !selected;
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            MySlider(onRefrech: () => setState(() {})),
                            const SizedBox(height: 10),
                          ],
                        ),
                  MyTitles(
                    title1: "Daily Tasks",
                    title2: "Add Task",
                    selected: false,
                    textEditingController: projectsController,
                    onTap: () => myBSheet(context, () => setState(() {})),
                  ),
                  const SizedBox(height: 10),
                  dailyTasksList.isEmpty
                      ? IfThereISNothing()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dailyTasksList.length,
                          itemBuilder: (context, index) {
                            return MyDismissible(
                              context: context,
                              index: index,
                              child: MyTaskWidget(
                                title: dailyTasksList[index].title,
                                simpleindex: index,
                                refrech: () => setState(() {}),
                              ),
                              refrech: () => setState(() {}),
                            );
                          },
                        ),
                  doneDailyTaskList.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(500),
                                  ),
                                ),
                              ),
                              Text(
                                "Complete Task",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: doneDailyTaskList.length,
                    itemBuilder: (context, index) {
                      return MyDoneDismissible(
                        context: context,
                        index: index,
                        child: MyDoneTaskWidget(
                            title: doneDailyTaskList[index].title,
                            simpleindex: index,
                            refrech: () => setState(() {})),
                        refrech: () => setState(() {}),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
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
                              color: Theme.of(context).colorScheme.surface,
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
                                color: Theme.of(context).colorScheme.surface,
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
                          padding: const EdgeInsets.only(right: 20.0),
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
              Positioned(
                top: 170,
                child: MySearchBar(
                  onTap: () {
                    setState(() {
                      isOnlyTask = !isOnlyTask;
                    });
                  },
                ),
              )
            ],
          ),
        ],
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
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          children: [
            Text(
              "Let Start With Simple Task",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 15),
            Icon(
              Icons.note_add_rounded,
              size: 70,
              color: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }
}
