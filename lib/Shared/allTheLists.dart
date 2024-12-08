// ignore_for_file: file_names

import 'package:strick_app/Models/noteModel.dart';
import 'package:strick_app/Models/profileModel.dart';
import 'package:strick_app/Models/projectTasks.dart';
import 'package:strick_app/Models/projectsModel.dart';
import 'package:strick_app/Models/dailyTaskModel.dart';

List<DailyTask> dailyTasksList = [];

List<DailyTask> filteredDailyTasks = [];

List<DailyTask> doneDailyTaskList = [];

List<Note> notesList = [];

List<Note> filteredNotes = [];

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
      ),
      ProjectTasks(
        title: "game 2",
        isFirst: false,
        isLast: false,
      ),
      ProjectTasks(
        title: "game 2",
        isFirst: false,
        isLast: false,
      ),
      ProjectTasks(
        title: "game 2",
        isFirst: false,
        isLast: false,
      ),
      ProjectTasks(
        title: "game 2",
        isFirst: false,
        isLast: false,
      ),
      ProjectTasks(
        title: "game 2",
        isFirst: false,
        isLast: false,
      ),
      ProjectTasks(
        title: "game 2",
        isFirst: false,
        isLast: false,
      ),
      ProjectTasks(
        title: "game 3",
        isFirst: false,
        isLast: true,
      ),
    ],
  )
];

Profile myProfile = Profile(name: "ME!!!", image: "null");

List<Profile> profilelist = [myProfile];

List<String> animeQuotes = [
  "Power comes when you create the need for it, not just the desire. - Goku",
  "No growth comes without sacrifice and enduring pain. - Edward Elric",
  "Fear reveals your weaknesses, helping you grow stronger and kinder. - Gildarts Clive",
  "Every scar tells a story of resilience and survival. - Monkey D. Luffy",
  "True strength comes from protecting what matters to you. - Haku",
  "You only lose when you choose to give up. - Misaki Ayuzawa",
  "Hard work is meaningless without self-belief. - Naruto Uzumaki",
  "Life has meaning when you fight to protect your purpose. - Eren Yeager",
  "Taking risks is the key to shaping your future. - Monkey D. Luffy",
  "Endurance builds a heart strong enough to overcome anything. - Edward Elric",
  "Keep swimming forward, and you'll grow beautifully. - Koro-sensei",
  "Wisdom gained gradually holds more value than instant insight. - Jiraiya",
  "Fight for today so you can live tomorrow. - Erwin Smith",
  "True sins are those you cannot undo or atone for. - Itachi Uchiha",
  "Overcoming hardship is how we truly grow. - Jiraiya",
];
List<String> comebackSayings = [
  // Friendly and Playful
  "I’m rubber, you’re glue—whatever you say bounces off me and sticks to you!",
  "You’re like a cloud. When you disappear, it’s a beautiful day.",
  "Do I know you? Because you look a lot like my next mistake!",
  "Thanks for the unsolicited advice, but I’m good.",
  "I’d agree with you, but then we’d both be wrong.",

  // Sarcastic
  "Oh, you think I care? Hold on, let me find my 'give a darn' list.",
  "Your opinion is noted—and promptly discarded.",
  "I’m sorry, I didn’t realize I was asking for your input.",
  "It’s okay if you don’t like me; not everyone has good taste.",
  "Thanks for explaining that. I’ll be sure to pass it along to someone who cares.",

  // Quick-Witted
  "You bring everyone so much joy—when you leave the room.",
  "Is that your opinion or just some random noise?",
  "Oh, I see the issue now—your mouth is open again.",
  "Why don’t you slip into something more comfortable, like silence?",
  "I’m not arguing, I’m just explaining why I’m right.",

  // Confidence Boosters
  "That’s cute—now run along and play with someone who cares.",
  "If you’re going to be two-faced, at least make one of them pretty.",
  "Keep rolling your eyes; maybe you’ll find a brain back there.",
  "I’m sorry, I didn’t order a side of your opinion.",
  "Not everyone can handle the fabulousness—don’t feel bad."
];
