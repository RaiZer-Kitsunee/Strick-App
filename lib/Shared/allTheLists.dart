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

List<String> animeQuotes = [
  "I’m not gonna run away. I never go back on my word! That’s my ninja way! - Naruto Uzumaki (Naruto)",
  "I don’t want to conquer anything. I just think the guy with the most freedom in this whole ocean… is the Pirate King! - Monkey D. Luffy (One Piece)",
  "A lesson without pain is meaningless. That’s because you cannot gain something without sacrificing something else in return. - Edward Elric (Fullmetal Alchemist: Brotherhood)",
  "The only thing we’re allowed to do is believe that we won’t regret the choice we made. - Levi Ackerman (Attack on Titan)",
  "I am the hope of the universe. I am the answer to all living things that cry out for peace. - Goku (Dragon Ball Z)",
  "Whatever you lose, you’ll find it again. But what you throw away, you’ll never get back. - Kenshin Himura (Rurouni Kenshin)",
  "If you really want to become strong, stop caring about what others think about you! - Saitama (One Punch Man)",
  "In this world, there are very few who actually trust each other. - Light Yagami (Death Note)",
  "The future belongs to those who believe in the beauty of their dreams. - Hinata Shoyo (Haikyuu!!)",
  "We don’t die for our friends; we live for them. - Erza Scarlet (Fairy Tail)",
  "People's lives don’t end when they die. It ends when they lose faith. - Itachi Uchiha (Naruto)",
  "A hero is not one who never falls. He is the one who gets up, again and again, never losing sight of his dreams. - Shinya Kogami (Psycho-Pass)",
  "To know sorrow is not terrifying. What is terrifying is to know you can't go back to happiness you could have. - Matsumoto Rangiku (Bleach)",
  "The world isn’t perfect. But it’s there for us, doing the best it can. That’s what makes it so damn beautiful. - Roy Mustang (Fullmetal Alchemist)",
  "I want to live. I want to see how people live. - Ichihara Yuuko (xxxHolic)",
  "A place where someone still thinks about you is a place you can call home. - Jiraiya (Naruto)",
  "Power comes in response to a need, not a desire. You have to create that need. - Goku (Dragon Ball Z)",
  "I think death is equally terrible for everyone. Young people, old people, the good, the bad… It’s always the same. It’s just so unfair. - Makoto Shishio (Rurouni Kenshin)",
  "A dropout will beat a genius through hard work. - Rock Lee (Naruto)",
  "It’s not the face that makes someone a monster; it’s the choices they make with their lives. - Naruto Uzumaki (Naruto)",
];
