// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Calendar _$CalendarFromJson(Map<String, dynamic> json) => Calendar(
      day: json['day'] as int,
      name: json['name'] as String,
      type: $enumDecode(_$CalendarTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$CalendarToJson(Calendar instance) => <String, dynamic>{
      'day': instance.day,
      'name': instance.name,
      'type': _$CalendarTypeEnumMap[instance.type]!,
    };

const _$CalendarTypeEnumMap = {
  CalendarType.birthday: 'birthday',
  CalendarType.festival: 'festival',
  CalendarType.event: 'event',
};

Plantable _$PlantableFromJson(Map<String, dynamic> json) => Plantable(
      json['name'] as String,
      json['growth_time'] as String,
    );

Map<String, dynamic> _$PlantableToJson(Plantable instance) => <String, dynamic>{
      'name': instance.name,
      'growth_time': instance.growthTime,
    };

CollectionModel _$CollectionModelFromJson(Map<String, dynamic> json) =>
    CollectionModel(
      json['name'] as String,
      json['link'] as String,
      json['icon_link'] as String,
      $enumDecode(_$CollectionTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$CollectionModelToJson(CollectionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'link': instance.link,
      'icon_link': instance.iconLink,
      'type': _$CollectionTypeEnumMap[instance.type]!,
    };

const _$CollectionTypeEnumMap = {
  CollectionType.shippedItem: 'shipped_item',
  CollectionType.fish: 'fish',
  CollectionType.artifact: 'artifact',
  CollectionType.mineral: 'mineral',
  CollectionType.cooking: 'cooking',
};
