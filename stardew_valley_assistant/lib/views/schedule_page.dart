import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:stardew_valley_assistant/controllers/schedule_controller.dart';
import 'package:stardew_valley_assistant/network/network.dart';

class SchedulePage extends GetView<ScheduleController> {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSchedulePage(),
        _buildButtons(),
      ],
    );
  }

  Widget _buildSchedulePage() {
    return const Text("一条数据");
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton('Previous', () {
          Network.getTest();
          print("Previous");
        }),
        _buildButton('Next', () {
          print("Next");
        }),
      ],
    );
  }

  Widget _buildButton(String text, VoidCallback action) {
    return Expanded(
      child: ElevatedButton(
        onPressed: action,
        child: Text(text),
      ),
    );
  }
}
