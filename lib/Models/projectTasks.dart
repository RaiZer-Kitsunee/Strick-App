// ignore_for_file: public_member_api_docs, sort_constructors_firs

class ProjectTasks {
  String title;
  bool isFirst;
  bool isLast;
  bool isDone;

  ProjectTasks({
    required this.title,
    required this.isFirst,
    required this.isLast,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'isFirst': isFirst,
      'isLast': isLast,
      'isDone': isDone
    };
  }

  factory ProjectTasks.fromJson(Map<String, dynamic> json) {
    return ProjectTasks(
      title: json['title'] as String,
      isFirst: json['isFirst'],
      isLast: json['isLast'],
      isDone: json['isDone'],
    );
  }
}
