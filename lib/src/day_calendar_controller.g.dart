// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_calendar_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DayCalendarController on _DayCalendarControllerBase, Store {
  final _$listHourAtom = Atom(name: '_DayCalendarControllerBase.listHour');

  @override
  List<Map<String, dynamic>> get listHour {
    _$listHourAtom.context.enforceReadPolicy(_$listHourAtom);
    _$listHourAtom.reportObserved();
    return super.listHour;
  }

  @override
  set listHour(List<Map<String, dynamic>> value) {
    _$listHourAtom.context.conditionallyRunInAction(() {
      super.listHour = value;
      _$listHourAtom.reportChanged();
    }, _$listHourAtom, name: '${_$listHourAtom.name}_set');
  }

  final _$listEvAtom = Atom(name: '_DayCalendarControllerBase.listEv');

  @override
  List<Event> get listEv {
    _$listEvAtom.context.enforceReadPolicy(_$listEvAtom);
    _$listEvAtom.reportObserved();
    return super.listEv;
  }

  @override
  set listEv(List<Event> value) {
    _$listEvAtom.context.conditionallyRunInAction(() {
      super.listEv = value;
      _$listEvAtom.reportChanged();
    }, _$listEvAtom, name: '${_$listEvAtom.name}_set');
  }

  final _$_DayCalendarControllerBaseActionController =
      ActionController(name: '_DayCalendarControllerBase');

  @override
  dynamic setListEv(List<Event> list) {
    final _$actionInfo =
        _$_DayCalendarControllerBaseActionController.startAction();
    try {
      return super.setListEv(list);
    } finally {
      _$_DayCalendarControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeEvFromList(Event ev) {
    final _$actionInfo =
        _$_DayCalendarControllerBaseActionController.startAction();
    try {
      return super.removeEvFromList(ev);
    } finally {
      _$_DayCalendarControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void generateListDates(
      {int initialHour, int finalHour, DateTime currentDate}) {
    final _$actionInfo =
        _$_DayCalendarControllerBaseActionController.startAction();
    try {
      return super.generateListDates(
          initialHour: initialHour,
          finalHour: finalHour,
          currentDate: currentDate);
    } finally {
      _$_DayCalendarControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'listHour: ${listHour.toString()},listEv: ${listEv.toString()}';
    return '{$string}';
  }
}
