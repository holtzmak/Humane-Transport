import 'dart:async';
import 'dart:io';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/transporter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'database_interface.dart';

/// The interface for FirebaseFirestore
/// All Future calls contain a timeout as per https://stackoverflow.com/a/53551036
/// (We could go without futures as suggested, but that seems antipattern
/// because we would like to be notified of permission errors and the like)
class FirebaseDatabaseInterface implements DatabaseInterface {
  final FirebaseFirestore _firestore;

  FirebaseDatabaseInterface(this._firestore);

  @override
  Future<void> setNewTransporter(Transporter newTransporter) async => _firestore
      .collection('transporter')
      .doc(newTransporter.userId)
      .set(newTransporter.toJSON())
      .timeout(Duration(seconds: 10),
          onTimeout: () => Future.error(PlatformException(
              message: "The connection timed out!", code: "FUTURE_TIMEOUT")));

  @override
  Future<Transporter> getTransporter(String userId) async => _firestore
      .collection('transporter')
      .doc(userId)
      .get()
      .then(
          (DocumentSnapshot snapshot) => Transporter.fromJSON(snapshot.data()))
      .timeout(Duration(seconds: 10),
          onTimeout: () => Future.error(PlatformException(
              message: "The connection timed out!", code: "FUTURE_TIMEOUT")));

  @override
  Future<void> updateTransporter(Transporter transporter) => _firestore
      .collection('transporter')
      .doc(transporter.userId)
      .update(transporter.toJSON())
      .timeout(Duration(seconds: 10),
          onTimeout: () => Future.error(PlatformException(
              message: "The connection timed out!", code: "FUTURE_TIMEOUT")));

  @override
  Future<void> removeTransporter(String userId) async =>
      _firestore.collection('transporter').doc(userId).delete();

  @override
  Stream<Transporter> getUpdatedTransporter(String userId) =>
      _firestore.collection('transporter').doc(userId).snapshots().map(
          (DocumentSnapshot snapshot) => Transporter.fromJSON(snapshot.data()));

  @override
  Future<AnimalTransportRecord> setNewAtr(AnimalTransportRecord atr) async {
    return _firestore
        .collection('atr')
        .add(atr.toJSON())
        .then((docRef) => atr.withDocId(docRef.id))
        .timeout(Duration(seconds: 10),
            onTimeout: () => Future.error(PlatformException(
                message: "The connection timed out!", code: "FUTURE_TIMEOUT")));
  }

  @override
  Future<void> updateAtr(AnimalTransportRecord atr) async => _firestore
      .collection('atr')
      .doc(atr.identifier.atrDocumentId)
      .update(atr.toJSON())
      .timeout(Duration(seconds: 10),
          onTimeout: () => Future.error(PlatformException(
              message: "The connection timed out!", code: "FUTURE_TIMEOUT")));

  @override
  Future<void> removeAtr(String atrDocumentId) async => _firestore
      .collection('atr')
      .doc(atrDocumentId)
      .delete()
      .timeout(Duration(seconds: 10),
          onTimeout: () => Future.error(PlatformException(
              message: "The connection timed out!", code: "FUTURE_TIMEOUT")));

  @override
  Future<List<AnimalTransportRecord>> getCompleteRecords(String userId) async =>
      _firestore
          .collection('atr')
          .where('identifier.userId', isEqualTo: userId)
          .where('identifier.isComplete', isEqualTo: true)
          .get()
          .then((snapshot) => snapshot.docs
              .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
              .toList())
          .timeout(Duration(seconds: 10),
              onTimeout: () => Future.error(PlatformException(
                  message: "The connection timed out!",
                  code: "FUTURE_TIMEOUT")));

  @override
  Future<List<AnimalTransportRecord>> getActiveRecords(String userId) async =>
      _firestore
          .collection('atr')
          .where('identifier.userId', isEqualTo: userId)
          .where('identifier.isComplete', isEqualTo: false)
          .get()
          .then((snapshot) => snapshot.docs
              .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
              .toList())
          .timeout(Duration(seconds: 10),
              onTimeout: () => Future.error(PlatformException(
                  message: "The connection timed out!",
                  code: "FUTURE_TIMEOUT")));

  @override
  Stream<List<AnimalTransportRecord>> getUpdatedCompleteATRs(String userId) =>
      _firestore
          .collection('atr')
          .where('identifier.userId', isEqualTo: userId)
          .where('identifier.isComplete', isEqualTo: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
              .toList());

  @override
  Stream<List<AnimalTransportRecord>> getAllUpdatedCompleteATRs() => _firestore
      .collection('atr')
      .where('identifier.isComplete', isEqualTo: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
          .toList());

  @override
  Stream<List<AnimalTransportRecord>> getUpdatedActiveATRs(String userId) =>
      _firestore
          .collection('atr')
          .where('identifier.userId', isEqualTo: userId)
          .where('identifier.isComplete', isEqualTo: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AnimalTransportRecord.fromJSON(doc.data(), doc.id))
              .toList());

  @override
  Future<String> uploadAtrImage(File file, String fileName) async =>
      FirebaseStorage.instance
          .ref()
          .child('atrImages/$fileName')
          .putFile(file)
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL())
          .timeout(Duration(seconds: 10),
              onTimeout: () => Future.error(PlatformException(
                  message: "The connection timed out!",
                  code: "FUTURE_TIMEOUT")));

  @override
  Future<String> uploadAvatarImage(File file, String fileName) async =>
      FirebaseStorage.instance
          .ref()
          .child('avatarImages/$fileName')
          .putFile(file)
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL())
          .timeout(Duration(seconds: 10),
              onTimeout: () => Future.error(PlatformException(
                  message: "The connection timed out!",
                  code: "FUTURE_TIMEOUT")));

  @override
  Future<String> getAtrImage(String fileName) async => FirebaseStorage.instance
      .ref()
      .child('atrImages/$fileName')
      .getDownloadURL()
      .timeout(Duration(seconds: 10),
          onTimeout: () => Future.error(PlatformException(
              message: "The connection timed out!", code: "FUTURE_TIMEOUT")));
}
