import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strick_app/Screens/Original/startPage.dart';
import 'package:strick_app/Theme/theme_provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider()..init(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Strick',
      home: StartPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
