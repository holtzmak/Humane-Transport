import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/signin/sign_in.dart';
import 'package:app/ui/views/signup/signup.dart';

// TODO: To Mansi - Add something if needed
class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToSignUpView() {
    _navigationService.navigateTo(SignUpScreen.route);
  }

  void navigateToSignInView() {
    _navigationService.navigateTo(SignInScreen.route);
  }
}
