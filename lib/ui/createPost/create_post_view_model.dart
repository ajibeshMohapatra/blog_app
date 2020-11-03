import 'dart:io';
import 'package:blog_app/app/locator.dart';
import 'package:blog_app/app/router.gr.dart';
import 'package:blog_app/models/cloud_storage_result.dart';
import 'package:blog_app/models/post.dart';
import 'package:blog_app/models/user.dart';
import 'package:blog_app/services/authentication_service.dart';
import 'package:blog_app/services/cloud_storage_service.dart';
import 'package:blog_app/services/firestore_services.dart';
import 'package:blog_app/utils/image_selector.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreatePostViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  File _selectedImage;
  File get selectedImage => _selectedImage;

  CloudStorageResult _storageResult;

  Future selectImage(String type) async {
    var tempImage = await _imageSelector.selectImage(type);
    if (tempImage != null) {
      _selectedImage = tempImage;
      notifyListeners();
    }
  }

  StorageUploadTask get uploadTask => _cloudStorageService.uploadTask;

  Future upload({@required String title}) async {
    setBusy(true);
    _storageResult = await _cloudStorageService.uploadImage(
      imageToupload: _selectedImage,
      title: title,
    );

    setBusy(false);
    await _dialogService.showDialog(
      title: 'Image successfully added',
      description: 'Your image has been uploaded',
    );
  }

  User get currentUser => _authenticationService.currentUser;

  Future addPost({@required String title}) async {
    setBusy(true);
    var result;
    result = await _firestoreService.addPost(Post(
      title: title,
      userId: currentUser.id,
      imageUrl: _storageResult.imageUrl,
      imageFileName: _storageResult.imageFileName,
    ));

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not create Post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully added',
        description: 'Your post has been created',
      );
    }

    _navigationService.clearStackAndShow(Routes.homeView);
  }
}
