// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:strick_app/Screens/DetialsPages/taskPages/homePage.dart';
import 'package:strick_app/Screens/DetialsPages/profilePage.dart';

import 'package:strick_app/Widgets/my_CNB.dart';
import '../DetialsPages/notePages/notePage.dart';

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
  List<Widget> pages = [];

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
        children: [
          const HomePage(),
          const NotePage(),
          ProfilePage(
            onRefrech: () => setState(() {}),
          ),
        ],
      ),
    );
  }
}
