// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:strick_app/Services/projectService.dart';

// class AddTaskPage extends StatefulWidget {
//   final int projectIndex;
//   final VoidCallback refrech;
//   const AddTaskPage({
//     super.key,
//     required this.projectIndex,
//     required this.refrech,
//   });

//   @override
//   State<AddTaskPage> createState() => _AddTaskPageState();
// }

// class _AddTaskPageState extends State<AddTaskPage> {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
  

//   @override
//   void dispose() {
//     titleController.dispose();
//     descriptionController.dispose();
//     dateController.dispose();
//     startTimeController.dispose();
//     endTimeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: _myFloatingActionButton(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: ListView(
//         children: [
//           Container(
//             height: 350,
//             width: MediaQuery.sizeOf(context).width,
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.secondary,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(50),
//                 bottomRight: Radius.circular(50),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 30, left: 10),
//                   child: IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: Icon(
//                       Icons.arrow_back_ios,
//                       color: Theme.of(context).colorScheme.surface,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15, top: 15),
//                   child: Text(
//                     "Create new task",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 35,
//                     ),
//                   ),
//                 ),
//                 myTextField(
//                   context: context,
//                   controller: titleController,
//                   label: Text("Title"),
//                   width: MediaQuery.sizeOf(context).width / 1.20,
//                   readOnly: false,
//                   numLines: 1,
//                   textColor: Theme.of(context).colorScheme.surface,
//                   suffix: Icon(Icons.edit),
//                 ),
//                 Row(
//                   children: [
//                     myTextField(
//                       context: context,
//                       label: Text("Date"),
//                       controller: dateController,
//                       width: MediaQuery.sizeOf(context).width / 1.48,
//                       readOnly: true,
//                       numLines: 1,
//                       textColor: Theme.of(context).colorScheme.surface,
//                       suffix: Icon(
//                         Icons.abc,
//                         color: Theme.of(context).colorScheme.secondary,
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => _showDatePicker(context),
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           color: Colors.blueAccent,
//                           borderRadius: BorderRadius.circular(5000),
//                         ),
//                         child: Icon(
//                           Icons.calendar_month_outlined,
//                           size: 35,
//                           color: Theme.of(context).colorScheme.secondary,
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Column(
//             children: [
             
//               myTextField(
//                 context: context,
//                 label: Text(
//                   "Description",
//                   style:
//                       TextStyle(color: Theme.of(context).colorScheme.secondary),
//                 ),
//                 controller: descriptionController,
//                 width: MediaQuery.sizeOf(context).width,
//                 readOnly: false,
//                 numLines: 3,
//                 textColor: Theme.of(context).colorScheme.secondary,
//                 suffix: Icon(
//                   Icons.safety_check,
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

  

//   Future<void> _showDatePicker(BuildContext context) async {
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

//   Future<void> _showTimePicker(
//       BuildContext context, TextEditingController controller) async {
//     TimeOfDay? selectedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//       initialEntryMode: TimePickerEntryMode.dial,
//       builder: (context, child) => Theme(
//         data: ThemeData().copyWith(
//             colorScheme: ColorScheme.dark(primary: Colors.blueAccent)),
//         child: child!,
//       ),
//     );
//     if (selectedTime != null) {
//       setState(() {
//         controller.text = selectedTime.format(context);
//       });
      
//     }
//   }

//   FloatingActionButton _myFloatingActionButton() {
//     return FloatingActionButton.extended(
//       isExtended: true,
//       onPressed: () {
//         addProjectTask(
//           projectIndex: widget.projectIndex,
//           title: titleController.text,
//           description: descriptionController.text,
//           start: startTimeController.text,
//           end: endTimeController.text,
//           date: dateController.text,
//         );
//         widget.refrech();
//         Navigator.pop(context);
//       },
//       backgroundColor: Colors.blueAccent,
//       label: Text(
//         "Add Task",
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       icon: Icon(Icons.add),
//     );
//   }
// }
