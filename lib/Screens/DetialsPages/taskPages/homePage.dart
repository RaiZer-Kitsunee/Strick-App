// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Models/projectsModel.dart';
import 'package:strick_app/Models/dailyTaskModel.dart';
import 'package:strick_app/Services/notification_service.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Services/dailyTasksService.dart';
import 'package:strick_app/Services/projectService.dart';
import 'package:strick_app/Widgets/my_BSheet.dart';
import 'package:strick_app/Widgets/my_Dismissible.dart';
import 'package:strick_app/Widgets/my_DoneDismissible.dart';
import 'package:strick_app/Widgets/my_DoneTaskWidget.dart';
import 'package:strick_app/Widgets/my_Slider.dart';
import 'package:strick_app/Widgets/my_TaskWidgat.dart';
import 'package:strick_app/Widgets/my_titles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //* varebelis
  bool selected = false;
  bool selectedSearch = false;
  bool isOnlyTask = false;
  late SharedPreferences pref;
  Random random = Random();

  //* controllers
  TextEditingController projectsController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  //* functions
  getShearedPref() async {
    pref = await SharedPreferences.getInstance();
    readFromSp();
  }

  readFromSp() {
    //* For simple tasks
    String? loadedStringList = pref.getString(dailyTaskKey);
    String? loadedStringDoneList = pref.getString(doneDailyTaskKey);
    String? loadedStringProjectList = pref.getString(projectKey);

    List<dynamic> loadedJsonList = jsonDecode(loadedStringList!);
    List<dynamic> loadedJsonDoneList = jsonDecode(loadedStringDoneList!);
    List<dynamic> loadedJsonProjectList = jsonDecode(loadedStringProjectList!);

    filteredDailyTasks = dailyTasksList =
        loadedJsonList.map((element) => DailyTask.fromJson(element)).toList();
    doneDailyTaskList = loadedJsonDoneList
        .map((element) => DailyTask.fromJson(element))
        .toList();
    projectsList = loadedJsonProjectList
        .map((element) => Projects.fromJson(element))
        .toList();
    setState(() {});
  }

  void reorderMyDailyTasks(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex--;
    }
    final task = dailyTasksList.removeAt(oldIndex);
    dailyTasksList.insert(newIndex, task);
    saveTasksIntoSp();
  }

  void welcomeNotification() async {
    await NotificationService.showNotification(
      title: "Strick Time",
      body: 'Hey Master ${myProfile.name} Welcome Back',
      scheduled: true,
      interval: Duration(seconds: 5),
    );
  }

  void filteredTheDailyTasks(String quary) {
    setState(() {
      if (quary.isEmpty) {
        filteredDailyTasks = dailyTasksList;
      } else {
        filteredDailyTasks = dailyTasksList
            .where((task) =>
                task.title.toLowerCase().contains(quary.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    getShearedPref();
    welcomeNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            leading: IconButton(
              onPressed: () {
                setState(() {
                  selectedSearch = !selectedSearch;
                  isOnlyTask = !isOnlyTask;
                  searchController.clear();
                  filteredDailyTasks = dailyTasksList;
                });
              },
              icon: Icon(
                Icons.search,
                size: 25,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isOnlyTask = !isOnlyTask;
                    });
                  },
                  child: SizedBox(
                    height: 35,
                    width: 35,
                    child: Icon(
                      isOnlyTask ? Icons.folder : Icons.dns_rounded,
                      size: 25,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ),
            ],
            centerTitle: true,
            expandedHeight: selectedSearch ? 0 : 160,
            pinned: true,
            title: selectedSearch
                ? TextField(
                    autofocus: true,
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        border: InputBorder.none),
                    onChanged: filteredTheDailyTasks,
                  )
                : InkWell(
                    onTap: () async {
                      if (doneDailyTaskList.isEmpty) {
                        print("nothing to do");
                      } else {
                        setState(() {
                          dailyTasksList.addAll(doneDailyTaskList);
                          doneDailyTaskList.clear();
                          for (var task in dailyTasksList) {
                            task.isDone = false;
                          }
                          saveTasksIntoSp();
                        });
                        print("Object Complete");
                      }
                    },
                    child: Text("S T R I C K")),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            flexibleSpace: selectedSearch
                ? Container()
                : FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.only(top: 85),
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
                                  "Hey ${myProfile.name} !",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontSize: 16,
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
                                      color:
                                          Theme.of(context).colorScheme.surface,
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
                                child: InkWell(
                                  onTap: () async {
                                    await NotificationService.showNotification(
                                      title: "Wisdom of the day",
                                      body: animeQuotes[
                                          random.nextInt(animeQuotes.length)],
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    backgroundImage: myProfile.image == "null"
                                        ? AssetImage(
                                            "assets/computer-icons-user.png")
                                        : FileImage(File(myProfile.image)),
                                    radius: 30,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 46,
                                right: 64,
                                child: Container(
                                  height: 14,
                                  width: 14,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
                  ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                isOnlyTask
                    ? SizedBox()
                    : Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Column(
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
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                isOnlyTask ? SizedBox(height: 15) : SizedBox(),
                MyTitles(
                  title1: "Daily Tasks",
                  title2: "Add Task",
                  selected: false,
                  textEditingController: projectsController,
                  onTap: () => myBSheet(context, () => setState(() {})),
                ),
                filteredDailyTasks.isEmpty
                    ? IfThereISNothing()
                    : ReorderableListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 15),
                        itemCount: filteredDailyTasks.length,
                        onReorder: (oldIndex, newIndex) =>
                            reorderMyDailyTasks(oldIndex, newIndex),
                        itemBuilder: (context, index) {
                          return MyDismissible(
                            context: context,
                            index: index,
                            child: MyTaskWidget(
                              title: filteredDailyTasks[index].title,
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
                        padding: const EdgeInsets.only(top: 5),
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
                                color: Theme.of(context).colorScheme.secondary,
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
                  reverse: true,
                  padding: EdgeInsets.only(top: 10),
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
          )
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
