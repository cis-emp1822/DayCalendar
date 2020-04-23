import 'package:day_calendar_flutter/day_calendar_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  HomeController get controller => super.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("day_calendar_flutter"),
      ),
      body: DayCalendarFlutter(
        currentDate: DateTime.now(),
        onEventTap: (ev) {
          print(ev.title);
        },
        events: [
          new Event(
              color: Colors.red,
              initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 10, 05),
              finalDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 11, 05),
              title: "Reunião"),
          new Event(
              color: Colors.blueGrey,
              initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 13, 30),
              finalDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 14, 30),
              title: "almoço"),
          new Event(
              color: Colors.blueAccent,
              initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 13, 30),
              finalDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 14, 30),
              title: "Exercício"),
        ],
        onTap: (date) {
          print(DateFormat('HH:mm').format(date));
        },
      ),
    );
  }
}
