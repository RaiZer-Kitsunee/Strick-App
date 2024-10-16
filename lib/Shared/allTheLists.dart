import 'package:strick_app/Models/projectTasks.dart';
import 'package:strick_app/Models/projectsModel.dart';
import 'package:strick_app/Models/dailyTaskModel.dart';

List<DailyTask> dailyTasksList = [];

List<DailyTask> doneDailyTaskList = [];

List<Projects> projectsList = [
  Projects(
    title: "Game project",
    object:
        "games for ever so i have to do something that i have to do but i wnt do that in till i have some thing to do",
    inerTasks: [
      ProjectTasks(
        title: "game 1",
        isFirst: true,
        isLast: false,
        start: "10:10",
        end: "12:00",
      ),
      ProjectTasks(
        title: "game 2",
        isFirst: false,
        isLast: false,
        start: "10:10",
        end: "12:00",
      ),
      ProjectTasks(
        title: "game 2",
        isFirst: false,
        isLast: false,
        start: "10:10",
        end: "12:00",
      ),
      ProjectTasks(
        title: "game 2",
        isFirst: false,
        isLast: false,
        start: "10:10",
        end: "12:00",
      ),
      ProjectTasks(
        title: "game 2",
        isFirst: false,
        isLast: false,
        start: "10:10",
        end: "12:00",
      ),
      ProjectTasks(
        title: "game 2",
        isFirst: false,
        isLast: false,
        start: "10:10",
        end: "12:00",
      ),
      ProjectTasks(
        title: "game 2",
        isFirst: false,
        isLast: false,
        start: "10:10",
        end: "12:00",
      ),
      ProjectTasks(
        title: "game 3",
        isFirst: false,
        isLast: true,
        start: "10:10",
        end: "12:00",
      ),
    ],
  )
];
