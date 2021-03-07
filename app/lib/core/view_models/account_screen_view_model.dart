import 'package:app/core/models/transporter.dart';
import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/ui/views/account/account_editing_screen.dart';
import 'package:app/ui/views/account/account_screen.dart';

import 'base_view_model.dart';

class AccountScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Transporter _transporter;
  Transporter get transporter => _transporter;

  void loadTransporterInfo() {
    _databaseService
        .getUserInRealTime(_authenticationService.currentUser.get().uid)
        .listen((account) {
      _transporter = account;
      notifyListeners();
    });
  }

  void editTransporterAccount() {
    _navigationService.navigateTo(AccountEditingScreen.route,
        arguments: _transporter);
  }
}
