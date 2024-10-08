import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class MyProjectWidget extends StatelessWidget {
  final String title;

  const MyProjectWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          // TODO: make a backImages for the projects
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 70),
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
              //! for this to work after you finish the tasks do this
              //! donetask * 100 / number of tasks / 100 = 0.?
              Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 60),
                child: CircularPercentIndicator(
                  radius: 50,
                  lineWidth: 7,
                  percent: 0.8,
                  center: Text("80%"),
                  progressColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
