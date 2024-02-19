import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

enum CalendarType {
  birthday,
  festival,
  event,
}

enum CollectionType {
  @JsonValue('shipped_item')
  shippedItem,
  fish,
  artifact,
  mineral,
  cooking,
}

@JsonSerializable()
class Calendar {
  final int day;
  final String name;
  final CalendarType type;

  Calendar({required this.day, required this.name, required this.type});
  factory Calendar.fromJson(Map<String, dynamic> json) =>
      _$CalendarFromJson(json);
  Map<String, dynamic> toJson() => _$CalendarToJson(this);
}

@JsonSerializable()
class Plantable {
  final String name;
  @JsonKey(name: 'growth_time')
  final String growthTime;

  Plantable(this.name, this.growthTime);
  factory Plantable.fromJson(Map<String, dynamic> json) =>
      _$PlantableFromJson(json);
  Map<String, dynamic> toJson() => _$PlantableToJson(this);
}

@JsonSerializable()
class CollectionModel {
  final String name;
  final String link;
  @JsonKey(name: 'icon_link')
  final String iconLink;
  final CollectionType type;

  CollectionModel(this.name, this.link, this.iconLink, this.type);
  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionModelToJson(this);
}
