// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$listHourAtom = Atom(name: '_HomeControllerBase.listHour');

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

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void generateListDates(
      {int initialHour, int finalHour, DateTime currentDate}) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.generateListDates(
          initialHour: initialHour,
          finalHour: finalHour,
          currentDate: currentDate);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'listHour: ${listHour.toString()}';
    return '{$string}';
  }
}
