class SimpleTask {
  String title;
  bool isDone;

  SimpleTask({
    required this.title,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "isDone": isDone,
      };

  factory SimpleTask.fromJson(Map<String, dynamic> json) {
    return SimpleTask(
      title: json['title'],
      isDone: json['isDone'],
    );
  }
}
