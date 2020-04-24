# Day Calendar

[![Pub Package](https://img.shields.io/pub/v/day_calendar_flutter.svg?style=flat-square)](https://pub.dartlang.org/packages/day_calendar_flutter)

| ![github-small](assets/img/readme_1.png) | ![github-small](assets/img/readme_2.png) |
| :------------: | :------------: |
 **Day calendar** with custom styles

## Usage

Make sure to check out [example project](https://github.com/RodolfoBonis/DayCalendar/tree/master/example).

### Installation

**Attention use of package flutter_localizations is required**

Add to pubspec.yaml:

```yaml
dependencies:
  day_calendar_flutter: ^1.0.2

flutter_localizations:
  sdk: flutter
```

**Implements the code below in your MaterialApp**
```dart
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      locale: Locale('pt', 'BR'),
    );
  }
```

**Import the package in your projetct**

```dart
import 'package:day_calendar_flutter/day_calendar_flutter.dart';
```

**Use the package in your project**

```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DayCalendarFlutter(
        currentDate: DateTime.now(),
        onEventTap: (ev) {
          print(ev.title);
        },
        events: [
          new Event(
            color: Colors.cyan,
            initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 10, 05),
            finalDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 11, 05),
            title: "Reunião",
            eventTitleStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            showHours: true,
          ),
        ],
        onTap: (date) {
          print(DateFormat('HH:mm').format(date));
        },
      ),
    );
  }
```
