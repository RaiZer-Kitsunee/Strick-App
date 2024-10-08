import 'package:strick_app/Models/projectsModel.dart';
import 'package:strick_app/Shared/allTheLists.dart';

//* so that how to create add a project box
void addProject({required String title, required String object}) {
  projectsList.add(Projects(title: title, object: object, inerTasks: []));
}

//* and this to delete Projects
void deleteProject({required int index}) {
  projectsList.removeAt(index);
}
