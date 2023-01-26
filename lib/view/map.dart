import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week_6_camera/controller/location_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.put(LocationController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GetBuilder<LocationController>(
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(locationController.locationMessage),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Go Back'),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
