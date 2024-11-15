// ignore_for_file: file_names, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:strick_app/Services/dailyTasksService.dart';
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
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 1.5,
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
                          value: doneDailyTaskList[widget.simpleindex].isDone,
                          onChanged: (value) {
                            doneDailyTaskList[widget.simpleindex].isDone =
                                value!;

                            setState(() {
                              dailyTasksList
                                  .add(doneDailyTaskList[widget.simpleindex]);
                              doneDailyTaskList.removeAt(widget.simpleindex);
                            });
                            widget.refrech();
                            saveTasksIntoSp();
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
                                doneDailyTaskList[widget.simpleindex].isDone
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
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: Container(
        //     margin: EdgeInsets.only(right: 12),
        //     height: 65,
        //     width: 65,
        //     decoration: BoxDecoration(
        //       color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
        //       borderRadius: BorderRadius.only(
        //         topRight: Radius.circular(15),
        //         bottomRight: Radius.circular(15),
        //         topLeft: Radius.circular(50),
        //         bottomLeft: Radius.circular(50),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
