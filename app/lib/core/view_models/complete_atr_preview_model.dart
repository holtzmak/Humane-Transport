import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/widgets/atr_display.dart';
import 'package:app/ui/widgets/atr_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This ViewModel will only view complete ATR models
class CompleteATRPreviewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();
  StreamSubscription<AnimalTransportRecord> previewSubscription;

  CompleteATRPreviewModel() {
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
        tapCallback: (BuildContext context, AnimalTransportRecord atr) =>
            // Need to specify root navigator as we are building outside of a
            // widget that is known to navigator
            // TODO: Replace with NavigatorService
            Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) => ATRDisplay(atr: atr))),
      );

  void addAll(List<ATRPreview> animalTransportPreviews) {
    _animalTransportPreviews.addAll(animalTransportPreviews);
    notifyListeners();
  }

  void removeAll() {
    _animalTransportPreviews.clear();
    notifyListeners();
  }
}
