import 'package:day_calendar_flutter/src/utils/models/event.dart';
import 'package:mobx/mobx.dart';

part 'day_calendar_controller.g.dart';

class DayCalendarController = _DayCalendarControllerBase
    with _$DayCalendarController;

abstract class _DayCalendarControllerBase with Store {
  @observable
  List<Map<String, dynamic>> listHour = [];

  @observable
  List<Event> listEv = [];

  @action
  setListEv(List<Event> list) {
    listEv = list;
  }

  @action
  removeEvFromList(Event ev) {
    listEv.remove(ev);
    listEv = listEv;
  }

  @action
  void generateListDates(
      {int initialHour, int finalHour, DateTime currentDate}) {
    currentDate = currentDate == null ? DateTime.now() : currentDate;

    DateTime initialHourDateTime;
    DateTime finalHourDateTime;

    if (initialHour != null) {
      initialHourDateTime = DateTime(
          currentDate.year, currentDate.month, currentDate.day, initialHour);
    }

    if (finalHour != null) {
      finalHourDateTime = DateTime(
          currentDate.year, currentDate.month, currentDate.day, finalHour);
    }

    if (initialHourDateTime != null && finalHourDateTime == null) {
      for (var i = initialHour; i < 24; i++) {
        for (var j = 0; j < 60; j++) {
          initialHourDateTime = DateTime(
              currentDate.year, currentDate.month, currentDate.day, i, j);
          listHour.add({"date": initialHourDateTime, "selected": false});
        }
      }
    } else if (finalHourDateTime != null && initialHourDateTime == null) {
      for (var i = 0; i < finalHour; i++) {
        for (var j = 0; j < 60; j++) {
          initialHourDateTime = DateTime(
              currentDate.year, currentDate.month, currentDate.day, i, j);
          listHour.add({"date": initialHourDateTime, "selected": false});
        }
      }
    } else if (initialHourDateTime != null && finalHourDateTime != null) {
      for (var i = initialHour; i < finalHour; i++) {
        for (var j = 0; j < 60; j++) {
          initialHourDateTime = DateTime(
              currentDate.year, currentDate.month, currentDate.day, i, j);
          listHour.add({"date": initialHourDateTime, "selected": false});
        }
      }
    } else {
      for (var i = 0; i < 24; i++) {
        for (var j = 0; j < 60; j++) {
          initialHourDateTime = DateTime(
              currentDate.year, currentDate.month, currentDate.day, i, j);
          listHour.add({"date": initialHourDateTime, "selected": false});
        }
      }
    }
  }

  setDateSelected({DateTime date}) {
    var index = listHour.indexWhere((t) => t['date'] == date);

    listHour =
        listHour.map((m) => {"date": m['date'], "selected": false}).toList();

    listHour[index]['selected'] = true;
  }

  List<Event> validateEventsDate(List<Event> events) {
    List<Event> list = [];
    events.forEach((f) {
      f.initialDate = DateTime(f.initialDate.year, f.initialDate.month,
          f.initialDate.day, f.initialDate.hour, f.initialDate.minute);
      f.finalDate = DateTime(f.finalDate.year, f.finalDate.month,
          f.finalDate.day, f.finalDate.hour, f.finalDate.minute);
      list.add(f);
    });

    // list.sort((a, b) => a.initialDate.compareTo(b.initialDate));

    return list;
  }
}
