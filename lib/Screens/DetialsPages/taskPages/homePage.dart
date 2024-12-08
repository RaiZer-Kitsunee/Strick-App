// ignore_for_file: file_names, avoid_print, unnecessary_string_interpolations
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
  bool selectedLevel = false;
  bool selectedSearch = false;
  bool isOnlyTask = false;

  Random random = Random();

  //* controllers
  TextEditingController projectsController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  void reorderMyDailyTasks(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex--;
    }
    final task = dailyTasksList.removeAt(oldIndex);
    dailyTasksList.insert(newIndex, task);
    saveTasksIntoSp();
  }

  double percent() {
    return ((myProfile.xp * 100) / myProfile.xpToNextLevel) / 100;
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          //* this is the super app bar
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
            expandedHeight: selectedSearch ? 0 : 145,
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
                          for (var task in doneDailyTaskList) {
                            task.isDone = false;
                            dailyTasksList.add(task);
                          }
                          doneDailyTaskList.clear();
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
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 23),
                                child: InkWell(
                                  onTap: () async {
                                    await NotificationService.showNotification(
                                      title: "Easter Egg",
                                      body: comebackSayings[random
                                          .nextInt(comebackSayings.length)],
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    backgroundImage: myProfile.image == "fk you"
                                        ? AssetImage(
                                            "assets/computer-icons-user.png")
                                        : FileImage(File(myProfile.image)),
                                    radius: 30,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 48,
                                left: 68,
                                child: Container(
                                  height: 12,
                                  width: 12,
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                selectedLevel
                                    ? SizedBox()
                                    : Text(
                                        "${myProfile.name}",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  height: 20,
                                  width: 245,
                                  child: LinearPercentIndicator(
                                    leading: Text(
                                      "Lv.${(myProfile.level).toString()}",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Text(
                                      "${(myProfile.xp).toString()}/${(myProfile.xpToNextLevel).toString()}",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    lineHeight: 10,
                                    barRadius: Radius.circular(10),
                                    percent: percent(),
                                    progressColor: percent() <= 0.25
                                        ? Colors.red
                                        : Colors.blue,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedLevel = !selectedLevel;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 1000),
                                    width: selectedLevel ? 240 : 40,
                                    height: selectedLevel ? 60 : 5,
                                    decoration: BoxDecoration(
                                      color: selectedLevel
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: selectedLevel
                                        ? Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                animeQuotes[random.nextInt(
                                                    animeQuotes.length)],
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                    object:
                                        "Hmm,Empty want clear the way by having an object");
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
