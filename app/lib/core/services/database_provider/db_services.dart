import 'dart:async';
import 'package:app/core/services/database_provider/database_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:mysql1/mysql1.dart';
import 'package:app/core/models/user.dart';
import 'package:app/core/models/animal_transport_record.dart';

class DatabaseServices extends DatabaseInterface {
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
      res = await dbConnect.query('''
        INSERT INTO transporters(username, password) VALUES (?,?)
        ''', [newUser.username, newUser.password]);
      dbConnect.close();
      return res;
    } else
      print("Cannot Register(Connection Error)");
  }

  Future<Results> getUser(User getUser) async {
    dbConnect = await connectRemote();
    var userQuery = await dbConnect.query('''
        SELECT username, password, userID FROM transporters where username = ? AND password = ?
        ''', [getUser.username, getUser.password]);
    dbConnect.close();
    return userQuery;
  }

  Future<dynamic> updatePassword(User user) async {
    dbConnect = await connectRemote();
    var updatePwd = await dbConnect.query('''
    UPDATE User SET password = ? WHERE username = ?''',
        [user.password, user.username]);
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
        INSERT INTO VehicleInfo(animalsPerLoadingArea, DateAndTtimeLoaded, LoadingArea, LoadingDensity) VALUES
        (?,?,?,?)''', [
      newRecord.vehicleInfo.animalsPerLoadingArea,
      newRecord.vehicleInfo.dateLoaded,
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
      newRecord.deliveryInfo.arrivalDate,
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
    var recentRecord = await dbConnect.query('''
    Select * FROM ATR WHERE ArrivalDate = (select max(ArrivalDate) from ATR where username = ?)''',
        [user.username]);
    dbConnect.close();
    return recentRecord;
  }

  Future<dynamic> retrieveUserRecords(User user) async {
    dbConnect = await connectRemote();
    var formList = await dbConnect.query('''
      SELECT FormId, DateCreated FROM ATR WHERE userName = ?
      ''', [user.username]);
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
