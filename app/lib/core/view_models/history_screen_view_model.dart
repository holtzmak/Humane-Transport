import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/widgets/utility/pdf_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This ViewModel will only view complete ATR models
class HistoryScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  StreamSubscription<List<AnimalTransportRecord>> previewSubscription;

  HistoryScreenViewModel() {
    previewSubscription =
        _databaseService.getUpdatedCompleteATRs().listen((atr) => addAll(atr));
  }

  @mustCallSuper
  void dispose() {
    previewSubscription.cancel();
    super.dispose();
  }

  final List<AnimalTransportRecord> _animalTransportRecords = [];

  List<AnimalTransportRecord> get animalTransportRecords =>
      List.unmodifiable(_animalTransportRecords);

  void addAll(List<AnimalTransportRecord> animalTransportPreviews) {
    removeAll();
    _animalTransportRecords.addAll(animalTransportPreviews);
    notifyListeners();
  }

  void removeAll() {
    _animalTransportRecords.clear();
    notifyListeners();
  }

  void navigateToPDFScreen() {
    _navigationService.navigateTo(PDFScreen.route);
  }

  void navigateToHistoryScreen() {
    _navigationService.pop();
  }
}
