import 'package:flutter/material.dart';
import 'package:strick_app/Screens/DetialsPages/homePage.dart';
import 'package:strick_app/Screens/DetialsPages/profilePage.dart';
import 'package:strick_app/Screens/DetialsPages/settingPage.dart';

import 'package:strick_app/Widgets/my_CNB.dart';
import '../DetialsPages/schedulePage.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  //* Page Controller
  late PageController pageController;

  //* For Page View
  int currentPage = 0;

  //* List of Pages
  List<Widget> pages = [
    const HomePage(),
    const SchedulePage(),
    const SettingPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyCNB(
        selectedIndex: currentPage,
        pageController: pageController,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: pages,
      ),
    );
  }
}
