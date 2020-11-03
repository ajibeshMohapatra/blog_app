import 'package:blog_app/app/locator.dart';
import 'package:blog_app/app/router.gr.dart';
import 'package:blog_app/services/authentication_service.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future logIn({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.clearStackAndShow(Routes.homeView);
      } else {
        await _dialogService.showDialog(
          title: 'LogIn Failure',
          description: 'SignUp Error . Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'LogIn Failure',
        description: result,
      );
    }
  }

  Future navigationToSignUp() async {
    await _navigationService.navigateTo(Routes.signUpView);
  }
}
