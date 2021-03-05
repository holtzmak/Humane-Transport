import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:flutter/cupertino.dart';

/// This ViewModel will only view active ATR models
class ActiveScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final List<AnimalTransportRecord> _animalTransportRecords = [];
  StreamSubscription<List<AnimalTransportRecord>> previewSubscription;

  List<AnimalTransportRecord> get animalTransportRecords =>
      List.unmodifiable(_animalTransportRecords);

  ActiveScreenViewModel() {
    _authenticationService.currentUserChanges().listen((user) =>
        user.isPresent()
            ? previewSubscription = _databaseService
                .getUpdatedActiveATRs(user.get().uid)
                .listen((atrs) {
                removeAll();
                addAll(atrs);
              })
            : _cancelSubscription());
  }

  void _cancelSubscription() {
    removeAll();
    previewSubscription.cancel();
  }

  @mustCallSuper
  void dispose() {
    _cancelSubscription();
    super.dispose();
  }

  void addAll(List<AnimalTransportRecord> atrs) {
    _animalTransportRecords.addAll(atrs);
    notifyListeners();
  }

  void removeAll() {
    _animalTransportRecords.clear();
    notifyListeners();
  }

  void navigateToActiveScreen() {
    _navigationService.pop();
  }

  Future<void> saveEditedAtr(AnimalTransportRecord atr) async {
    setState(ViewState.Busy);
    return _databaseService
        .saveUpdatedAtr(atr)
        .then((_) => setState(ViewState.Idle))
        .catchError((e) {
      setState(ViewState.Idle);
      _dialogService.showDialog(
        title: 'Saving the Animal Transport Record failed',
        description: e.message,
      );
    });
  }

  Future<void> saveCompletedAtr(AnimalTransportRecord atr) async {
    setState(ViewState.Busy);
    saveEditedAtr(atr.asComplete())
        .then((_) => setState(ViewState.Idle))
        .catchError((e) {
      setState(ViewState.Idle);
      _dialogService.showDialog(
        title: 'Submission of the Animal Transport Record failed',
        description: e.message,
      );
    });
  }
}
