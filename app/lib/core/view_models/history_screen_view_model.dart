import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/widgets/atr_display.dart';
import 'package:app/ui/widgets/atr_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This ViewModel will only view complete ATR models
class HistoryScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  StreamSubscription<AnimalTransportRecord> previewSubscription;

  HistoryScreenViewModel() {
    previewSubscription = _databaseService
        .getUpdatedCompleteATRs()
        .listen((atr) => addAll([createPreview(atr)]));
  }

  @mustCallSuper
  void dispose() {
    previewSubscription.cancel();
    super.dispose();
  }

  final List<ATRPreview> _animalTransportPreviews = [];

  List<ATRPreview> get animalTransportPreviews =>
      List.unmodifiable(_animalTransportPreviews);

  ATRPreview createPreview(AnimalTransportRecord atr) => ATRPreview(
      atr: atr,
      onTap: () =>
          _navigationService.navigateTo(ATRDisplay.route, arguments: atr));

  void addAll(List<ATRPreview> animalTransportPreviews) {
    _animalTransportPreviews.addAll(animalTransportPreviews);
    notifyListeners();
  }

  void removeAll() {
    _animalTransportPreviews.clear();
    notifyListeners();
  }
}
