import 'package:blog_app/app/locator.dart';
import 'package:blog_app/app/router.gr.dart';
import 'package:blog_app/models/user.dart';
import 'package:blog_app/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  String title = "Home";

  User get user {
    return _authenticationService.currentUser;
  }

  Future navigationToLogin() async {
    await _navigationService.clearTillFirstAndShow(Routes.loginView);
  }

  Future navigationToPosts() async {
    await _navigationService.navigateTo(Routes.postView);
  }

  Future navigationToCreatePost() async {
    await _navigationService.navigateTo(Routes.createPostView);
  }

  Future signOut() async {
    var result = await _authenticationService.signOut();
    if (result is String) {
      await _dialogService.showDialog(
        title: 'SignOut Failure',
        description: result,
      );
    } else {
      await _navigationService.clearStackAndShow(Routes.startUpView);
      notifyListeners();
    }
  }
}
