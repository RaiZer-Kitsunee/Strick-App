import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Theme/theme_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isSwitched = false;
  bool isLight = true;

  @override
  void initState() {
    _loadSwitchState();
    super.initState();
  }

  // Load the saved state of the switch
  _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = prefs.getBool('switchState') ?? false; // Default is false
    });
  }

  // Save the state of the switch
  _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switchState', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 65),
            child: Text(
              'Settings',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          Column(
            children: [
              custom_button(
                title: isSwitched ? 'Light Mode' : 'Dark Mode',
                trailing: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    _saveSwitchState(value);
                    isSwitched = value;
                    isLight = !isLight;
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                  activeColor: Theme.of(context).colorScheme.secondary,
                  activeTrackColor: Theme.of(context).colorScheme.surface,
                  inactiveTrackColor: Theme.of(context).colorScheme.surface,
                  inactiveThumbColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
              custom_button(
                title: 'App version :',
                trailing: const Text(
                  "2.3",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget custom_button({required String title, required Widget trailing}) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
