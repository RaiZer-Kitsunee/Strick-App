import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strick_app/Screens/Original/startPage.dart';
import 'package:strick_app/Theme/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider()..init(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strick',
      home: StartPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
