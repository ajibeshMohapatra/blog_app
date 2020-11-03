import 'package:blog_app/app/locator.dart';
import 'package:blog_app/services/authentication_service.dart';
import 'package:stacked/stacked.dart';

class StartUpViewModel extends FutureViewModel<bool> {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<bool> handleStartUpLogic() async {
    setBusy(true);
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();
    setBusy(false);
    return hasLoggedInUser;
  }

  @override
  Future<bool> futureToRun() => handleStartUpLogic();
}
