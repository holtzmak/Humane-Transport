import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';

// TODO: Update as per #158. May combine with SignInViewModel as a single ViewModel
class SignOutViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signOut() async {
    try {
      await _authenticationService.signOut();
      _navigationService.pop();
    } catch (e) {
      print(e.message);
    }
  }
}
