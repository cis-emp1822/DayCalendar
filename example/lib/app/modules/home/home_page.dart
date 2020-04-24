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
            color: Colors.cyan,
            initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 10, 05),
            finalDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 11, 05),
            title: "Reunião",
            eventTitleStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            showHours: true,
          ),
          new Event(
            color: Colors.deepPurpleAccent,
            initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 11, 30),
            finalDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 13, 30),
            title: "testes",
          ),
          new Event(
            color: Colors.blueGrey,
            initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 14, 15),
            finalDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 15, 30),
            title: "almoço",
          ),
          new Event(
            color: Colors.blueAccent,
            initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 14, 00),
            finalDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 15, 30),
            title: "Exercício",
          ),
          new Event(
            color: Colors.transparent,
            borderColor: Colors.grey,
            initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 16, 00),
            finalDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 17, 00),
            title: "apenas bordas",
            showHours: true,
            eventTitleStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
        onTap: (date) {
          print(DateFormat('HH:mm').format(date));
        },
      ),
    );
  }
}
