import 'package:blog_app/app/locator.dart';
import 'package:blog_app/app/router.gr.dart';
import 'package:blog_app/models/post.dart';
import 'package:blog_app/models/user.dart';
import 'package:blog_app/services/authentication_service.dart';
import 'package:blog_app/services/cloud_storage_service.dart';
import 'package:blog_app/services/firestore_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PostViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  User get user {
    return _authenticationService.currentUser;
  }

  List<Post> _posts;
  List<Post> get posts => _posts;

  void listenToPosts() {
    setBusy(true);
    _firestoreService.listenToPostsRealTime().listen((postsData) {
      List<Post> updatedPosts = postsData;
      if (updatedPosts != null && updatedPosts.length > 0) {
        _posts = updatedPosts;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future deletePost(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
        title: 'Are you sure ?',
        description: 'Do you really want to delete this post ?',
        confirmationTitle: 'Yes',
        cancelTitle: 'No');

    if (dialogResponse.confirmed) {
      var postToDelete = _posts[index];
      setBusy(true);
      await _firestoreService.deletePost(postToDelete.documentId);
      await _cloudStorageService.deleteImage(postToDelete.imageFileName);
      setBusy(false);
    }
  }

  void editPost(int index) {
    _navigationService.navigateTo(Routes.editPostView,
        arguments: EditPostViewArguments(edittingPost: _posts[index]));
  }

  Future navigationToHome() async {
    await _navigationService.navigateTo(Routes.homeView);
  }

  Future navigationToCreatePost() async {
    await _navigationService.navigateTo(Routes.createPostView);
  }

  Future navigationToPosts() async {
    await _navigationService.navigateTo(Routes.postView);
  }
}
