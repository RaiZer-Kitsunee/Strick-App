// ignore_for_file: file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:strick_app/Screens/DetialsPages/ProjectPage.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/my_DeleteBSheet.dart';
import 'package:strick_app/Widgets/my_ProjectWidget.dart';

class MySlider extends StatelessWidget {
  final VoidCallback onRefrech;
  const MySlider({super.key, required this.onRefrech});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 245,
      width: MediaQuery.sizeOf(context).width,
      child: projectsList.isEmpty
          ? ifThereIsNoProjects(context)
          : CarouselSlider(
              items: List.generate(
                projectsList.length,
                (index) {
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectPage(
                          refrech: () => onRefrech(),
                          indexProject: index,
                        ),
                      ),
                    ),
                    onLongPress: () => myDeleteBSheet(
                        context: context,
                        projectIndex: index,
                        refrech: onRefrech),
                    child: MyProjectWidget(
                      title: projectsList[index].title,
                      object: projectsList[index].object,
                      projectIndex: index,
                    ),
                  );
                },
              ),
              options: CarouselOptions(
                height: 300,
                viewportFraction: 0.50,
                enableInfiniteScroll: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 20),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
              ),
            ),
    );
  }

  Align ifThereIsNoProjects(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Text(
              "If you find any project let me khow",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 15),
            Icon(
              Icons.folder_off_rounded,
              size: 70,
              color: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }
}
