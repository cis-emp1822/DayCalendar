import 'package:date_util/date_util.dart';
import 'package:day_calendar_flutter/src/day_calendar_controller.dart';
import 'package:day_calendar_flutter/src/utils/models/event.dart';
import 'package:day_calendar_flutter/src/utils/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class DayCalendarFlutter extends StatefulWidget {
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

  ///Function for get event data
  final OnEventTap onEventTap;

  ///color of selected hour/event
  final Color selectedColor;

  ///color for lines and text of timeline
  final Color colorTimeLine;

  ///event for change date
  final OnDateChange onDateChange;

  DayCalendarFlutter({
    Key key,
    this.finalHour,
    this.initialHour,
    this.currentDate,
    this.onTap,
    this.colorOfHeader,
    this.onEventTap,
    this.colorTimeLine,
    this.selectedColor,
    this.onDateChange,
    @required this.events,
  }) : super(key: key);
  @override
  _DayCalendarFlutterState createState() => _DayCalendarFlutterState();
}

class _DayCalendarFlutterState extends State<DayCalendarFlutter> {
  PageController pageController;

  DayCalendarController controller = new DayCalendarController();

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
    return Column(
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
            itemCount: DateUtil()
                .daysInMonth(widget.currentDate.month, widget.currentDate.year),
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
                          children: _buildListHours(),
                        ),
                        _buildCardEvents().length > 0
                            ? Stack(
                                children: _buildCardEvents(),
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
    );
  }

  double _generatePositionCard(DateTime date) {
    var index = controller.listHour.indexWhere((t) => t['date'] == date);

    return double.parse(((index * 1.62) + 1).toString());
  }

  double _generateHeightCard(DateTime date) {
    var index = controller.listHour.indexWhere((t) => t['date'] == date);

    return double.parse(((index * 1.62) + 1).toString());
  }

  List<Widget> _buildCardEvents() {
    List<Widget> list = [];
    List<Event> events = [];
    widget.events.forEach((v) {
      events.add(v);
      controller.setListEv(events);
    });

    events = [];
    for (var e = 0; e < widget.events.length; e++) {
      Event ev = widget.events[e];
      if (ev.initialDate.day == widget.currentDate.day) {
        controller.listEv.removeWhere((t) => t == ev);

        controller.listEv.forEach((t) {
          if (t.initialDate.isAfter(ev.initialDate) &&
                  t.initialDate.isBefore(ev.finalDate) ||
              ev.initialDate.isAfter(t.initialDate) &&
                  ev.initialDate.isBefore(t.finalDate) ||
              t.initialDate.difference(ev.initialDate).inMinutes == 0) {
            events.add(t);
          }
        });

        list.add(
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: _generatePositionCard(ev.initialDate),
                  left: 76,
                ),
                child: Row(
                  mainAxisAlignment: events.indexOf(ev) != -1
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (widget.onEventTap != null) {
                          widget.onEventTap(ev);
                        }
                      },
                      child: _cardEvent(
                        ev,
                        width: events.length > 0
                            ? MediaQuery.of(context).size.width * 0.4
                            : MediaQuery.of(context).size.width * 0.804347,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }
    return list;
  }

  Widget _cardEvent(Event ev, {double width}) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: ev.color,
        border: Border.all(
          color: ev.borderColor == null ? Colors.transparent : ev.borderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(2),
          bottomLeft: Radius.circular(2),
        ),
      ),
      height: _generateHeightCard(ev.finalDate) -
          _generatePositionCard(ev.initialDate),
      child: Text(
        "${ev.title} ${DateFormat('HH:mm').format(ev.initialDate)} - ${DateFormat('HH:mm').format(ev.finalDate)}",
        style: ev.eventTitleStyle == null
            ? TextStyle(
                color: Colors.white,
              )
            : ev.eventTitleStyle,
      ),
    );
  }

  List<Widget> _buildListHours() {
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.setDateSelected(date: hour['date']);
                                if (widget.onTap != null) {
                                  widget.onTap(hour['date']);
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.lerp(
                                    Border(
                                      top: BorderSide(
                                          width: hour['selected'] ? 2 : 1,
                                          color: hour['selected']
                                              ? widget.selectedColor == null
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : widget.selectedColor
                                              : widget.colorTimeLine == null
                                                  ? Colors.grey
                                                  : widget.colorTimeLine),
                                    ),
                                    Border(
                                      top: BorderSide(
                                          width: hour['selected'] ? 2 : 1,
                                          color: hour['selected']
                                              ? widget.selectedColor == null
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : widget.selectedColor
                                              : widget.colorTimeLine == null
                                                  ? Colors.grey
                                                  : widget.colorTimeLine),
                                    ),
                                    1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
