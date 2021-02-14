import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/test_animal_transport_record.dart';
import 'package:app/ui/widgets/atr_display.dart';
import 'package:app/ui/widgets/atr_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  // TODO: #130. Replace with actual DB functions
  Stream<ATRPreview> getUpdatedCompleteATRs() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 5));
      yield ATRPreview(
        atr: testAnimalTransportRecord(),
        tapCallback: (BuildContext context, AnimalTransportRecord atr) =>
            Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) => ATRDisplay(atr: atr))),
      );
    }
  }

  Stream<ATRPreview> getUpdatedActiveATRs() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 5));
      yield ATRPreview(
          atr: testAnimalTransportRecord(),
          tapCallback: (context, atr) {
            // TODO: #134. Link the editing screen
          });
    }
  }
}
