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
import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_interface.dart';

class FirebaseDatabaseInterface implements DatabaseInterface {
  final FirebaseFirestore _firestore;

  FirebaseDatabaseInterface(this._firestore);

  @override
  Future<FirestoreUser> getUser(String userId) async => _firestore
      .collection('users')
      .doc(userId)
      .get()
      .then((DocumentSnapshot snapshot) =>
          FirestoreUser.fromJSON(snapshot.data()));

  @override
  Future<void> setNewUser(FirestoreUser newUser) async =>
      _firestore.collection('users').doc(newUser.userId).set(newUser.toJSON());

  @override
  Future<List<AnimalTransportRecord>> getCompleteRecords() async => _firestore
      .collection('atr')
      .where('isComplete', isEqualTo: true)
      .get()
      .then((snapshot) => snapshot.docs
          .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
          .toList());

  @override
  Future<List<AnimalTransportRecord>> getActiveRecords() async => _firestore
      .collection('atr')
      .where('isComplete', isEqualTo: false)
      .get()
      .then((snapshot) => snapshot.docs
          .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
          .toList());

  /// This returns the whole list of records in the database, not just updated ones
  @override
  Stream<List<AnimalTransportRecord>> getUpdatedCompleteATRs() => _firestore
      .collection('atr')
      .where('isComplete', isEqualTo: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
          .toList());

  /// This returns the whole list of records in the database, not just updated ones
  @override
  Stream<List<AnimalTransportRecord>> getUpdatedActiveATRs() => _firestore
      .collection('atr')
      .where('isComplete', isEqualTo: false)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
          .toList());

  @override
  Future<void> setShipperInfo(String atrId, ShipperInfo shipperInfo) async =>
      _firestore
          .collection('atr')
          .doc(atrId)
          .set(shipperInfo.toJSON(), SetOptions(merge: true));

  @override
  Future<void> setTransporterInfo(
          String atrId, TransporterInfo transporterInfo) async =>
      _firestore
          .collection('atr')
          .doc(atrId)
          .set(transporterInfo.toJSON(), SetOptions(merge: true));

  @override
  Future<AtrIdentifier> setNewAtr(String userId, bool isComplete) async {
    final Map<String, dynamic> placeholderJSON = {
      'userId': userId,
      'isComplete': isComplete,
    };
    return _firestore.collection('atr').add(placeholderJSON).then((docRef) =>
        AtrIdentifier(
            userId: userId, atrDocumentId: docRef.id, isComplete: isComplete));
  }

  @override
  Future<void> setAckInfo(
          String atrId, AcknowledgementInfo acknowledgementInfo) async =>
      _firestore
          .collection('atr')
          .doc(atrId)
          .set(acknowledgementInfo.toJSON(), SetOptions(merge: true));

  @override
  Future<void> setContingencyPlanInfo(
          String atrId, ContingencyPlanInfo contingencyPlanInfo) async =>
      _firestore
          .collection('atr')
          .doc(atrId)
          .set(contingencyPlanInfo.toJSON(), SetOptions(merge: true));

  @override
  Future<void> setDeliveryInfo(String atrId, DeliveryInfo deliveryInfo) async =>
      _firestore
          .collection('atr')
          .doc(atrId)
          .set(deliveryInfo.toJSON(), SetOptions(merge: true));

  @override
  Future<void> setFwrInfo(
          String atrId, FeedWaterRestInfo feedWaterRestInfo) async =>
      _firestore
          .collection('atr')
          .doc(atrId)
          .set(feedWaterRestInfo.toJSON(), SetOptions(merge: true));

  @override
  Future<void> setLoadingVehicleInfo(
          String atrId, LoadingVehicleInfo vehicleInfo) async =>
      _firestore
          .collection('atr')
          .doc(atrId)
          .set(vehicleInfo.toJSON(), SetOptions(merge: true));

  @override
  Future<void> updateAtrIdentifier(AtrIdentifier atr) async =>
      _firestore.collection('atr').doc(atr.atrDocumentId).update(atr.toJSON());

  @override
  Future<void> removeAtr(String atrId) async =>
      _firestore.collection('atr').doc(atrId).delete();

  @override
  Future<void> updateWholeAtr(AnimalTransportRecord atr) async => _firestore
      .collection('atr')
      .doc(atr.identifier.atrDocumentId)
      .update(atr.toJSON());
}
