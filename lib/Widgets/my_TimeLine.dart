import 'package:flutter/material.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeline extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String title;
  final String description;
  final int projectIndex;
  final int taskIndex;
  final VoidCallback refrech;

  const MyTimeline({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.title,
    required this.description,
    required this.projectIndex,
    required this.taskIndex,
    required this.refrech,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Padding(
        padding: const EdgeInsets.only(left: 35),
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
              )),
          endChild: Padding(
            padding: const EdgeInsets.only(left: 30, right: 35),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      children: [
                        Text(
                          overflow: TextOverflow.clip,
                          title,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          description,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: 45,
                            child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              projectsList[projectIndex]
                                  .inerTasks[taskIndex]
                                  .start,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
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
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
