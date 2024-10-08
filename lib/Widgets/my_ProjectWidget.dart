import 'package:flutter/material.dart';

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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.games,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 30,
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 160,
                    child: Text(
                      overflow: TextOverflow.clip,
                      title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(bottom: 15, right: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(50),
                ),
                width: 40,
                height: 40,
                child: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 35,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
