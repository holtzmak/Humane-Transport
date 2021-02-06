import 'package:app/core/enums/auth_result_status.dart';
import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/home/home.dart';
import 'package:app/ui/views/welcome/welcome.dart';

class SplashScreenViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartLogic() async {
    var result = await _authenticationService.isLoggedIn();

    if (result == ResultStatus.isLoggedIn) {
      Future.delayed(Duration(seconds: 3))
          .then((value) => _navigationService.navigateTo(HomeRootScreen.route));
    } else {
      Future.delayed(Duration(seconds: 3))
          .then((value) => _navigationService.navigateTo(WelcomeScreen.route));
    }
  }
}
