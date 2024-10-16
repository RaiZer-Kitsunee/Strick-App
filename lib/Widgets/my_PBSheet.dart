import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:strick_app/Services/projectService.dart';

void myPBSheet(
    {required BuildContext context,
    required VoidCallback refrech,
    required int projectIndex}) {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  Future<void> _showTimePicker(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
            colorScheme: ColorScheme.dark(primary: Colors.blueAccent)),
        child: child!,
      ),
    );
    if (selectedTime != null) {
      controller.text = selectedTime.format(context);
      refrech();
    }
  }

  Padding myTextField({
    required BuildContext context,
    required Text label,
    required TextEditingController controller,
    required double width,
    required bool readOnly,
    required Color textColor,
    required int numLines,
    required Widget suffix,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: SizedBox(
        width: width,
        child: TextField(
          readOnly: readOnly,
          controller: controller,
          maxLines: numLines,
          decoration: InputDecoration(
            suffix: suffix,
            label: label,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.surface),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

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
          height: 300,
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
                    hintText: "First Task...",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  myTextField(
                    context: context,
                    label: Text(
                      "Start time",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.surface),
                    ),
                    controller: startTimeController,
                    width: 160,
                    readOnly: true,
                    textColor: Theme.of(context).colorScheme.surface,
                    numLines: 1,
                    suffix: IconButton(
                      onPressed: () =>
                          _showTimePicker(context, startTimeController),
                      icon: Icon(
                        Icons.timer,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                  myTextField(
                    context: context,
                    label: Text(
                      "End time",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.surface),
                    ),
                    controller: endTimeController,
                    width: 160,
                    readOnly: true,
                    textColor: Theme.of(context).colorScheme.surface,
                    numLines: 1,
                    suffix: IconButton(
                      onPressed: () =>
                          _showTimePicker(context, endTimeController),
                      icon: Icon(
                        Icons.timer,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                ],
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
                              start: startTimeController.text,
                              end: endTimeController.text,
                            );
                            refrech();
                            textEditingController.clear();
                            startTimeController.clear();
                            endTimeController.clear();
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


