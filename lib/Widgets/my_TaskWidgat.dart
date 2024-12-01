// ignore_for_file: file_names, avoid_print, must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Services/dailyTasksService.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/my_BSheetEdit.dart';

class MyTaskWidget extends StatefulWidget {
  final String title;
  final int simpleindex;
  final VoidCallback refrech;

  const MyTaskWidget({
    super.key,
    required this.title,
    required this.simpleindex,
    required this.refrech,
  });

  @override
  State<MyTaskWidget> createState() => _MyTaskWidgetState();
}

class _MyTaskWidgetState extends State<MyTaskWidget> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController descrptionController = TextEditingController();

  //* save level of the player
  void saveLevelToSp() async {
    SharedPreferences prefe = await SharedPreferences.getInstance();
    prefe.setInt(levelKey, myProfile.level);
    prefe.setInt(xpKey, myProfile.xp);
    prefe.setInt(xpToNextLevelKey, myProfile.xpToNextLevel);
    print("save complete");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {
        textEditingController.text =
            filteredDailyTasks[widget.simpleindex].title;
        descrptionController.text =
            filteredDailyTasks[widget.simpleindex].descrption;
        myBSheetEdit(
          context: context,
          simpleindex: widget.simpleindex,
          refrech: widget.refrech,
          textEditingController: textEditingController,
          descrptionController: descrptionController,
        );
      },
      onTap: () {
        myDialog(context);
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(bottom: 10, right: 15, left: 15),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            checkColor: Theme.of(context).colorScheme.surface,
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.secondary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            value:
                                filteredDailyTasks[widget.simpleindex].isDone,
                            onChanged: (value) async {
                              //* here i will give random xp to task every time i finish
                              filteredDailyTasks[widget.simpleindex].xp =
                                  myProfile.addRandomXp();
                              //* the reset of the function
                              filteredDailyTasks[widget.simpleindex].isDone =
                                  value!;
                              widget.refrech();
                              await Future.delayed(
                                Duration(milliseconds: 700),
                              );
                              setState(() {
                                doneDailyTaskList.add(
                                    filteredDailyTasks[widget.simpleindex]);
                                filteredDailyTasks.removeAt(widget.simpleindex);
                              });
                              widget.refrech();
                              saveTasksIntoSp();
                              saveLevelToSp();
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 195,
                          child: Text(
                            overflow: TextOverflow.clip,
                            "${widget.simpleindex + 1}. ${widget.title}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.secondary,
                              decoration:
                                  filteredDailyTasks[widget.simpleindex].isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                              decorationThickness: 2.5,
                              decorationColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                        //* how mush xp this thing
                        Text(
                          " Xp: ${filteredDailyTasks[widget.simpleindex].xp}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: filteredDailyTasks[widget.simpleindex].isDone
                  ? EdgeInsets.only(left: 15, right: 15, top: 0)
                  : EdgeInsets.only(right: 24, top: 27),
              height: filteredDailyTasks[widget.simpleindex].isDone ? 65 : 10,
              width: filteredDailyTasks[widget.simpleindex].isDone
                  ? MediaQuery.sizeOf(context).width
                  : 10,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: filteredDailyTasks[widget.simpleindex].isDone
                    ? BorderRadius.all(
                        Radius.circular(15),
                      )
                    : BorderRadius.all(
                        Radius.circular(50),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> myDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Descrption :",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        content: Text(
          filteredDailyTasks[widget.simpleindex].descrption,
          style: TextStyle(
            overflow: TextOverflow.clip,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

extension MyExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
