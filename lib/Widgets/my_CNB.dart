// ignore_for_file: file_names

import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:strick_app/Shared/allTheLists.dart';

class MyCNB extends StatefulWidget {
  final int selectedIndex;
  final PageController pageController;
  const MyCNB(
      {super.key, required this.selectedIndex, required this.pageController});

  @override
  State<MyCNB> createState() => _MyCNBState();
}

class _MyCNBState extends State<MyCNB> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Theme.of(context).colorScheme.secondary,
      backgroundColor: widget.selectedIndex == 2
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).colorScheme.surface,
      animationDuration: const Duration(milliseconds: 500),
      height: 60,
      onTap: (index) {
        setState(() {
          widget.pageController.jumpToPage(index);
        });
      },
      index: widget.selectedIndex,
      items: [
        Icon(Icons.home,
            size: 30, color: Theme.of(context).colorScheme.surface),
        Icon(Icons.notes,
            size: 30, color: Theme.of(context).colorScheme.surface),
        CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          backgroundImage: myProfile.image == "null"
              ? AssetImage("assets/computer-icons-user.png")
              : FileImage(File(myProfile.image)),
          radius: 20,
        ),
      ],
    );
  }
}
