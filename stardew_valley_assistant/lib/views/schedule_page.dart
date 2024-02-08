import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stardew_valley_assistant/controllers/schedule_controller.dart';
import 'package:stardew_valley_assistant/views/add_event_page.dart';

class SchedulePage extends GetView<ScheduleController> {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ScheduleController());
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: _buildTitle(),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => const AddEventPage());
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Obx _buildTitle() {
    return Obx(() {
      final schedule = controller.schedule;
      final season = schedule.season();
      final year = schedule.year();
      final day = schedule.day();
      final totalDay = schedule.totalDay();
      return Text("第$year年 $season 第$day天, $totalDay");
    });
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildSchedulePage(),
        _buildButtons(),
      ],
    );
  }

  Widget _buildSchedulePage() {
    final events = controller.schedule.currEvents;
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(event.name),
                  ),
                  if (event.remark != null) Text(event.remark)
                ],
              ),
              onTap: () {
                print("$index tapped");
              },
            );
          },
        );
      }),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton('Previous', () {
          controller.previous();
          print("Previous");
        }),
        _buildButton('Next', () {
          controller.next();
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
