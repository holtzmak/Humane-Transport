import 'package:app/core/models/transporter.dart';
import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:flutter/material.dart';

class AccountEditViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Transporter _account;

  Future<void> saveTransporterAccount({
    @required String firstName,
    @required String lastName,
    @required String userEmailAddress,
    @required String userPhoneNumber,
  }) async {
    setState(ViewState.Busy);
    var updateTransporterAccount = Transporter(
      firstName: firstName,
      isAdmin: _account.isAdmin,
      lastName: lastName,
      userEmailAddress: userEmailAddress,
      userId: _account.userId,
      userPhoneNumber: userPhoneNumber,
    );
    _databaseService.addTransporter(updateTransporterAccount).then((_) =>
        _dialogService
            .showDialog(
                title: 'Transporter Account',
                description: 'Changes has been saved')
            .then((_) => setState(ViewState.Idle))
            .then((_) => _navigationService.pop())
            .catchError((e) {
          setState(ViewState.Idle);
          _dialogService.showDialog(
            title: 'Submission of the Animal Transport Record failed',
            description: e.message,
          );
        }));
  }

  void setTransporterAccount(Transporter account) {
    _account = account;
    notifyListeners();
  }

  void navigateToAccount() => _navigationService.pop();
}
