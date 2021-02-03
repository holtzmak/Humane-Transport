import 'dart:async';

import 'package:app/core/models/test_animal_transport_record.dart';
import 'package:app/ui/widgets/atr_preview.dart';

class DatabaseService {
  // TODO: #130. Replace with actual DB functions
  Stream<AnimalTransportRecordPreview> getUpdatedPreviews() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 5));
      yield AnimalTransportRecordPreview(atr: testAnimalTransportRecord());
    }
  }
}
