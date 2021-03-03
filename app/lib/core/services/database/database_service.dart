import 'dart:async';

import 'package:app/core/models/acknowledgement_info.dart';
import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/atr_identifier.dart';
import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/models/delivery_info.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/core/models/firestore_user.dart';
import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/core/models/transporter_info.dart';
import 'package:app/core/services/database/database_interface.dart';

class DatabaseService {
  final DatabaseInterface interface;

  DatabaseService(this.interface);

  Future<FirestoreUser> getUser(String userId) async =>
      interface.getUser(userId);

  Future<void> newUser(FirestoreUser newUser) async =>
      interface.setNewUser(newUser);

  Future<AnimalTransportRecord> saveNewAtr(String userId) async =>
      interface.setNewAtr(userId);

  Future<void> updateAtr(AtrIdentifier atr) async =>
      interface.updateAtrIdentifier(atr);

  Future<void> updateWholeAtr(AnimalTransportRecord atr) async =>
      interface.updateWholeAtr(atr);

  Future<void> setShipperInfo(String atrId, ShipperInfo shipperInfo) async =>
      interface.setShipperInfo(atrId, shipperInfo);

  Future<void> setTransporterInfo(
          String atrId, TransporterInfo transporterInfo) async =>
      interface.setTransporterInfo(atrId, transporterInfo);

  Future<void> setLoadingVehicleInfo(
          String atrId, LoadingVehicleInfo vehicleInfo) async =>
      interface.setLoadingVehicleInfo(atrId, vehicleInfo);

  Future<void> setFwrInfo(
          String atrId, FeedWaterRestInfo feedWaterRestInfo) async =>
      interface.setFwrInfo(atrId, feedWaterRestInfo);

  Future<void> setDeliveryInfo(String atrId, DeliveryInfo deliveryInfo) async =>
      interface.setDeliveryInfo(atrId, deliveryInfo);

  Future<void> setContingencyPlanInfo(
          String atrId, ContingencyPlanInfo contingencyPlanInfo) async =>
      interface.setContingencyPlanInfo(atrId, contingencyPlanInfo);

  Future<void> setAckInfo(
          String atrId, AcknowledgementInfo acknowledgementInfo) async =>
      interface.setAckInfo(atrId, acknowledgementInfo);

  Future<bool> removeAtr(String atrId) async =>
      interface.removeAtr(atrId).then((_) => true).catchError((_) => false);

  Future<List<AnimalTransportRecord>> getActiveRecords() async =>
      interface.getActiveRecords();

  Future<List<AnimalTransportRecord>> getCompleteRecords() async =>
      interface.getCompleteRecords();

  Stream<List<AnimalTransportRecord>> getUpdatedCompleteATRs() =>
      interface.getUpdatedCompleteATRs();

  Stream<List<AnimalTransportRecord>> getUpdatedActiveATRs() =>
      interface.getUpdatedActiveATRs();
}
