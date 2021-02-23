import 'dart:async';
import 'package:app/core/models/acknowledgement_info.dart';
import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/models/delivery_info.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/core/models/firestore_user.dart';
import 'package:app/core/models/initial_atr.dart';
import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/core/models/transporter_info.dart';
import 'package:app/core/services/database/database_interface.dart';
import 'package:app/test/test_animal_transport_record.dart';

class DatabaseService {
  final DatabaseInterface interface;
  DatabaseService(this.interface);

  Future<FirestoreUser> getUser(String userId) async =>
      interface.getUser(userId);

  Future<void> newUser(FirestoreUser newUser) async =>
      interface.newUser(newUser);

  // Note: If used in ViewModel, do not pass atrId to InitialAtr
  Future<void> saveNewAtr(InitialAtr atr) async => interface.saveNewAtr(atr);

  // Note: If used in ViewModel, pass an atrId to InitialAtr
  Future<void> updateAtr(InitialAtr atr) async => interface.updateAtr(atr);

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

  // TODO: #130. Replace these functions with the Firestore provider pattern equivalent
  // Meaning, this function may stay but it needs the "real" implementation
  // where we listen to Firestore for changes and get them
  Stream<AnimalTransportRecord> getUpdatedCompleteATRs() async* {
    await Future.delayed(Duration(seconds: 5));
    yield testAnimalTransportRecord();
  }

  Stream<AnimalTransportRecord> getUpdatedActiveATRs() async* {
    await Future.delayed(Duration(seconds: 5));
    yield testAnimalTransportRecord();
  }
}
