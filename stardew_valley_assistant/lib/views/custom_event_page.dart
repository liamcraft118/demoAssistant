import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stardew_valley_assistant/controllers/custom_event_controller.dart';

class CustomEventPage extends GetView<CustomEventController> {
  const CustomEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomEventController());
    return Scaffold(
      appBar: AppBar(title: const Text("CustomEvent")),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return ListView(
      children: [],
    );
  }

  ListTile _buildTile() {
    return ListTile(
      title: const Row(
        children: [
          Expanded(
            child: Text("test"),
          ),
          Text("test"),
        ],
      ),
      onTap: () => _plantableTapAction(),
    );
  }

  void _plantableTapAction() {}
}
