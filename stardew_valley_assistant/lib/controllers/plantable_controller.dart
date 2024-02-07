import 'package:get/get.dart';
import 'package:stardew_valley_assistant/models/models.dart';
import 'package:stardew_valley_assistant/network/network.dart';

class PlantableController extends GetxController {
  RxList<Plantable> plantables = <Plantable>[].obs;
  @override
  void onInit() async {
    super.onInit();
    plantables.value = await Network.findPlantables();
  }
}
