// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
class DailyTask {
  String title;
  String descrption;
  bool isDone;
  bool isMain;
  int xp;

  DailyTask({
    required this.title,
    required this.descrption,
    required this.xp,
    required this.isMain,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "isDone": isDone,
        "isMain": isMain,
        "descrption": descrption,
        "xp": xp,
      };

  factory DailyTask.fromJson(Map<String, dynamic> json) {
    return DailyTask(
        title: json['title'],
        descrption: json["descrption"],
        isDone: json['isDone'],
        isMain: json['isMain'],
        xp: json['xp']);
  }
}
