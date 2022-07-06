import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int? workTime;
  int? shortBreak;
  int? longBreak;
  SharedPreferences? pref;

  TextEditingController? txtWork;
  TextEditingController? txtShort;
  TextEditingController? txtLong;
  TextStyle textStyle = const TextStyle(fontSize: 20);

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text(
            "Work",
            style: textStyle,
          ),
          const Text(""),
          const Text(""),
          const SettingsButton(color: Color(0xff455A64), value: -1, text: "-"),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
          ),
          const SettingsButton(color: Color(0xff009688), value: 1, text: "+"),
          Text(
            "Short Break",
            style: textStyle,
          ),
          const Text(""),
          const Text(""),
          const SettingsButton(color: Color(0xff455A64), value: -1, text: "-"),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtShort,
          ),
          const SettingsButton(color: Color(0xff009688), value: 1, text: "+"),
          Text(
            "Long Break",
            style: textStyle,
          ),
          const Text(""),
          const Text(""),
          const SettingsButton(color: Color(0xff455A64), value: -1, text: "-"),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtLong,
          ),
          const SettingsButton(color: Color(0xff009688), value: 1, text: "+"),
        ],
      ),
    );
  }

  readSettings() async {
    pref = await SharedPreferences.getInstance();
    int? workTime = pref?.getInt(WORKTIME);
    int? shortBreak = pref?.getInt(SHORTBREAK);
    int? longBreak = pref?.getInt(LONGBREAK);

    setState(() {
      txtWork!.text = workTime.toString();
      txtShort!.text = shortBreak.toString();
      txtLong!.text = longBreak.toString();
    });
  }

  void updateSettings(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int? workTime = pref?.getInt(WORKTIME);
          workTime = workTime! + value;
          if (workTime > 0 && workTime <= 180) {
            pref!.setInt(WORKTIME, workTime);
            setState(() {
              txtWork!.text = workTime.toString();
            });
          }
        }
        break;

      case SHORTBREAK:
        {
          int? shortBreak = pref?.getInt(SHORTBREAK);
          shortBreak = shortBreak! + value;
          if (shortBreak > 0 && shortBreak <= 45) {
            pref!.setInt(SHORTBREAK, shortBreak);
          }
        }
        break;

      case LONGBREAK:
        {
          int? longBreak = pref?.getInt(LONGBREAK);
          longBreak = longBreak! + value;
          if (longBreak > 0 && longBreak <= 180) {
            pref!.setInt(LONGBREAK, longBreak);
          }
        }
        break;
    }
  }
}
