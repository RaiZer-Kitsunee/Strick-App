// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:strick_app/Screens/DetialsPages/ProjectPage.dart';
import 'package:strick_app/Services/projectService.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/my_ProjectWidget.dart';

class MySlider extends StatelessWidget {
  final VoidCallback onRefrech;
  const MySlider({super.key, required this.onRefrech});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      width: MediaQuery.sizeOf(context).width,
      child: projectsList.isEmpty
          ? Align(
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
            )
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
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              _projectDeleteDialog(context, index));
                    },
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

  AlertDialog _projectDeleteDialog(BuildContext context, int index) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Text(
        "Delete",
        style: TextStyle(color: Theme.of(context).colorScheme.surface),
      ),
      content: Text(
        "Are You Sure You Want To Delete That ?",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.surface),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            dialogbutton(
              context: context,
              name: "Y E S",
              padding: EdgeInsets.only(left: 30),
              color: Theme.of(context).colorScheme.surface,
              onTap: () {
                deleteProject(index: index);
                Navigator.pop(context);
                onRefrech();
              },
            ),
            dialogbutton(
              context: context,
              name: "N O",
              padding: EdgeInsets.only(right: 30),
              color: Theme.of(context).colorScheme.surface,
              onTap: () => Navigator.pop(context),
            ),
          ],
        )
      ],
    );
  }
}

Padding dialogbutton(
    {required BuildContext context,
    required String name,
    required EdgeInsetsGeometry padding,
    required Color color,
    required void Function()? onTap}) {
  return Padding(
    padding: padding,
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: color),
        child: Text(
          name,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
