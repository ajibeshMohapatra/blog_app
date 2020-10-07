import 'package:blog_app/app/locator.dart';
import 'package:blog_app/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  String title = "Login View";

  Future navigationToHome() async {
    await _navigationService.navigateTo(Routes.homeView);
  }
}
