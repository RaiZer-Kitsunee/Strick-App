import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:strick_app/Shared/allTheLists.dart';

class MyProjectWidget extends StatelessWidget {
  final String title;
  final String object;
  final int projectIndex;

  const MyProjectWidget({
    super.key,
    required this.title,
    required this.object,
    required this.projectIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Container(
            decoration: BoxDecoration(
              // TODO: make a backImages for the projects
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! donetask * 100 / number of tasks / 100 = 0.?
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 5),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: CircularPercentIndicator(
                        radius: 50,
                        lineWidth: 8,
                        percent: projectsList[projectIndex].inerTasks.isEmpty
                            ? 0.0
                            : percent(),
                        center: Text(
                          projectsList[projectIndex].inerTasks.isEmpty
                              ? "0 %"
                              : "${(percent() * 100).round()} %",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        progressColor: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        width: 120,
                        child: Text(
                          overflow: TextOverflow.clip,
                          title,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        width: 150,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          object,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
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
          child: Container(
            margin: EdgeInsets.only(right: 5),
            alignment: Alignment.center,
            height: 130,
            width: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(500),
                  bottomLeft: Radius.circular(500)),
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.secondary,
              size: 25,
            ),
          ),
        )
      ],
    );
  }

  double percent() {
    return ((projectsList[projectIndex]
                    .inerTasks
                    .where((task) => task.isDone)
                    .length *
                100) /
            projectsList[projectIndex].inerTasks.length) /
        100;
  }
}

extension MyExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
