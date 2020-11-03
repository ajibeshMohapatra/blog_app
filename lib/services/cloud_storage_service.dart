import 'dart:io';

import 'package:blog_app/models/cloud_storage_result.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CloudStorageService {
  StorageUploadTask _uploadTasks;
  StorageUploadTask get uploadTask => _uploadTasks;

  Future<CloudStorageResult> uploadImage({
    @required File imageToupload,
    @required String title,
  }) async {
    var imageFileName =
        title + DateTime.now().microsecondsSinceEpoch.toString();
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageFileName);
    _uploadTasks = firebaseStorageRef.putFile(imageToupload);
    StorageTaskSnapshot storageSnapshot = await _uploadTasks.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (_uploadTasks.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(imageUrl: url, imageFileName: imageFileName);
    }

    return null;
  }

  Future deleteImage(String imageFileName) async {
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageFileName);

    try {
      await firebaseStorageRef.delete();
    } catch (e) {
      return e.toString();
    }
  }
}
