import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/dialogs/dialogs_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/welcome/welcome.dart';

class SignOutViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future<void> signOut() async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Sign Out',
      description: 'Are you sure you want to sign out?',
      confirmationText: 'Yes',
      cancelText: 'No',
    );
    if (dialogResponse.confirmed) {
      setBusy(true);
      _navigationService.navigateTo(WelcomeScreen.route);
      await _authenticationService.signOut();
      setBusy(false);
    }
  }
}
