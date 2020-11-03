import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ImageSelector {
  Future<File> selectImage(String type) async {
    if (type == 'g') {
      // ignore: deprecated_member_use
      return await ImagePicker.pickImage(source: ImageSource.gallery);
    } else if (type == 'c') {
      // ignore: deprecated_member_use
      return await ImagePicker.pickImage(source: ImageSource.camera);
    }
    return null;
  }
}
