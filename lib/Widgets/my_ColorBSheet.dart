// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:strick_app/Shared/allTheLists.dart';

Future<Color?> selectColor(
    {required BuildContext context,
    required int noteIndex,
    required VoidCallback onRefrech}) async {
  // List of colors to choose from
  List<Color> colors = [
    Colors.grey.shade900,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.brown,
    Colors.grey,
  ];

  // Display color selection bottom sheet
  return showModalBottomSheet<Color>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: Theme.of(context).colorScheme.secondary,
        padding: EdgeInsets.all(16.0),
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a Color',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: colors.length,
                itemBuilder: (BuildContext context, int index) {
                  final color = colors[index];
                  return GestureDetector(
                    onTap: () {
                      notesList[noteIndex].color = color;
                      Navigator.pop(context);
                      onRefrech();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
