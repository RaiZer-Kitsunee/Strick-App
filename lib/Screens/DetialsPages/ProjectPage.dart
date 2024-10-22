import 'package:flutter/material.dart';
import 'package:strick_app/Services/projectService.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/myBDSheet.dart';
import 'package:strick_app/Widgets/my_PBSheet.dart';
import 'package:strick_app/Widgets/my_PTBSheet.dart';
import 'package:strick_app/Widgets/my_TimeLine.dart';

class ProjectPage extends StatefulWidget {
  final int indexProject;
  final VoidCallback refrech;
  const ProjectPage({
    super.key,
    required this.indexProject,
    required this.refrech,
  });

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController objectEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 40),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, top: 50),
                child: Row(
                  children: [
                    Icon(Icons.task_alt_rounded),
                    SizedBox(width: 10),
                    Text(
                      "${projectsList[widget.indexProject].inerTasks.where((task) => task.isDone).length} / ${projectsList[widget.indexProject].inerTasks.length}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onDoubleTap: () {
                  titleEditingController.text =
                      projectsList[widget.indexProject].title;
                  myPTBSheetEdit(
                    context: context,
                    projectIndex: widget.indexProject,
                    textEditingController: titleEditingController,
                    refrech: () => setState(() {
                      widget.refrech();
                    }),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    projectsList[widget.indexProject].title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                  onPressed: () {
                    myPBSheet(
                      context: context,
                      refrech: () => setState(() {
                        widget.refrech();
                      }),
                      projectIndex: widget.indexProject,
                    );
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        Text(
                          "Add Task",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.sizeOf(context).width,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.surface,
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "[ ",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: "Object:",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: " ]",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          objectEditingController.text =
                              projectsList[widget.indexProject].object;
                          myBDSheet(
                            textEditingController: objectEditingController,
                            context: context,
                            index: widget.indexProject,
                            refrech: () {
                              widget.refrech();
                              setState(() {});
                            },
                          );
                        },
                        icon: const Icon(Icons.import_contacts),
                      ),
                    ],
                  ),
                  Text(
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.left,
                    projectsList[widget.indexProject].object,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15, left: 15),
                child: Text(
                  "So What are we doing: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, top: 15),
                color: Theme.of(context).colorScheme.primary,
                height: 2,
                width: 155,
              )
            ],
          ),
          projectsList[widget.indexProject].inerTasks.isEmpty
              ? IfThereIsNOProjectTasks(context)
              : SizedBox(
                  height: MediaQuery.sizeOf(context).height / 1.80,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount:
                          projectsList[widget.indexProject].inerTasks.length,
                      itemBuilder: (context, index) {
                        isIndex(index: index);
                        return MyTimeline(
                          key: ValueKey(
                            projectsList[widget.indexProject].inerTasks[index],
                          ),
                          refrech: () {
                            setState(() {});
                            widget.refrech();
                          },
                          projectIndex: widget.indexProject,
                          taskIndex: index,
                          title: projectsList[widget.indexProject]
                              .inerTasks[index]
                              .title,
                          isFirst: index == 0 ? true : false,
                          isLast: index ==
                                  projectsList[widget.indexProject]
                                          .inerTasks
                                          .length -
                                      1
                              ? true
                              : false,
                        );
                      }),
                )
        ],
      ),
    );
  }

  Align IfThereIsNOProjectTasks(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Text(
              "I Think This Is Empty !!!",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 15),
            Icon(
              Icons.screenshot_monitor_outlined,
              size: 70,
              color: Theme.of(context).colorScheme.primary,
            )
          ],
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
