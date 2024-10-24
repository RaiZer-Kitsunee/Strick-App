import 'package:flutter/material.dart';

class MyNotewidget extends StatelessWidget {
  const MyNotewidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          height: 150,
          width: 170,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("title............"),
                Text("description......................................"),
              ],
            ),
          ),
        ),
        Positioned(
          top: 120,
          left: 155,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              color: Colors.red,
              width: 15,
              height: 15,
            ),
          ),
        )
      ],
    );
  }
}
