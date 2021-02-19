import 'dart:async';
import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/firestore_user.dart';
import 'package:app/core/services/database/database_interface.dart';
import 'package:app/test/test_animal_transport_record.dart';

class DatabaseService {
  final DatabaseInterface interface;
  DatabaseService(this.interface);

  Future<FirestoreUser> getUser(String userId) async =>
      interface.getUser(userId);

  Future<void> newUser(FirestoreUser newUser) async =>
      interface.newUser(newUser);

  Stream<AnimalTransportRecord> getUpdatedCompleteATRs() async* {
    await Future.delayed(Duration(seconds: 5));
    yield testAnimalTransportRecord();
  }

  Stream<AnimalTransportRecord> getUpdatedActiveATRs() async* {
    await Future.delayed(Duration(seconds: 5));
    yield testAnimalTransportRecord();
  }
}
