// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Services/notesService.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/my_ColorBSheet.dart';

class EditNote extends StatefulWidget {
  final VoidCallback onRefrech;
  final TextEditingController titleController;
  final TextEditingController noteController;
  final int noteIndex;

  const EditNote({
    super.key,
    required this.onRefrech,
    required this.titleController,
    required this.noteController,
    required this.noteIndex,
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  File? selectedImage;
  String? imagePath;

  void _PickImage() async {
    final responedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (responedImage == null) return;
    setState(() {
      selectedImage = File(responedImage.path);
    });
    notesList[widget.noteIndex].image = responedImage.path;
  }

  void saveImage(String? path) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("image", path!);
    print("image save done");
    print(path);
  }

  void loadImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    imagePath = pref.getString("image");
  }

  void setTheState() {
    Future.delayed(
      Duration(milliseconds: 10),
      () {
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    loadImage();
    setTheState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: notesList[widget.noteIndex].color != null
          ? notesList[widget.noteIndex].color.withOpacity(0.3)
          : Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: notesList[widget.noteIndex].color != null
            ? notesList[widget.noteIndex].color.withOpacity(0.2)
            : Theme.of(context).colorScheme.secondary,
        leading: IconButton(
          onPressed: () {
            if (widget.titleController.text.isEmpty &&
                widget.noteController.text.isEmpty) {
              print("its empty");
            } else {
              updateNote(
                  index: widget.noteIndex,
                  newTitle: widget.titleController.text,
                  newNote: widget.noteController.text);
            }
            if (selectedImage != null && imagePath != null) {
              saveImage(selectedImage?.path);
            }
            widget.onRefrech();
            Navigator.pop(context);
          },
          icon: Icon(
            size: 30,
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _PickImage,
            icon: Icon(
              Icons.add_a_photo_outlined,
              size: 30,
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () => selectColor(
                context: context,
                noteIndex: widget.noteIndex,
                onRefrech: () => setState(() {})),
            icon: Icon(
              Icons.color_lens_outlined,
              size: 30,
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: ListView(
        children: [
          notesList[widget.noteIndex].image.isNotEmpty
              ? Image.file(File(notesList[widget.noteIndex].image))
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 20, right: 30),
            child: SizedBox(
              width: 350,
              child: TextField(
                controller: widget.titleController,
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
            padding: const EdgeInsets.only(left: 25, right: 30),
            child: SizedBox(
              width: 350,
              child: TextField(
                maxLines: 50,
                controller: widget.noteController,
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
