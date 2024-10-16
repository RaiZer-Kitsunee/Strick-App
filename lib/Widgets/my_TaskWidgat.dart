// ignore_for_file: file_names, avoid_print, must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        textEditingController.text = dailyTasksList[widget.simpleindex].title;
        descrptionController.text =
            dailyTasksList[widget.simpleindex].descrption;
        myBSheetEdit(
          context: context,
          simpleindex: widget.simpleindex,
          refrech: widget.refrech,
          textEditingController: textEditingController,
          descrptionController: descrptionController,
        );
      },
      onDoubleTap: () {
        myDialog(context);
      },
      child: Stack(
        children: [
          Container(
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
                            value: dailyTasksList[widget.simpleindex].isDone,
                            onChanged: (value) async {
                              dailyTasksList[widget.simpleindex].isDone =
                                  value!;
                              widget.refrech();
                              await Future.delayed(
                                Duration(milliseconds: 700),
                              );
                              setState(() {
                                doneDailyTaskList
                                    .add(dailyTasksList[widget.simpleindex]);
                                dailyTasksList.removeAt(widget.simpleindex);
                              });
                              widget.refrech();
                              saveIntoSp();
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 250,
                          child: Text(
                            overflow: TextOverflow.clip,
                            "${widget.simpleindex + 1}. ${widget.title.capitalize()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.secondary,
                              decoration:
                                  dailyTasksList[widget.simpleindex].isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                              decorationThickness: 2.5,
                              decorationColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
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
              margin: dailyTasksList[widget.simpleindex].isDone
                  ? EdgeInsets.only(left: 15, right: 15, top: 0)
                  : EdgeInsets.only(right: 24, top: 27),
              height: dailyTasksList[widget.simpleindex].isDone ? 65 : 10,
              width: dailyTasksList[widget.simpleindex].isDone
                  ? MediaQuery.sizeOf(context).width
                  : 10,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
                borderRadius: dailyTasksList[widget.simpleindex].isDone
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
          dailyTasksList[widget.simpleindex].descrption,
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
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
