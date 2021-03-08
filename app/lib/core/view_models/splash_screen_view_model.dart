import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/welcome_screen.dart';

class SplashScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  //TODO: Add logic to check if user is logged in
  Future handleStartLogic() async {
    Future.delayed(Duration(seconds: 3))
        .then((value) => _navigationService.navigateTo(WelcomeScreen.route));
  }
}
