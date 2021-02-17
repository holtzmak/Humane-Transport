import 'dart:async';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mysql1/mysql1.dart';

import 'database_interface.dart';

// TODO: #130. Replace MySQL and SQLFLite with Firebase Database calls.
// We also probably need a separate service for FireBaseAuthentication
// Up to you if these are in the same file
class FirebaseDatabaseInterface extends DatabaseInterface {
  var networkStatus;
  MySqlConnection dbConnect;

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

  newUser(User newUser) async {
    var res;
    networkStatus = await checkConnectivity();

    if (networkStatus == true) {
      dbConnect = await connectRemote();
      res = await dbConnect.query('''DATABASE QUERY''');
      dbConnect.close();
      return res;
    } else
      print("Cannot Register(Connection Error)");
  }

  Future<Results> getUser(User getUser) async {
    dbConnect = await connectRemote();
    var userQuery = await dbConnect.query('''DATABASE QUERY''');
    dbConnect.close();
    return userQuery;
  }

  Future<dynamic> updatePassword(User user) async {
    dbConnect = await connectRemote();
    var updatePwd = await dbConnect.query('''DATABASE QUERY''');
    dbConnect.close();
    return updatePwd;
  }

  Future<dynamic> newRecord(AnimalTransportRecord newRecord) async {
    dbConnect = await connectRemote();
    await dbConnect.query('''
        INSERT INTO TransporterInfo(companyName, trainingType, companyAddress, addressLastCleanedAt, dateLastCleaned,
        driversAreBriefed, driversHaveTraining, trailerLicensePlate, trailerProvince, trainingExpiryDate, vehicleLicensePlate,
        vehicleProvince) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)''', [
      newRecord.tranInfo.companyName,
      newRecord.tranInfo.trainingType,
      newRecord.tranInfo.companyAddress,
      newRecord.tranInfo.addressLastCleanedAt,
      newRecord.tranInfo.dateLastCleaned,
      newRecord.tranInfo.driversAreBriefed,
      newRecord.tranInfo.driversHaveTraining,
      newRecord.tranInfo.trailerLicensePlate,
      newRecord.tranInfo.trailerProvince,
      newRecord.tranInfo.trainingExpiryDate,
      newRecord.tranInfo.vehicleLicensePlate,
      newRecord.tranInfo.vehicleProvince
    ]);

    await dbConnect.query('''
        INSERT INTO ShipInfo(departureAddress, LocationId, LocationName, ContactInfo, shipperIsOwner, shipperName) VALUES
        (?,?,?,?,?,?)''', [
      newRecord.shipInfo.departureAddress,
      newRecord.shipInfo.departureLocationId,
      newRecord.shipInfo.departureLocationName,
      newRecord.shipInfo.shipperContactInfo,
      newRecord.shipInfo.shipperIsAnimalOwner,
      newRecord.shipInfo.shipperName
    ]);

    await dbConnect.query(
        '''
        INSERT INTO ContingencyPlan(communicationPlan, expectedPrepProcess, goalStatement, standardMonitoring) VALUES (?,?,?,?)''',
        [
          newRecord.contingencyInfo.communicationPlan,
          newRecord.contingencyInfo.expectedPrepProcess,
          newRecord.contingencyInfo.goalStatement,
          newRecord.contingencyInfo.standardAnimalMonitoring,
          newRecord.contingencyInfo.potentialSafetyActions(),
          newRecord.contingencyInfo.contingencyEvents(),
          newRecord.contingencyInfo.crisisContacts(),
          newRecord.contingencyInfo.potentialHazards()
        ]);

    await dbConnect.query('''
        INSERT INTO VehicleInfo(animalsPerLoadingArea, DateLoaded, LoadingArea, LoadingDensity, TimeLoaded) VALUES
        (?,?,?,?,?)''', [
      newRecord.vehicleInfo.animalsPerLoadingArea,
      newRecord.vehicleInfo.dateAndTimeLoaded,
      newRecord.vehicleInfo.loadingArea,
      newRecord.vehicleInfo.loadingDensity
    ]);

    await dbConnect.query('''
        INSERT INTO FwrInfo(lastFwrDate, lastFwrLocation) VALUES (?,?)''',
        [newRecord.fwrInfo.lastFwrDate, newRecord.fwrInfo.lastFwrLocation]);

    await dbConnect.query('''
        INSERT INTO DeliveryInfo(departureAddress, LocationId, LocationName, ContactInfo, shipperIsOwner, shipperName) VALUES
        (?,?,?,?,?,?)''', [
      newRecord.deliveryInfo.additionalWelfareConcerns,
      newRecord.deliveryInfo.arrivalDateAndTime,
      newRecord.deliveryInfo.recInfo
    ]);

    await dbConnect.query('''
      INSERT INTO AckInfo(receiverAck, shipperAck, tranAck) VALUES (?,?,?)''', [
      newRecord.ackInfo.receiverAck,
      newRecord.ackInfo.shipperAck,
      newRecord.ackInfo.transporterAck
    ]);

    dbConnect.close();
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
