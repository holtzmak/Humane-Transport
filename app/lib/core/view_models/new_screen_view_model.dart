import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/new/test_screens/test_screen_three.dart';

class NewScreenViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void signOut() async {
    _authenticationService
        .signOut()
        .then((_) => _navigationService.pop())
        .catchError((error) => _dialogService.showDialog(
              title: 'Sign out failed',
              description: error.message,
            ));
  }

  void navigateToTestScreenThree() =>
      _navigationService.navigateTo(TestScreenThree.route);

  void navigateToNewScreen() => _navigationService.pop();
}
