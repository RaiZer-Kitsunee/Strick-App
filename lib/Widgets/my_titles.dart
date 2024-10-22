import 'package:flutter/material.dart';

class MyTitles extends StatefulWidget {
  final String title1;
  final String title2;
  final void Function()? onTap;
  final bool selected;
  final void Function()? onPressedBack;
  final void Function()? onPressedAdd;
  final TextEditingController textEditingController;

  const MyTitles({
    super.key,
    required this.title1,
    required this.title2,
    required this.onTap,
    required this.selected,
    this.onPressedBack,
    this.onPressedAdd,
    required this.textEditingController,
  });

  @override
  State<MyTitles> createState() => _MyTitlesState();
}

class _MyTitlesState extends State<MyTitles> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.selected
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      widget.title1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: widget.onTap,
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: widget.selected ? 330 : 90,
                    height: widget.selected ? 60 : 30,
                    alignment: Alignment.center,
                    margin: widget.selected ? EdgeInsets.only(left: 10) : null,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: widget.selected
                        ? ListTile(
                            leading: IconButton(
                              onPressed: widget.onPressedBack,
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            title: TextField(
                              autofocus: true,
                              controller: widget.textEditingController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Project Title...",
                                hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                            trailing: IconButton(
                              onPressed: widget.onPressedAdd,
                              icon: Icon(
                                Icons.add,
                                color: Theme.of(context).colorScheme.surface,
                                size: 30,
                              ),
                            ),
                          )
                        : Text(
                            widget.title2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
