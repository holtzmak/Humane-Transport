import 'dart:async';

import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/widgets/atr_preview.dart';
import 'package:flutter/cupertino.dart';

class AnimalTransportRecordPreViewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();
  StreamSubscription<AnimalTransportRecordPreview> previewSubscription;

  AnimalTransportRecordPreViewModel() {
    previewSubscription = _databaseService
        .getUpdatedPreviews()
        .listen((preview) => addAll([preview]));
  }

  @mustCallSuper
  void dispose() {
    previewSubscription.cancel();
    super.dispose();
  }

  final List<AnimalTransportRecordPreview> _animalTransportPreviews = [];

  List<AnimalTransportRecordPreview> get animalTransportPreviews =>
      List.unmodifiable(_animalTransportPreviews);

  void addAll(List<AnimalTransportRecordPreview> animalTransportPreviews) {
    _animalTransportPreviews.addAll(animalTransportPreviews);
    notifyListeners();
  }

  void removeAll() {
    _animalTransportPreviews.clear();
    notifyListeners();
  }
}
