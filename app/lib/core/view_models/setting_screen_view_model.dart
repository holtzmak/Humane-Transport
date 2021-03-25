import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/dialog_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/welcome_screen.dart';

class SettingScreenViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void signOut() async {
    _authenticationService
        .signOut()
        .then((_) => _navigationService.navigateAndReplace(WelcomeScreen.route))
        .catchError((error) => _dialogService.showDialog(
              title: 'Sign out failed',
              description: error.message,
            ));
  }
}
