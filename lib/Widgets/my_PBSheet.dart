// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:strick_app/Services/projectService.dart';

void myPBSheet({
  required BuildContext context,
  required VoidCallback refrech,
  required int projectIndex,
}) {
  TextEditingController textEditingController = TextEditingController();

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 160,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  "Creating Task : ",
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
                  controller: textEditingController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.edit_square),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.secondary,
                    hintText: "First...",
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
                          if (textEditingController.text.isNotEmpty) {
                            addProjectTask(
                              projectIndex: projectIndex,
                              title: textEditingController.text,
                            );
                            refrech();
                            textEditingController.clear();
                            Navigator.pop(context);
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
      );
    },
  );
}

//  Future<void> _showDatePicker(BuildContext context) async {
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2025),
//       builder: (context, child) => Theme(
//         data: ThemeData().copyWith(
//             colorScheme: ColorScheme.dark(primary: Colors.blueAccent)),
//         child: child!,
//       ),
//     );
//     if (selectedDate != null) {
//       dateController.text = DateFormat.MMMMEEEEd().format(selectedDate);
//     }
//   }


