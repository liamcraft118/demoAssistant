import 'package:get/get.dart';
import 'package:stardew_valley_assistant/models/models.dart';
import 'package:stardew_valley_assistant/models/schedule_model.dart';

class ScheduleController extends GetxController {
  var isLoading = true.obs;
  final schedule = ScheduleModel();

  void next() {
    schedule.next();
  }

  void previous() {
    schedule.previous();
  }

  void addPlantableEvent(Plantable plantable) {
    final number = schedule.number.value;
    final name = plantable.name;
    final growthTime = int.parse(plantable.growthTime);
    for (var i = 0; i < growthTime; i++) {
      final event =
          ScheduleEvent(name, i + number + 1, ScheduleEventType.plantable);
      schedule.addEvent(event);
    }
  }
}
