import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/history/atr_display_screen.dart';
import 'package:app/ui/widgets/atr_preview_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This ViewModel will only view complete ATR models
class HistoryScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  StreamSubscription<List<AnimalTransportRecord>> previewSubscription;

  HistoryScreenViewModel() {
    previewSubscription = _databaseService.getUpdatedCompleteATRs().listen(
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
      onTap: () => _navigationService.navigateTo(ATRDisplayScreen.route,
          arguments: atr));

  void addAll(List<ATRPreviewCard> animalTransportPreviews) {
    _animalTransportPreviews.addAll(animalTransportPreviews);
    notifyListeners();
  }

  void removeAll() {
    _animalTransportPreviews.clear();
    notifyListeners();
  }

  void navigateToHistoryScreen() {
    _navigationService.pop();
  }
}
