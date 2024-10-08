// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descreptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 350,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Text(
                "Create new task",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            myTextField(
              context: context,
              controller: titleController,
              label: "Title",
              width: MediaQuery.sizeOf(context).width / 1.20,
              readOnly: false,
            ),
            Row(
              children: [
                myTextField(
                  context: context,
                  label: "Date",
                  controller: dateController,
                  width: MediaQuery.sizeOf(context).width / 1.48,
                  readOnly: true,
                ),
                InkWell(
                  onTap: () => _showDatePicker(context),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5000),
                    ),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      size: 35,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding myTextField(
      {required BuildContext context,
      required String label,
      required TextEditingController controller,
      required double width,
      required bool readOnly}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: SizedBox(
        width: width,
        child: TextField(
          readOnly: readOnly,
          controller: controller,
          decoration: InputDecoration(
            label: Text(label),
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(colorScheme: ColorScheme.dark()),
              child: child!,
            ));
    if (selectedDate != null) {
      dateController.text = DateFormat.MMMMEEEEd().format(selectedDate);
    }
  }
}
