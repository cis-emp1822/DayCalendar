import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  List<Map<String, dynamic>> listHour = [];

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
}
