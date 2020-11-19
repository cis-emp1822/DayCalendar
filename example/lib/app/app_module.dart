import 'package:example/app/app_controller.dart';
import 'package:example/app/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart' as fm;
import 'package:flutter/material.dart';
import 'package:example/app/app_widget.dart';

class AppModule extends fm.MainModule {
  @override
  List<fm.Bind> get binds => [
        fm.Bind((i) => AppController()),
      ];

  @override
  List<fm.Router> get routers => [
        fm.Router('/', module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static fm.Inject get to => fm.Inject<AppModule>.of();
}
