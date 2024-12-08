// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:strick_app/Models/projectTasks.dart';
import 'package:strick_app/Services/projectService.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/myAlertBSheet.dart';
import 'package:strick_app/Widgets/my_PBSheetEdit.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeline extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String title;
  final int projectIndex;
  final int taskIndex;
  final VoidCallback refrech;

  const MyTimeline({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.title,
    required this.projectIndex,
    required this.taskIndex,
    required this.refrech,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return SizedBox(
      height: 80,
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TimelineTile(
          isFirst: isFirst,
          isLast: isLast,
          beforeLineStyle: LineStyle(
            color: Theme.of(context).colorScheme.surface,
            thickness: 3,
          ),
          indicatorStyle: IndicatorStyle(
            width: 25,
            height: 25,
            padding: EdgeInsets.symmetric(vertical: 10),
            indicator: Container(
              decoration: BoxDecoration(
                color: isFirst || isLast
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.secondary,
                border: Border.all(
                  width: 3,
                  color: isFirst || isLast
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.surface,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          endChild: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dismissible(
                confirmDismiss: (direction) {
                  return myAlertBSheet(context: context);
                },
                onDismissed: (direction) {
                  deleteProjectTask(
                    projectIndex: projectIndex,
                    taskIndex: taskIndex,
                  );
                  refrech();
                },
                background: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                key: ValueKey<ProjectTasks>(
                  projectsList[projectIndex].inerTasks[taskIndex],
                ),
                child: InkWell(
                  onLongPress: () {
                    textEditingController.text =
                        projectsList[projectIndex].inerTasks[taskIndex].title;
                    myPBSheetEdit(
                      context: context,
                      refrech: refrech,
                      projectIndex: projectIndex,
                      taskIndex: taskIndex,
                      textEditingController: textEditingController,
                    );
                    print("niceeeeeeeeeeeeeeeeeeee");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 20),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                overflow: TextOverflow.clip,
                                title,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Transform.scale(
                              scale: 1.4,
                              child: Checkbox(
                                activeColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                value: projectsList[projectIndex]
                                    .inerTasks[taskIndex]
                                    .isDone,
                                onChanged: (value) {
                                  projectsList[projectIndex]
                                      .inerTasks[taskIndex]
                                      .isDone = value!;
                                  refrech();
                                  saveProjectIntoSp();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
