import 'package:flutter/material.dart';
import 'package:strick_app/Screens/DetialsPages/addTaskPage.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/my_TimeLine.dart';

class ProjectPage extends StatefulWidget {
  final int indexProject;
  const ProjectPage({super.key, required this.indexProject});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 25),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 25,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
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
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTaskPage(),
                    ),
                  ),
                  icon: Container(
                    padding: EdgeInsets.all(10),
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
                          "add Task",
                          style: TextStyle(
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
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.sizeOf(context).width,
            height: 120,
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
                children: [
                  Text(
                    "Object:",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
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
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Text(
                  "So What are we doing: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, top: 15),
                color: Theme.of(context).colorScheme.primary,
                height: 2,
                width: 170,
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 1.55,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: projectsList[widget.indexProject].inerTasks.length,
              itemBuilder: (context, index) => MyTimeline(
                title: projectsList[widget.indexProject].inerTasks[index].title,
                description: projectsList[widget.indexProject]
                    .inerTasks[index]
                    .description,
                isFirst:
                    projectsList[widget.indexProject].inerTasks[index].isFirst,
                isLast:
                    projectsList[widget.indexProject].inerTasks[index].isLast,
              ),
            ),
          )
        ],
      ),
    );
  }
}
