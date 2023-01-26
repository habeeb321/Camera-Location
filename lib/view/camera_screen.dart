import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week_6_camera/controller/camera_controller.dart';
import 'package:week_6_camera/controller/location_controller.dart';

ValueNotifier<List> db = ValueNotifier([]);

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CameraController cameraController = Get.put(CameraController());
    LocationController locationController = Get.put(LocationController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Camera'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Text('Camera Application')),
      ),
      floatingActionButton: GetBuilder<CameraController>(
        builder: (context) {
          return FloatingActionButton(
            onPressed: () async {
              await cameraController.cameraButton();
              locationController.accessLocation();
            },
            child: const Icon(Icons.camera_enhance),
          );
        },
      ),
    );
  }
}
