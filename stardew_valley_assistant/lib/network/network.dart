import 'package:stardew_valley_assistant/models/models.dart';
import 'package:stardew_valley_assistant/network/api_client.dart';

class Network {
  static getTest() async {
    final response = await ApiClient.instance.get('/');
  }

  static Future<List<Calendar>> findCalendars() async {
    final response = await ApiClient.instance.get('/findCalendar');
    final body = response.body;
    List<Calendar> calendars = [];
    for (var json in body) {
      final calendar = Calendar.fromJson(json);
      calendars.add(calendar);
    }
    return calendars;
  }

  static Future<List<Plantable>> findPlantables() async {
    final response = await ApiClient.instance.get('/findPlantable');
    final body = response.body;
    List<Plantable> plantables = [];
    for (var json in body) {
      final plantable = Plantable.fromJson(json);
      int? result = int.tryParse(plantable.growthTime);
      if (result != null) {
        plantables.add(plantable);
      }
    }
    return plantables;
  }

  static Future<List<CollectionModel>> findCollections() async {
    final response = await ApiClient.instance.get('/find_collections');
    List<CollectionModel> collections = [];
    for (var json in response.body) {
      final collection = CollectionModel.fromJson(json);
      collections.add(collection);
    }
    return collections;
  }
}
