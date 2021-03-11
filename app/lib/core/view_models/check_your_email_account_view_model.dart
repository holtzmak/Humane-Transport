import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/sign_in_screen.dart';

class ConfirmationMessageModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToSignInScreen() =>
      _navigationService.navigateTo(SignInScreen.route);
}
