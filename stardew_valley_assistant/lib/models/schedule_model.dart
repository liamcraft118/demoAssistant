import 'package:get/get.dart';
import 'package:stardew_valley_assistant/models/models.dart';
import 'package:stardew_valley_assistant/network/network.dart';

class ScheduleModel {
  var number = 0.obs;
  List<ScheduleEvent> allEvents = [];
  List<Calendar> calendars = [];
  var currEvents = [].obs;

  ScheduleModel() {
    init();
  }

  Future<void> init() async {
    calendars = await Network.findCalendars();
    _update();
    _updateCurrEvents();
  }

  void next() {
    number++;
    _updateCurrEvents();
    print(currEvents);
  }

  void previous() {
    if (number.value > 0) {
      number--;
      _updateCurrEvents();
      print(currEvents);
    }
  }

  String season() {
    final season = number.value % (28 * 4) ~/ 28;
    switch (season) {
      case 0:
        return "Spring";
      case 1:
        return "Summber";
      case 2:
        return "Fall";
      case 3:
        return "Winter";
      default:
        return "Spring";
    }
  }

  String year() {
    return (number.value ~/ (28 * 4) + 1).toString();
  }

  String day() {
    return (number.value % 28 + 1).toString();
  }

  int totalDay() {
    return number.value + 1;
  }

  void addEvent(ScheduleEvent event) {
    allEvents.add(event);
    _updateCurrEvents();
    print("mtest $event");
  }

  void _update() {
    for (var calendar in calendars) {
      final name = calendar.name;
      final start = calendar.day;
      ScheduleEventType type;
      switch (calendar.type) {
        case CalendarType.birthday:
          type = ScheduleEventType.birthday;
          break;
        case CalendarType.festival:
          type = ScheduleEventType.festival;
          break;
        case CalendarType.event:
          type = ScheduleEventType.festival;
          break;
      }
      final event = ScheduleEvent(name, start, type);
      allEvents.add(event);
    }
  }

  void _updateCurrEvents() {
    currEvents.value = [];

    for (var event in allEvents) {
      if (event.day == totalDay()) {
        currEvents.add(event);
      }
    }
  }
}

class ScheduleEvent {
  final String name;
  final int day;
  final ScheduleEventType type;
  String? remark;

  ScheduleEvent(this.name, this.day, this.type);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScheduleEvent && other.name == name && other.day == day;
  }

  @override
  int get hashCode => name.hashCode ^ day.hashCode;

  @override
  String toString() {
    return 'ScheduleEvent{name: $name, start: $day, type: $type}';
  }
}

enum ScheduleEventType { plant, birthday, festival, event, plantable }
