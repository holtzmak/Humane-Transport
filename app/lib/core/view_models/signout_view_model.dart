import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';

class SignOutViewModel extends BaseViewModel {
  //Inject auth service
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signOut() async {
    // TODO: Should handle exception error
    try {
      await _authenticationService.signOut();
      _navigationService.pop();
      print('user successfully signed out');
    } catch (e) {
      print(e.message);
    }
  }
}
