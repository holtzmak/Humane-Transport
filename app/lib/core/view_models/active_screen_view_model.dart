import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/active/atr_editing_screen.dart';
import 'package:app/ui/widgets/atr_preview_card.dart';
import 'package:flutter/cupertino.dart';

/// This ViewModel will only view active ATR models
class ActiveScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  StreamSubscription<List<AnimalTransportRecord>> previewSubscription;

  ActiveScreenViewModel() {
    previewSubscription = _databaseService.getUpdatedActiveATRs().listen(
        (atr) => addAll(atr.map((element) => createPreview(element)).toList()));
  }

  @mustCallSuper
  void dispose() {
    previewSubscription.cancel();
    super.dispose();
  }

  final List<ATRPreviewCard> _animalTransportPreviews = [];

  List<ATRPreviewCard> get animalTransportPreviews =>
      List.unmodifiable(_animalTransportPreviews);

  ATRPreviewCard createPreview(AnimalTransportRecord atr) => ATRPreviewCard(
      atr: atr,
      onTap: () => _navigationService.navigateTo(ATREditingScreen.route,
          arguments: atr));

  void addAll(List<ATRPreviewCard> animalTransportPreviews) {
    _animalTransportPreviews.addAll(animalTransportPreviews);
    notifyListeners();
  }

  void removeAll() {
    _animalTransportPreviews.clear();
    notifyListeners();
  }

  void navigateToActiveScreen() {
    _navigationService.pop();
  }

  Future<void> startNewAtr() async => _databaseService
      .saveNewAtr(_authenticationService.currentUser.get().uid)
      .catchError((e) => _dialogService.showDialog(
            title: 'Submission failed',
            description: e.message,
          ));

  Future<void> saveEditedAtr(AnimalTransportRecord atr) async =>
      _databaseService
          .updateWholeAtr(atr)
          .catchError((e) => _dialogService.showDialog(
                title: 'Submission failed',
                description: e.message,
              ));

  Future<void> saveCompletedAtr(AnimalTransportRecord atr) async =>
      saveEditedAtr(atr).then((_) => _databaseService
          .updateAtr(atr.identifier)
          .catchError((e) => _dialogService.showDialog(
                title: 'Submission failed',
                description: e.message,
              )));
}
