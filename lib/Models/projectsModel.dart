// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs, sort_constructors_fi=

import 'package:strick_app/Models/projectTasks.dart';

class Projects {
  String title;
  String object;
  List<ProjectTasks> inerTasks;

  Projects({
    required this.title,
    required this.object,
    required this.inerTasks,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'object': object,
        'inerTasks': inerTasks.map((elem) => elem.toJson()).toList(),
      };

  factory Projects.fromJson(Map<String, dynamic> json) {
    return Projects(
      title: json['title'],
      object: json['object'],
      inerTasks:
          json["inerTasks"].map((elem) => ProjectTasks.fromJson(elem)).toList(),
    );
  }
}
