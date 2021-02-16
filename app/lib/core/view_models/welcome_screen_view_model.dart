import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/home/home_screen.dart';
import 'package:app/ui/views/signin/sign_in_screen.dart';

class WelcomeScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToSignInScreen() =>
      _navigationService.navigateTo(SignInScreen.route);

  void navigateToHomeScreen() =>
      _navigationService.navigateTo(HomeScreen.route);
}
