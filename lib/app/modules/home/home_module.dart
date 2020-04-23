import 'package:day_calendar/app/modules/home/home_controller.dart';
import 'package:day_calendar/app/utils/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:day_calendar/app/modules/home/home_page.dart';
import 'package:intl/intl.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
      ];

  @override
  List<Router> get routers => [
        Router('/',
            child: (_, args) => HomePage(
                  currentDate: DateTime.now(),
                  initialHour: 6,
                  finalHour: 22,
                  onEventTap: (ev) {
                    print(ev.title);
                  },
                  events: [
                    new Event(
                      color: Colors.red,
                      initialDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day, 10, 05),
                      finalDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day, 11, 05),
                          title: "Hello World"
                    ),
                    new Event(
                      color: Colors.yellow,
                      initialDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day, 13, 30),
                      finalDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day, 14, 30),
                          title: "Agendamento no empresarial Kennedy Towers"
                    ),
                    new Event(
                      color: Colors.blueAccent,
                      initialDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day, 15, 00),
                      finalDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day, 15, 30),
                          title: "Testando"
                    ),
                  ],
                  onTap: (date) {
                    print(DateFormat('HH:mm').format(date));
                  },
                )),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
