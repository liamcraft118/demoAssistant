import 'package:stardew_valley_assistant/network/api_client.dart';

class Network {
  static getTest() async {
    final response = await ApiClient.instance.get('/');
    print(response.body);
  }
}
