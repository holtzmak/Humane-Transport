import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/test_animal_transport_record.dart';

class DatabaseService {
  // TODO: #130. Replace with actual DB functions
  Stream<AnimalTransportRecord> getUpdatedCompleteATRs() async* {
    await Future.delayed(Duration(seconds: 5));
    yield testAnimalTransportRecord();
  }

  Stream<AnimalTransportRecord> getUpdatedActiveATRs() async* {
    await Future.delayed(Duration(seconds: 5));
    yield testAnimalTransportRecord();
  }
}
