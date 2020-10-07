import 'package:blog_app/app/locator.dart';
import 'package:blog_app/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  String title = "Home";

  Future navigationToLogin() async {
    await _navigationService.navigateTo(Routes.loginView);
  }
}
