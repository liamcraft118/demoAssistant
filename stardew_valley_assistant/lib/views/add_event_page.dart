import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stardew_valley_assistant/controllers/add_event_controller.dart';
import 'package:stardew_valley_assistant/views/custom_event_page.dart';
import 'package:stardew_valley_assistant/views/plantable_page.dart';

class AddEventPage extends GetView<AddEventController> {
  const AddEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddEventController());
    return Scaffold(
      appBar: AppBar(title: const Text("Add")),
      body: ListView(
        children: [
          _buildTile("plantable", () {
            Get.to(() => const PlantablePage());
          }),
          _buildTile("custom", () {
            Get.to(() => const CustomEventPage());
          })
        ],
      ),
    );
  }

  Widget _buildTile(String name, VoidCallback action) {
    return ListTile(
      title: Text(name),
      onTap: action,
    );
  }
}
