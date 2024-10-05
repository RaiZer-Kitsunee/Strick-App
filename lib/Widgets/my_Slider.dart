// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:strick_app/Screens/DetialsPages/ProjectPage.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/my_ProjectWidget.dart';

class MySlider extends StatelessWidget {
  const MySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      width: MediaQuery.sizeOf(context).width,
      child: CarouselSlider(
        items: List.generate(
          projectsList.length,
          (index) {
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectPage(
                    indexProject: index,
                  ),
                ),
              ),
              child: MyProjectWidget(
                title: projectsList[index].title,
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
}
