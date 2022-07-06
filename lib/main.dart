import 'package:flutter/material.dart';
import 'timer_model.dart';
import 'widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'timer.dart';
import 'settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Productivity Timer",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  TimerHomePage({Key? key}) : super(key: key);

  final double _defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  void goToSettings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems =
        List<PopupMenuItem<String>>.empty(growable: true);
    menuItems.add(
      const PopupMenuItem(
        value: "Settings",
        child: Text("Settings"),
      ),
    );
    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productivity Timer"),
        actions: [
          PopupMenuButton(
            itemBuilder: ((context) => menuItems.toList()),
            onSelected: (s) {
              if (s == "Settings") {
                goToSettings(context);
              }
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(_defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      callback: () => timer.startWork(),
                      size: 10.0,
                      text: "Work",
                      color: const Color(0xff00796B),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(_defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      callback: () => timer.startBreak(true),
                      size: 10.0,
                      text: "Short Break",
                      color: const Color(0xffB2DFDB),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(_defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      callback: () => timer.startBreak(false),
                      size: 10.0,
                      text: "Long Break",
                      color: const Color(0xff212121),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(_defaultPadding)),
                ],
              ),
              StreamBuilder(
                  initialData: "00:00",
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    TimerModel timer = (snapshot.data == "00:00")
                        ? TimerModel(1, "00:00")
                        : snapshot.data;
                    return Expanded(
                      child: CircularPercentIndicator(
                        radius: availableWidth / 2.5,
                        lineWidth: 10.0,
                        center: Text(
                          timer.time,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        percent: timer.percent,
                        progressColor: const Color(0xff009688),
                      ),
                    );
                  }),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(_defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      callback: () => timer.stopTimer(),
                      size: 10.0,
                      text: "Stop",
                      color: const Color(0xff00796B),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(_defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                      callback: () => timer.startTimer(),
                      size: 10.0,
                      text: "Restart",
                      color: const Color(0xff212121),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(_defaultPadding)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
