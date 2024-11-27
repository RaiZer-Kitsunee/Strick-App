import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Shared/allTheLists.dart';
import 'package:strick_app/Theme/theme_provider.dart';
import 'package:strick_app/Widgets/my_ProfileNameBSheet.dart';
import 'package:strick_app/Widgets/my_SettingTile.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback onRefrech;
  const ProfilePage({super.key, required this.onRefrech});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //* controllers
  TextEditingController textEditingController = TextEditingController();

  //* varebeils
  bool isSwitched = false;
  bool isLight = true;

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

  // Save the state of the switch
  _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switchState', value);
  }

  void setTheState() {
    Future.delayed(
      const Duration(milliseconds: 1),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              //* welcome page things
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //* my Profile text
                  Text(
                    "My Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  //* more info
                  Icon(
                    Icons.more_vert,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ],
              ),

              //* profile image
              profileImage(context),

              //* profile name
              profileName(context),

              const SizedBox(height: 10),

              //* first section
              //* info about the app things
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Statics",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),

              //* box of statics
              Container(
                margin: const EdgeInsets.only(
                    top: 10, left: 5, right: 5, bottom: 15),
                width: MediaQuery.sizeOf(context).width,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: staticsBox(context),
              ),

              //* second section
              //* setting tiles
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Preferences",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),

              //* box of Prefernces
              Container(
                margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                width: MediaQuery.sizeOf(context).width,
                height: 260,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    //* edit profile tile
                    MySettingTile(
                        title: "Edit Profile",
                        onTap: () {
                          textEditingController.text = myProfile.name;
                          myProfileNameBSheetEdit(
                            context: context,
                            nameController: textEditingController,
                            refrech: () => setState(() {
                              widget.onRefrech();
                            }),
                            save: () => saveName(textEditingController.text),
                          );
                        },
                        isCustom: false),

                    //* backup tile
                    MySettingTile(
                        title: "BackUp",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                "In Development ",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ),
                          );
                        },
                        isCustom: false),

                    //* Dark Mode tile
                    MySettingTile(
                      title: isSwitched ? 'Dark Mode' : 'Light Mode',
                      onTap: () {},
                      prefix: CupertinoSwitch(
                        value: isSwitched,
                        onChanged: (value) {
                          _saveSwitchState(value);
                          isSwitched = value;
                          isLight = !isLight;
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
                        },
                        activeColor: Theme.of(context).colorScheme.surface,
                      ),
                      isCustom: true,
                    ),

                    //* version tile
                    MySettingTile(
                        title: "Version",
                        onTap: () {},
                        prefix: Text("2.7"),
                        isCustom: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding profileName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        myProfile.name.isNotEmpty ? myProfile.name : "Me!!!",
        overflow: TextOverflow.clip,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  Padding profileImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: InkWell(
        onTap: PickImage,
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          backgroundImage: myProfile.image == "null"
              ? const AssetImage("assets/computer-icons-user.png")
              : FileImage(File(myProfile.image)),
          radius: 45,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.7),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(500)),
          ),
        ),
      ),
    );
  }

  Container staticsBox(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.contact_page,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${dailyTasksList.length + doneDailyTaskList.length}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.task,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${doneDailyTaskList.length}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              divaider(isVertical: true),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.folder,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${projectsList.length}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              divaider(isVertical: true),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.note,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${notesList.length}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.surface,
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
    );
  }

  Container divaider({required bool isVertical}) {
    return Container(
      width: isVertical ? 3 : 120,
      height: isVertical ? 60 : 2,
      color: Colors.grey,
    );
  }
}
