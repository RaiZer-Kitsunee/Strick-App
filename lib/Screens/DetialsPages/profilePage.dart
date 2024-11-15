import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Widgets/my_ProfileNameBSheet.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback onRefrech;
  const ProfilePage({super.key, required this.onRefrech});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController textEditingController = TextEditingController();

  void PickImage() async {
    final reterendImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (reterendImage == null) return;
    setState(() {
      myProfile.image = reterendImage.path;
    });
    saveImage(reterendImage.path);
    widget.onRefrech();
  }

  void saveImage(String path) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("Pimage", path);
  }

  void saveName(String name) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("PName", name);
  }

  void setTheState() {
    Future.delayed(
      Duration(milliseconds: 1),
      () => setState(() {}),
    );
  }

  @override
  void initState() {
    setTheState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                height: 200,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.symmetric(
                    vertical: BorderSide(
                      color: Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: InkWell(
                        onTap: PickImage,
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          backgroundImage: myProfile.image == "null"
                              ? AssetImage("assets/computer-icons-user.png")
                              : FileImage(File(myProfile.image)),
                          radius: 70,
                          child: Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.7),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(500)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: InkWell(
                            onTap: () {
                              textEditingController.text = myProfile.name;
                              myProfileNameBSheetEdit(
                                context: context,
                                nameController: textEditingController,
                                refrech: () => setState(() {
                                  widget.onRefrech();
                                }),
                                save: () =>
                                    saveName(textEditingController.text),
                              );
                            },
                            child: SizedBox(
                              width: 165,
                              child: Text(
                                myProfile.name.isNotEmpty
                                    ? myProfile.name
                                    : "Me!!!",
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                height: 200,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.symmetric(
                    vertical: BorderSide(
                      color: Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                "T A S K S",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  Icon(
                                    Icons.contact_page,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${dailyTasksList.length + doneDailyTaskList.length}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.task,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${doneDailyTaskList.length}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          divaider(isVertical: true),
                          Column(
                            children: [
                              Text(
                                "P R O J E C T S",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              SizedBox(height: 40),
                              Row(
                                children: [
                                  Icon(
                                    Icons.folder,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${projectsList.length}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          divaider(isVertical: true),
                          Column(
                            children: [
                              Text(
                                "N O T E S",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              SizedBox(height: 40),
                              Row(
                                children: [
                                  Icon(
                                    Icons.note,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${notesList.length}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container divaider({required bool isVertical}) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: isVertical ? 2 : 120,
      height: isVertical ? 120 : 2,
      color: Colors.grey,
    );
  }
}
