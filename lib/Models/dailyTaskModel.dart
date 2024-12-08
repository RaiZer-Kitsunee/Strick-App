// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
class DailyTask {
  String title;
  String descrption;
  bool isDone;
  int xp;

  DailyTask({
    required this.title,
    required this.descrption,
    required this.xp,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() =>
      {"title": title, "isDone": isDone, "descrption": descrption, "xp": xp};

  factory DailyTask.fromJson(Map<String, dynamic> json) {
    return DailyTask(
        title: json['title'],
        descrption: json["descrption"],
        isDone: json['isDone'],
        xp: json['xp']);
  }
}
