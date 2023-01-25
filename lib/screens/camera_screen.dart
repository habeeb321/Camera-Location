import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:week_6_camera/screens/screen_two.dart';

ValueNotifier<List> db = ValueNotifier([]);

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cameraButton();
        },
        child: const Icon(Icons.camera_enhance),
      ),
    );
  }
}

void cameraButton() async {
  final image = await ImagePicker().pickImage(source: ImageSource.camera);
  if (image == null) {
    return;
  } else {
    Directory? directory = await getExternalStorageDirectory();
    File imagepath = File(image.path);

    await imagepath.copy('${directory!.path}/${DateTime.now()}.jpg');

    getitems(directory);
  }
}

getitems(Directory directory) async {
  final listDir = await directory.list().toList();
  db.value.clear();
  for (var i = 0; i < listDir.length; i++) {
    if (listDir[i].path.substring(
            (listDir[i].path.length - 4), (listDir[i].path.length)) ==
        '.jpg') {
      db.value.add(listDir[i].path);
      db.notifyListeners();
    }
  }
}
