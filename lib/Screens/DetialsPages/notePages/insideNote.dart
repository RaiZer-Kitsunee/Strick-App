import 'package:flutter/material.dart';
import 'package:strick_app/Services/notesService.dart';

class InsideNote extends StatelessWidget {
  final VoidCallback onRefrech;
  final TextEditingController titleController;
  final TextEditingController noteController;

  const InsideNote({
    super.key,
    required this.onRefrech,
    required this.titleController,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (titleController.text.isEmpty &&
                        noteController.text.isEmpty) {
                      print("its empty");
                    } else {
                      addNote(
                          title: titleController.text,
                          note: noteController.text);
                    }
                    onRefrech();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    size: 30,
                    Icons.arrow_back,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 20, right: 30),
            child: SizedBox(
              width: 350,
              child: TextField(
                controller: titleController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 0, right: 30),
            child: SizedBox(
              width: 350,
              child: TextField(
                maxLines: 10,
                controller: noteController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note",
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
