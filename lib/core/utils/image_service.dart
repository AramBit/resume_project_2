import 'dart:io';

import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static Future<String?> pickAndSaveImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final bytes = await File(pickedFile.path).readAsBytes();

    final result = await ImageGallerySaverPlus.saveImage(
      bytes,
      name: "my_image_${DateTime.now().millisecondsSinceEpoch}",
    );

    if (result['isSuccess'] != true) return null;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedPath = '${appDir.path}/$fileName';
    await File(pickedFile.path).copy(savedPath);

    return savedPath;
  }

  static Future<File?> loadSavedImage(String fileName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final imagePath = '${appDir.path}/$fileName';
    final file = File(imagePath);

    if (await file.exists()) {
      return file;
    } else {
      return null;
    }
  }
}
