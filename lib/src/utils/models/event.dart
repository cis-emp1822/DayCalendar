import 'dart:convert';

import 'package:day_calendar_flutter/src/utils/typedefs.dart';
import 'package:flutter/material.dart';

class Event {
  DateTime initialDate;
  DateTime finalDate;
  Color color;
  String title;
  int id;
  Color borderColor;
  TextStyle eventTitleStyle;
  bool showHours;
  final OnEventTap onEventTap;
  final bool allDay;

  Event(
      {this.initialDate,
      this.finalDate,
      this.color,
      this.title,
      this.id,
      this.borderColor,
      this.eventTitleStyle,
      this.showHours,
      this.allDay = false,
      @required this.onEventTap,
    });

  factory Event.fromJson(String str) => Event.fromMap(json.decode(str));

  bool get shouldDraw => initialDate != null && finalDate != null;

  bool collidesWith(Event other) {
    if (!shouldDraw || !other.shouldDraw) {
      return false;
    }

    return finalDate.isAfter(other.initialDate) &&
        initialDate.isBefore(other.finalDate);
  }

  String toJson() => json.encode(toMap());

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        initialDate: json["initialDate"] == null ? null : json["initialDate"],
        finalDate: json["finalDate"] == null ? null : json["finalDate"],
        color: json["color"] == null ? null : json["color"],
        title: json["title"] == null ? null : json["title"],
        id: json["id"] == null ? null : json["id"],
        borderColor: json["borderColor"] == null ? null : json["borderColor"],
        eventTitleStyle: json["eventTitleStyle"] == null
            ? TextStyle(color: Colors.white)
            : json['eventTitleStyle'],
        showHours: json['showHours'] == null ? null : json['showHours'],
        onEventTap: json['eventTap'] == null ? null : json['eventTap'],
        allDay: json["allDay"] == null ? null : json["allDay"],
      );

  Map<String, dynamic> toMap() => {
        "initialDate": initialDate == null ? null : initialDate,
        "finalDate": finalDate == null ? null : finalDate,
        "color": color == null ? null : color,
        "title": title == null ? null : title,
        "id": id == null ? null : id,
        "borderColor": borderColor == null ? null : borderColor,
        "eventTitleStyle": eventTitleStyle == null
            ? TextStyle(color: Colors.white)
            : eventTitleStyle,
        "showHours": showHours == null ? null : showHours,
        "eventTap": onEventTap == null ? null : onEventTap,
        "allDay": allDay == null ? null : allDay,
      };
}
