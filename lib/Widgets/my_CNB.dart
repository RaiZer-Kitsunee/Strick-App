import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

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
      color: Theme.of(context).colorScheme.surface,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      animationDuration: const Duration(milliseconds: 500),
      height: 50,
      onTap: (index) {
        setState(() {
          widget.pageController.jumpToPage(index);
        });
      },
      index: widget.selectedIndex,
      items: [
        Icon(Icons.home,
            size: 30, color: Theme.of(context).colorScheme.secondary),
        Icon(Icons.calendar_month,
            size: 30, color: Theme.of(context).colorScheme.secondary),
        Icon(Icons.settings,
            size: 30, color: Theme.of(context).colorScheme.secondary),
        Icon(Icons.person,
            size: 30, color: Theme.of(context).colorScheme.secondary),
      ],
    );
  }
}
