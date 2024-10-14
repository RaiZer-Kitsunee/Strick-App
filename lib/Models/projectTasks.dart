// ignore_for_file: public_member_api_docs, sort_constructors_firs

class ProjectTasks {
  String title;
  // String date;
  // String start;
  // String end;
  // String description;
  bool isFirst;
  bool isLast;
  bool isDone;

  ProjectTasks({
    required this.title,
    // required this.date,
    // required this.start,
    // required this.end,
    // required this.description,
    required this.isFirst,
    required this.isLast,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      // 'date': date,
      // 'start': start,
      // 'end': end,
      // 'description': description,
      'isFirst': isFirst,
      'isLast': isLast,
      'isDone': isDone
    };
  }

  factory ProjectTasks.fromJson(Map<String, dynamic> json) {
    return ProjectTasks(
      title: json['title'] as String,
      // date: json['date'],
      // start: json['start'],
      // end: json['end'],
      // description: json['description'] as String,
      isFirst: json['isFirst'],
      isLast: json['isLast'],
      isDone: json['isDone'],
    );
  }
}
