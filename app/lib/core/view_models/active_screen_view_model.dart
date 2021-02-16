import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/widgets/atr_preview_card.dart';
import 'package:flutter/cupertino.dart';

/// This ViewModel will only view active ATR models
class ActiveScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  StreamSubscription<AnimalTransportRecord> previewSubscription;

  ActiveScreenViewModel() {
    previewSubscription = _databaseService
        .getUpdatedActiveATRs()
        .listen((atr) => addAll([createPreview(atr)]));
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
      onTap: () {
        // TODO: #134. Link the editing screen
      });

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
}
