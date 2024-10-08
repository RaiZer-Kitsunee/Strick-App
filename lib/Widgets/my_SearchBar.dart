// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
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
            autofocus: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
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
