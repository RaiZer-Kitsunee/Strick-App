// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:strick_app/Screens/DetialsPages/notePages/editNote.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/my_DeleteNoteSheet.dart';

class MyNotewidget extends StatelessWidget {
  final int index;
  final VoidCallback onRefrech;
  final TextEditingController titleController;
  final TextEditingController noteController;
  const MyNotewidget({
    super.key,
    required this.onRefrech,
    required this.index,
    required this.titleController,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        titleController.text = filteredNotes[index].title;
        noteController.text = filteredNotes[index].note;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditNote(
                onRefrech: onRefrech,
                titleController: titleController,
                noteController: noteController,
                noteIndex: index),
          ),
        );
      },
      onLongPress: () => myDeleteNoteSheet(
        context: context,
        noteIndex: index,
        refrech: onRefrech,
      ),
      child: Container(
        margin: EdgeInsets.only(
          bottom: 5,
        ),
        padding: EdgeInsets.all(0),
        width: 170,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            filteredNotes[index].image.isNotEmpty
                ? SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.file(
                        File(filteredNotes[index].image),
                      ),
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filteredNotes[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  Text(
                    filteredNotes[index].note,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 15,
                        height: 15,
                        color: filteredNotes[index].color,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
