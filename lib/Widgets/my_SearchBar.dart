// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:strick_app/Models/simpleTaskModel.dart';
import 'package:strick_app/Shared/allTheLists.dart';

class MySearchBar extends StatelessWidget {
  final VoidCallback onRefrech;
  final VoidCallback onTap;
  const MySearchBar({super.key, required this.onRefrech, required this.onTap});

  @override
  Widget build(BuildContext context) {
    void runFilter(String enteredKeyword) {
      List<SimpleTask> results = [];
      if (enteredKeyword.isEmpty) {
        results = simpleTasksList;
      } else {
        results = simpleTasksList
            .where((element) => element.title
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      }
      simpleTasksList = results;
      onRefrech();
    }

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: ListTile(
          leading: Icon(
            Icons.search_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: TextField(
            onTap: onTap,
            onChanged: (value) => runFilter(value),
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
            autofocus: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          trailing: InkWell(
            onTap: null,
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Icon(
                Icons.dns_rounded,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
