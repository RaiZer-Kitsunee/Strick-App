// ignore_for_file: file_names, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:strick_app/Services/simpleTasksService.dart';
import 'package:strick_app/Shared/allTheLists.dart';

class MyDoneTaskWidget extends StatefulWidget {
  final String title;
  final int simpleindex;
  final VoidCallback refrech;
  const MyDoneTaskWidget({
    super.key,
    required this.title,
    required this.simpleindex,
    required this.refrech,
  });

  @override
  State<MyDoneTaskWidget> createState() => _MyDoneTaskWidgetState();
}

class _MyDoneTaskWidgetState extends State<MyDoneTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary,
            offset: Offset(0, 2),
            blurRadius: 5,
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
                      activeColor: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.8),
                      checkColor: Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.8),
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      value: doneSimpleTaskList[widget.simpleindex].isDone,
                      onChanged: (value) {
                        doneSimpleTaskList[widget.simpleindex].isDone = value!;

                        setState(() {
                          simpleTasksList
                              .add(doneSimpleTaskList[widget.simpleindex]);
                          doneSimpleTaskList.removeAt(widget.simpleindex);
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
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.8),
                        decoration:
                            doneSimpleTaskList[widget.simpleindex].isDone
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
              Container(
                margin: EdgeInsets.only(right: 20),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
