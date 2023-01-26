import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:week_6_camera/view/camera_screen.dart';

class CameraController extends GetxController {
  
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
}
