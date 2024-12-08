// ignore_for_file: avoid_print, unused_element, file_names

// import 'package:strick_app/Services/dailyTasksService.dart';
// import 'package:strick_app/Services/notification_service.dart';
// import 'package:strick_app/Shared/allTheLists.dart';
// import 'package:workmanager/workmanager.dart';

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     // Task triggered at midnight
//     if (task == 'resetDailyTasks') {
//       await resetTasks();
//       print("Tasks reset at midnight!");
//     }
//     print("hello");
//     return Future.value(true);
//   });
// }

// Future<void> resetTasks() async {
//   for (var task in doneDailyTaskList) {
//     task.isDone = false;
//     filteredDailyTasks.add(task);
//   }
//   saveTasksIntoSp();
//   resetTasksNotification();
//   print("Tasks have been reset.");
// }

// void resetTasksNotification() async {
//   await NotificationService.showNotification(
//     title: "S T R I C K",
//     body: 'Hey Master You Have a new set of tasks waiting for you',
//   );
// }
