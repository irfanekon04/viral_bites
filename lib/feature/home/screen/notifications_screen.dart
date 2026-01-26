import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viral_bites/feature/home/controller/home_screen_controller.dart';

class NotificationsScreen extends StatelessWidget {
   NotificationsScreen({super.key});
  final arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: .all(16),
        child: Column(children: [Center(child: Text('Notifications'))]),
      ),
    );
  }
}
