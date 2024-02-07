import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stardew_valley_assistant/controllers/plantable_controller.dart';
import 'package:stardew_valley_assistant/controllers/schedule_controller.dart';
import 'package:stardew_valley_assistant/models/models.dart';

class PlantablePage extends GetView<PlantableController> {
  const PlantablePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlantableController());
    return Scaffold(
      appBar: AppBar(title: const Text("Plantables")),
      body: _buildContent(),
    );
  }

  Obx _buildContent() {
    return Obx(() {
      final plantables = controller.plantables;
      return ListView.builder(
        itemCount: plantables.length,
        itemBuilder: ((context, index) {
          final plantable = plantables[index];
          return _buildTile(plantable);
        }),
      );
    });
  }

  ListTile _buildTile(Plantable plantable) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(plantable.name),
          ),
          Text(plantable.growthTime),
        ],
      ),
      onTap: () => _plantableTapAction(plantable),
    );
  }

  void _plantableTapAction(Plantable plantable) {
    final scheduleController = Get.find<ScheduleController>();
    scheduleController.addPlantableEvent(plantable);
    Get.snackbar("Add Event", "${plantable.name} is added");
  }
}
