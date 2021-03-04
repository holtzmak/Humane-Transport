import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/active/atr_editing_screen.dart';
import 'package:app/ui/views/new/test_screens/test_screen_three.dart';

class NewScreenViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
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

  Future<void> startNewAtr() async {
    _databaseService
        .saveNewAtr(_authenticationService.currentUser.get().uid)
        .then((atr) => _navigationService.navigateTo(ATREditingScreen.route,
            arguments: atr))
        .catchError((e) => _dialogService.showDialog(
              title: 'Starting a new Animal Transport Record failed',
              description: e.message,
            ));
  }

  void navigateToTestScreenThree() =>
      _navigationService.navigateTo(TestScreenThree.route);

  void navigateToNewScreen() => _navigationService.pop();
}
