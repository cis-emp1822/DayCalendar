import 'package:date_util/date_util.dart';
import 'package:day_calendar/app/utils/models/event.dart';
import 'package:day_calendar/app/utils/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  ///Set initial hour of the timeline
  final int initialHour;

  ///Set final hour of the timeline
  final int finalHour;

  ///Current date
  DateTime currentDate;

  ///Function for get on taped date
  final OnTap onTap;

  ///List of Events
  List<Event> events = [];

  ///Color of day in header
  final Color colorOfHeader;

  ///Style for title of event
  final TextStyle eventTitleStyle;

  ///Function for get event data
  final OnEventTap onEventTap;

  ///color of selected hour/event
  final Color selectedColor;

  ///color for lines and text of timeline
  final Color colorTimeLine;

  ///event for change date
  final OnDateChange onDateChange;

  HomePage({
    Key key,
    this.finalHour,
    this.initialHour,
    this.currentDate,
    this.onTap,
    this.eventTitleStyle,
    this.colorOfHeader,
    this.onEventTap,
    this.colorTimeLine,
    this.selectedColor,
    this.onDateChange,
    @required this.events,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  PageController pageController;

  @override
  HomeController get controller => super.controller;

  @override
  void initState() {
    super.initState();
    controller.generateListDates(
      initialHour: widget.initialHour,
      finalHour: widget.finalHour,
      currentDate: widget.currentDate,
    );
    pageController = PageController(initialPage: widget.currentDate.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: widget.currentDate.day != DateTime.now().day
                                ? Colors.grey[400]
                                : widget.colorOfHeader == null
                                    ? Colors.blueAccent
                                    : widget.colorOfHeader,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          DateFormat('dd').format(widget.currentDate),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('EE', 'pt-br').format(widget.currentDate),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: DateUtil().daysInMonth(
                  widget.currentDate.month, widget.currentDate.year),
              controller: pageController,
              onPageChanged: (i) {
                setState(() {
                  widget.currentDate = DateTime(
                      widget.currentDate.year,
                      widget.currentDate.month,
                      i,
                      widget.currentDate.hour,
                      widget.currentDate.minute);
                });

                if (widget.onDateChange != null) {
                  widget.onDateChange(widget.currentDate);
                }
              },
              itemBuilder: (_, __) => Container(
                child: Observer(builder: (_) {
                  return SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Column(
                            children: buildListHours(),
                          ),
                          buildCardEvents().length > 0
                              ? Stack(
                                  children: buildCardEvents(),
                                )
                              : SizedBox.shrink()
                        ],
                      )
                    ]),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double generatePositionCard(DateTime date) {
    var index = controller.listHour.indexWhere((t) => t['date'] == date);

    return double.parse(((index * 1.33) + 1).toString());
  }

  double generateHeightCard(DateTime date) {
    var index = controller.listHour.indexWhere((t) => t['date'] == date);

    return double.parse(((index * 1.33) + 1).toString());
  }

  List<Widget> buildCardEvents() {
    List<Widget> list = [];
    widget.events.forEach((ev) async {
      if (ev.initialDate.day == widget.currentDate.day) {
        list.add(
          Padding(
            padding: EdgeInsets.only(top: generatePositionCard(ev.initialDate)),
            child: GestureDetector(
              onTap: () {
                if (widget.onEventTap != null) {
                  widget.onEventTap(ev);
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 56,
                  ),
                  cardEvent(ev),
                ],
              ),
            ),
          ),
        );
      }
    });

    return list;
  }

  Widget cardEvent(Event ev) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: ev.color,
          border: Border.all(
            color: ev.borderColor == null ? Colors.transparent : ev.borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          ),
        ),
        height: generateHeightCard(ev.finalDate) -
            generatePositionCard(ev.initialDate),
        child: Text(
          "${ev.title} ${DateFormat('HH:mm').format(ev.initialDate)} - ${DateFormat('HH:mm').format(ev.finalDate)}",
          style: widget.eventTitleStyle == null
              ? TextStyle(
                  color: Colors.white,
                )
              : widget.eventTitleStyle,
        ),
      ),
    );
  }

  List<Widget> buildListHours() {
    List<Widget> list = [];

    controller.listHour.forEach(
      (hour) {
        if ((hour['date'] as DateTime).minute == 00 ||
            (hour['date'] as DateTime).minute == 30) {
          list.add(
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      DateFormat('HH:mm').format(hour['date']),
                      style: TextStyle(
                          color: hour['selected']
                              ? widget.selectedColor == null
                                  ? Theme.of(context).primaryColor
                                  : widget.selectedColor
                              : widget.colorTimeLine == null
                                  ? Colors.grey[800]
                                  : widget.colorTimeLine),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.setDateSelected(date: hour['date']);
                                if (widget.onTap != null) {
                                  widget.onTap(hour['date']);
                                }
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  border: Border.fromBorderSide(
                                    BorderSide(
                                        width: hour['selected'] ? 2 : 1,
                                        color: hour['selected']
                                            ? widget.selectedColor == null
                                                ? Theme.of(context).primaryColor
                                                : widget.selectedColor
                                            : widget.colorTimeLine == null
                                                ? Colors.grey
                                                : widget.colorTimeLine),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      },
    );

    return list;
  }
}
