// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProjectTasks {
  String title;
  // DateTime date;
  // DateTime start;
  // DateTime end;
  String description;
  bool isFirst;
  bool isLast;
  bool isDone;

  ProjectTasks({
    required this.title,
    // required this.date,
    // required this.start,
    // required this.end,
    required this.description,
    required this.isFirst,
    required this.isLast,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      // 'date': date.millisecondsSinceEpoch,
      // 'start': start.millisecondsSinceEpoch,
      // 'end': end.millisecondsSinceEpoch,
      'description': description,
      'isFirst': isFirst,
      'isLast': isLast,
      'isDone': isDone
    };
  }

  factory ProjectTasks.fromJson(Map<String, dynamic> json) {
    return ProjectTasks(
      title: json['title'] as String,
      // date: DateTime.fromMillisecondsSinceEpoch(json['date'] as int),
      // start: DateTime.fromMillisecondsSinceEpoch(json['start'] as int),
      // end: DateTime.fromMillisecondsSinceEpoch(json['end'] as int),
      description: json['description'] as String,
      isFirst: json['isFirst'],
      isLast: json['isLast'],
      isDone: json['isDone'],
    );
  }
}
