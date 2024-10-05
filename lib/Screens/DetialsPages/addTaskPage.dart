import 'package:flutter/material.dart';
import 'package:strick_app/Screens/Original/startPage.dart';
import 'package:strick_app/Services/projectService.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleTextController = TextEditingController();
    TextEditingController objectTextController = TextEditingController();
    TextEditingController descriptionTextController = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Container()
              ],
            ),
          ),
          Container(
            color: Colors.red,
            width: MediaQuery.sizeOf(context).width,
            height: 520,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    "Creating Project Name : ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    maxLength: 15,
                    controller: titleTextController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.edit),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      hintText: "Project Name...",
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Creating Object of The Project : ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    maxLength: 50,
                    maxLines: 2,
                    controller: objectTextController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.edit_square),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      hintText: "Object...",
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Creating Description : ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    maxLength: 200,
                    maxLines: 4,
                    controller: descriptionTextController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.edit_document),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      hintText: "Description...",
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Exit",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextButton(
                          onPressed: () {
                            if (titleTextController.text.isNotEmpty &&
                                objectTextController.text.isNotEmpty &&
                                descriptionTextController.text.isNotEmpty) {
                              addProject(
                                  title: titleTextController.text,
                                  object: "in till i do add page");

                              titleTextController.clear();
                              objectTextController.clear();
                              descriptionTextController.clear();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StartPage(),
                                ),
                              );
                            } else {
                              print("-------------- is Empty HAHA");
                            }
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
