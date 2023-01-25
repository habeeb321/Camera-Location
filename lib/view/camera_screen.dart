import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week_6_camera/controller/camera_controller.dart';
import 'package:week_6_camera/view/screen_two.dart';

ValueNotifier<List> db = ValueNotifier([]);

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CameraController cameraController = Get.put(CameraController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Images'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: db,
          builder: (context, List data, text) {
            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
              ),
              children: List.generate(
                data.length,
                (index) {
                  return GestureDetector(
                    onTap: (() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ImageView(
                            image: data[index],
                          ),
                        ),
                      );
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: FileImage(
                            File(
                              data[index].toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: GetBuilder<CameraController>(builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            cameraController.cameraButton();
          },
          child: const Icon(Icons.camera_enhance),
        );
      }),
    );
  }
}
