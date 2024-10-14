// ignore_for_file: public_member_api_docs, sort_constructors_first
class DailyTask {
  String title;
  String descrption;
  bool isDone;

  DailyTask({
    required this.title,
    required this.descrption,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "isDone": isDone,
        "descrption": descrption,
      };

  factory DailyTask.fromJson(Map<String, dynamic> json) {
    return DailyTask(
      title: json['title'],
      descrption: json["descrption"],
      isDone: json['isDone'],
    );
  }
}
