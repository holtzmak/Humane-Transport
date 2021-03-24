import 'dart:async';
import 'dart:io';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/transporter.dart';
import 'package:app/core/services/database/database_interface.dart';

class DatabaseService {
  final DatabaseInterface interface;

  DatabaseService(this.interface);

  Future<Transporter> getTransporter(String userId) async =>
      interface.getTransporter(userId);

  Future<void> addTransporter(Transporter newUser) async =>
      interface.setNewTransporter(newUser);

  Future<void> updateTransporter(Transporter transporter) =>
      interface.updateTransporter(transporter);

  Future<void> removeTransporter(String userId) async =>
      interface.removeTransporter(userId);

  Stream<Transporter> getUpdatedTransporter(String userId) =>
      interface.getUpdatedTransporter(userId);

  Future<AnimalTransportRecord> saveNewAtr(AnimalTransportRecord atr) async =>
      interface.setNewAtr(atr);

  Future<void> saveUpdatedAtr(AnimalTransportRecord atr) async =>
      interface.updateAtr(atr);

  Future<void> removeAtr(String atrId) async => interface.removeAtr(atrId);

  Future<List<AnimalTransportRecord>> getActiveRecords(String userId) async =>
      interface.getActiveRecords(userId);

  Future<List<AnimalTransportRecord>> getCompleteRecords(String userId) async =>
      interface.getCompleteRecords(userId);

  Stream<List<AnimalTransportRecord>> getUpdatedCompleteATRs(String userId) =>
      interface.getUpdatedCompleteATRs(userId);

  Stream<List<AnimalTransportRecord>> getUpdatedActiveATRs(String userId) =>
      interface.getUpdatedActiveATRs(userId);

  Future<String> uploadAvatarImage(File file, String fileName) async =>
      interface.uploadAvatarImage(file, fileName);

  Future<String> uploadAtrImage(File file, String fileName) async =>
      interface.uploadAtrImage(file, fileName);

  // Use to check before upload if the image already exists, use it's URL
  Future<String> getAtrImage(String fileName) async =>
      interface.getAtrImage(fileName);
}
