import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:stardew_valley_assistant/views/collections_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('home')),
      drawer: Drawer(
        child: ListView(
          children: [
            _buildDrawerHeader('Header'),
            _buildTile('calendar', () {}),
            _buildTile('collections', () {
              Get.put(CollectionsController());
              Get.to(() => const CollectionsPage());
            }),
          ],
        ),
      ),
    );
  }

  ListTile _buildTile(String title, Callback onTap) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildDrawerHeader(String title) {
    return DrawerHeader(
      decoration: const BoxDecoration(color: Colors.blue),
      child: Text(title),
    );
  }
}
