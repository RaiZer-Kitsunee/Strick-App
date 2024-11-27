import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:strick_app/Screens/DetialsPages/notePages/insideNote.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/my_NoteWidget.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  bool isReading = true;

  @override
  void initState() {
    filteredNotes = notesList;
    super.initState();
  }

  void filterdTheNote(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredNotes = notesList;
      } else {
        filteredNotes = notesList
            .where((note) =>
                note.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void toggleSearchBar() {
    setState(() {
      isReading = !isReading;
      searchController.clear();
      filteredNotes = notesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingThing(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  backgroundImage: myProfile.image == "null"
                      ? AssetImage("assets/computer-icons-user.png")
                      : FileImage(File(myProfile.image)),
                  radius: 30,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 20, top: 10),
            width: MediaQuery.sizeOf(context).width,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.search_rounded),
                onPressed: toggleSearchBar,
              ),
              title: TextField(
                readOnly: isReading ? true : false,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: isReading ? "" : "Search...",
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: filterdTheNote,
              ),
              trailing: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Icon(
                  Icons.menu,
                  size: 25,
                ),
              ),
            ),
          ),
          notesList.isEmpty
              ? IfThereISNothing()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MasonryGridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 9,
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) => MyNotewidget(
                      onRefrech: () => setState(() {}),
                      index: index,
                      titleController: titleController,
                      noteController: noteController,
                    ),
                  ),
                )
        ],
      ),
    );
  }

  FloatingActionButton floatingThing(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: CircleBorder(),
      onPressed: () {
        titleController.clear();
        noteController.clear();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InsideNote(
              onRefrech: () => setState(() {}),
              titleController: titleController,
              noteController: noteController,
            ),
          ),
        );
      },
      child: Icon(
        Icons.add,
        size: 30,
        color: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}

class IfThereISNothing extends StatelessWidget {
  const IfThereISNothing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          children: [
            Text(
              "Wana Remember Something Write a Note",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 15),
            Icon(
              Icons.note_alt_rounded,
              size: 70,
              color: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }
}
