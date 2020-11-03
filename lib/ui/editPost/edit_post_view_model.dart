import 'package:blog_app/app/locator.dart';
import 'package:blog_app/app/router.gr.dart';
import 'package:blog_app/models/post.dart';
import 'package:blog_app/models/user.dart';
import 'package:blog_app/services/authentication_service.dart';
import 'package:blog_app/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EditPostViewModel extends BaseViewModel {
  final Post post;
  EditPostViewModel({this.post});

  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;

  Future addPost({@required String title}) async {
    setBusy(true);
    var result;
    result = await _firestoreService.updatePosts(Post(
      userId: post.userId,
      title: title,
      documentId: post.documentId,
      imageUrl: post.imageUrl,
      imageFileName: post.imageFileName,
    ));
    setBusy(false);
    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not update Post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully added',
        description: 'Your post has been updated',
      );
    }

    _navigationService.clearStackAndShow(Routes.homeView);
  }
}
