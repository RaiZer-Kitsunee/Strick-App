import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeline extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String title;
  final String description;

  const MyTimeline(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.title,
      required this.description});

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
            color: Colors.black,
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
                        ? Theme.of(context).colorScheme.primary
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
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                    blurRadius: 10,
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
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          description,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
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
                          child: Text(
                            "9:00",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.done,
                              color: Theme.of(context).colorScheme.surface,
                              size: 25,
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
