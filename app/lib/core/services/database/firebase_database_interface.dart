import 'dart:async';
import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/firestore_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mysql1/mysql1.dart';

import 'database_interface.dart';

// TODO: #130. Replace MySQL and SQLFLite with Firebase Database calls.
// We also probably need a separate service for FireBaseAuthentication
// Up to you if these are in the same file
class FirebaseDatabaseInterface implements DatabaseInterface {
  final FirebaseFirestore _firestore;

  var networkStatus;
  MySqlConnection dbConnect;

  FirebaseDatabaseInterface(this._firestore);

  /*
    Explanation why 'set' is used instead of 'add' when new user is created in
    FirebaseAuth.
    https://stackoverflow.com/questions/60423700/flutter-creating-a-user-in-firestore-using-the-account-created-from-firebase-au
  */
  Future<void> newUser(FirestoreUser newUser) async =>
      _firestore.collection('users').doc(newUser.userId).set(newUser.toJSON());

  Future<FirestoreUser> getUser(String userId) async => _firestore
      .collection('users')
      .doc(userId)
      .get()
      .then((DocumentSnapshot snapshot) =>
          FirestoreUser.fromJSON(snapshot.data()));

  Future<void> newRecord(AnimalTransportRecord newRecord) async =>
      _firestore.collection('atr').add(newRecord.toJSON());

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    } else
      return false;
  }

  Future<MySqlConnection> connectRemote() async {
    final remoteConnect = await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost',
        port: 0000,
        user: 'root',
        db: 'remote_database',
        password: "capstone"));
    return remoteConnect;
  }

  Future<Results> getRecord(User user) async {
    dbConnect = await connectRemote();
    var recentRecord = await dbConnect.query('''DATABASE QUERY''');
    dbConnect.close();
    return recentRecord;
  }

  Future<dynamic> retrieveUserRecords(User user) async {
    dbConnect = await connectRemote();
    var formList = await dbConnect.query('''DATABASE QUERY''');
    dbConnect.close();
    return formList;
  }

  Future<dynamic> updateTranInfo() async {
    dbConnect = await connectRemote();
    var updateTransporter = await dbConnect.query('''DATABASE QUERY''');
    dbConnect.close();
    return updateTransporter;
  }

  Future<dynamic> updateShipperInfo() async {
    dbConnect = await connectRemote();
    var updateShipper = await dbConnect.query('''DATABASE QUERY''');
    dbConnect.close();
    return updateShipper;
  }

  Future<dynamic> updateFwr() async {
    dbConnect = await connectRemote();
    var updateFwr = await dbConnect.query('''DATABASE QUERY''');
    dbConnect.close();
    return updateFwr;
  }

  Future<dynamic> updateVehicleLoadingInfo() async {
    dbConnect = await connectRemote();
    var updateVehicle = await dbConnect.query('''DATABASE QUERY''');
    dbConnect.close();
    return updateVehicle;
  }

  Future<dynamic> updateDeliveryInfo() async {
    dbConnect = await connectRemote();
    var updateDelivery = await dbConnect.query('''DATABASE QUERY''');
    dbConnect.close();
    return updateDelivery;
  }

  Future<dynamic> updateAckInfo() async {
    dbConnect = await connectRemote();
    var updateAck = await dbConnect.query('''DATABASE QUERY''');
    dbConnect.close();
    return updateAck;
  }

  Future<dynamic> updateContingencyInfo() async {
    dbConnect = await connectRemote();
    var updateContingencyPlan = await dbConnect.query('''DATABASE QUERY''');
    dbConnect.close();
    return updateContingencyPlan;
  }
}
