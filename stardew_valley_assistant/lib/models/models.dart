import 'package:json_annotation/json_annotation.dart';
part 'example.g.dart';

enum CalendarType {
  birthday,
  festival,
  event,
}

@JsonSerializable()
class Calendar {
  final int day;
  final String name;
  final CalendarType type;

  Calendar({required this.day, required this.name, required this.type});
}
