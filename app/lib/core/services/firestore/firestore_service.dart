import 'dart:async';
import 'package:app/core/models/test_history.dart';
import 'package:app/core/models/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _historyCollectionReference =
      FirebaseFirestore.instance.collection('history');
  final StreamController<List<HistoryRecord>> _historyController =
      StreamController<List<HistoryRecord>>.broadcast();

  Future addUserToFirestore(UserInformation user) async {
    try {
      await _userCollectionReference.doc(user.userId).set(user.toJson());
    } catch (e) {
      return e.code;
    }
  }

  Future fetchUser(String currentUserId) async {
    try {
      var userData = await _userCollectionReference.doc(currentUserId).get();
      return UserInformation.fromFirestore(userData.data());
    } catch (e) {
      return e.code;
    }
  }

  Future addHistory(HistoryRecord historyRecord) async {
    try {
      await _historyCollectionReference
          .doc(historyRecord.userId)
          .collection('history_data')
          .add(historyRecord.toJson());
    } catch (e) {
      return e.code;
    }
  }

  Stream getHistoryRecordsInRealTime(String currentUserId) {
    // Register the handler for when the posts data changes
    _historyCollectionReference
        .doc(currentUserId)
        .collection('history_data')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var history = snapshot.docs
            .map((snapshot) =>
                HistoryRecord.fromFirestore(snapshot.data(), snapshot.id))
            .toList();

        _historyController.add(history);
      } else {
        print('It is empty');
      }
    });

    return _historyController.stream;
  }

  Future updatHistoryTravel(HistoryRecord historyRecord) async {
    try {
      await _historyCollectionReference
          .doc(historyRecord.userId)
          .collection('history_data')
          .doc(historyRecord.documentId)
          .update(historyRecord.toJson());
    } catch (e) {
      print(e.code);
    }
  }

  Future deletePost(String documentId, String currentUserId) async {
    try {
      await _historyCollectionReference
          .doc(currentUserId)
          .collection('history_data')
          .doc(documentId)
          .delete();
    } catch (e) {
      print(e.code);
    }
  }
}
