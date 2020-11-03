import 'package:blog_app/app/locator.dart';
import 'package:blog_app/app/router.gr.dart';
import 'package:blog_app/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future signUp({
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
      role: 'User',
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.clearStackAndShow(Routes.homeView);
      } else {
        await _dialogService.showDialog(
          title: 'SignUp Failure',
          description: 'SignUp Error . Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'SignUp Failure',
        description: result,
      );
    }
  }
}
