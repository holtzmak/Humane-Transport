import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/home_screen.dart';
import 'package:app/ui/views/welcome_screen.dart';

class SplashScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  void skipToHomeScreenIfLoggedIn() {
    if (_authenticationService.currentUser.isPresent()) _navigateToHomeScreen();
    _navigationService.navigateTo(WelcomeScreen.route);
  }

  void _navigateToHomeScreen() =>
      _navigationService.navigateTo(HomeScreen.route);

  Future handleStartLogic() async {
    Future.delayed(Duration(seconds: 3))
        .then((_) => skipToHomeScreenIfLoggedIn());
  }
}
