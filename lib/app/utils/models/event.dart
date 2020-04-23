import 'package:flutter/material.dart';

class Event {
  DateTime initialDate;
  DateTime finalDate;
  Color color;
  Color borderColor;
  String title;
  int id;

  Event({
    this.initialDate,
    this.finalDate,
    this.color,
    this.title = "",
    this.id,
    this.borderColor,
  });
}
