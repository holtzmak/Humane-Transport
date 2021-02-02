
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:mysql1/mysql1.dart';
import 'package:app/core/models/user.dart';
import 'package:app/core/models/animal_transport_record.dart';

class DatabaseServices {
  var networkStatus;
  MySqlConnection dbConnect;

  Future<bool> checkConnectivity() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }
    else
      return false;
  }

  Future<MySqlConnection> connectRemote() async{
    final remoteConnect = await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost', port: 0000,user: 'root', db: 'remote_database',
          password: "capstone"
      ));
    return remoteConnect;
    }

  newUser(User newUser) async {
    var res;
    networkStatus = await checkConnectivity();

    if(networkStatus == true){
      dbConnect = await connectRemote();
      res = await dbConnect.query(
          '''
        INSERT INTO transporters(username, password) VALUES (?,?)
        ''',[newUser.username, newUser.password]
      );
      dbConnect.close();
      return res;
    }else
      print("Cannot Register(Connection Error)");
  }

  Future<dynamic> getUser(User getUser) async{
    dbConnect =  await connectRemote();
    var userQuery = await dbConnect.query(
        '''
        SELECT username, password, userID FROM transporters where username = ? AND password = ?
        ''', [getUser.username, getUser.password]
    );
    dbConnect.close();
    return userQuery;
  }

  newForm(AnimalTransportRecord newRecord, String withInfo) async{
    dbConnect = await connectRemote();
    await dbConnect.query(
        '''
        INSERT INTO TransporterInfo(companyName, trainingType, companyAddress, addressLastCleanedAt, dateLastCleaned,
        driversAreBriefed, driversHaveTraining, trailerLicensePlate, trailerProvince, trainingExpiryDate, vehicleLicensePlate,
        vehicleProvince) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)''', [newRecord.tranInfo.companyName,newRecord.tranInfo.trainingType
        ,newRecord.tranInfo.companyAddress,newRecord.tranInfo.addressLastCleanedAt,newRecord.tranInfo.dateLastCleaned,
        newRecord.tranInfo.driversAreBriefed,newRecord.tranInfo.driversHaveTraining,newRecord.tranInfo.trailerLicensePlate,
        newRecord.tranInfo.trailerProvince,newRecord.tranInfo.trainingExpiryDate,newRecord.tranInfo.vehicleLicensePlate,
        newRecord.tranInfo.vehicleProvince]);

    await dbConnect.query(
        '''
        INSERT INTO ShipInfo(departureAddress, LocationId, LocationName, ContactInfo, shipperIsOwner, shipperName) VALUES
        (?,?,?,?,?,?)''', [newRecord.shipInfo.departureAddress,newRecord.shipInfo.departureLocationId,
        newRecord.shipInfo.departureLocationName, newRecord.shipInfo.shipperContactInfo,newRecord.shipInfo.shipperIsAnimalOwner, newRecord.shipInfo.shipperName]
    );

    await dbConnect.query(
        '''
        INSERT INTO ContingencyPlan(communicationPlan, expectedPrepProcess, goalStatement, standardMonitoring) VALUES (?,?,?,?)''',
        [newRecord.contingencyInfo.communicationPlan, newRecord.contingencyInfo.expectedPrepProcess, newRecord.contingencyInfo.goalStatement,
        newRecord.contingencyInfo.standardAnimalMonitoring, newRecord.contingencyInfo.potentialSafetyActions(),newRecord.contingencyInfo.contingencyEvents(),
        newRecord.contingencyInfo.crisisContacts(), newRecord.contingencyInfo.potentialHazards()]
    );

    await dbConnect.query(
        '''
        INSERT INTO VehicleInfo(animalsPerLoadingArea, DateLoaded, LoadingArea, LoadingDensity, TimeLoaded) VALUES
        (?,?,?,?,?)''', [newRecord.vehicleInfo.animalsPerLoadingArea, newRecord.vehicleInfo.dateAndTimeLoaded,
        newRecord.vehicleInfo.loadingArea, newRecord.vehicleInfo.loadingDensity]
    );

    await dbConnect.query(
        '''
        INSERT INTO FwrInfo(lastFwrDate, lastFwrLocation) VALUES (?,?)''', [newRecord.fwrInfo.lastFwrDate, newRecord.fwrInfo.lastFwrLocation]);

    await dbConnect.query(
        '''
        INSERT INTO DeliveryInfo(departureAddress, LocationId, LocationName, ContactInfo, shipperIsOwner, shipperName) VALUES
        (?,?,?,?,?,?)''', [newRecord.deliveryInfo.additionalWelfareConcerns, newRecord.deliveryInfo.arrivalDateAndTime,
        newRecord.deliveryInfo.recInfo]
    );

    await dbConnect.query(
      '''
      INSERT INTO AckInfo(receiverAck, shipperAck, tranAck) VALUES (?,?,?)''',
      [newRecord.ackInfo.receiverAck, newRecord.ackInfo.shipperAck, newRecord.ackInfo.transporterAck]
    );

    dbConnect.close();
  }

  Future<dynamic> getRecentFormsList(User user) async{
    dbConnect  = await connectRemote();
    var formList = await dbConnect.query(
      '''
      SELECT FormId, DateCreated FROM AtrRecord WHERE userName = ?
      ''', [user.username]
    );
    dbConnect.close();
    return formList;
  }

  Future<dynamic> getTransporterRecord(String formId) async{
    dbConnect = await connectRemote();
    var transporterInfo = await dbConnect.query(
      '''
      SELECT * FROM TransporterInfo WHERE formId = ?
      ''', [formId]
    );
    dbConnect.close();
    return transporterInfo;
  }

  Future<dynamic> getShipperInfo(String formId) async{
    dbConnect = await connectRemote();
    var shipInfo = await dbConnect.query(
      '''SELECT * FROM ShipInfo WHERE formId = ?
      ''', [formId]
    );
    dbConnect.close();
    return shipInfo;
  }

  Future<dynamic> getReceiverInfo(String formId) async{
    dbConnect = await connectRemote();
    var receiverInfo = await dbConnect.query(
      '''
      SELECT * FROM FwrInfo WHERE formId = ?
      ''', [formId]
    );
    dbConnect.close();
    return receiverInfo;
  }

  Future<dynamic> getVehicleInfo(String formId)async{
    dbConnect = await connectRemote();
    var vehicleInfo = await dbConnect.query(
      '''
      SELECT * FROM VehicleInfo WHERE formId = ?
      ''', [formId]
    );
    dbConnect.close();
    return vehicleInfo;
  }

  Future<dynamic> getFwrInfo(String formId) async{
    dbConnect = await connectRemote();
    var fwrInfo = await dbConnect.query(
      '''
      SELECT * FROM FwrInfo WHERE formID = ?
      ''', [formId]
    );
    dbConnect.close();
    return fwrInfo;
  }

  Future<dynamic> getContingency(String formId)async{
    dbConnect = await connectRemote();
    var contingency = await dbConnect.query(
      '''SELECT * FROM ContingencyPlan WHERE formId = ?'''
      , [formId]
    );
    dbConnect.close();
    return contingency;
  }

  Future<dynamic> getDeliveryInfo(String formId)async{
    dbConnect = await connectRemote();
    var deliveryInfo = await dbConnect.query(
      '''SELECT * FROM DeliveryInfo WHERE formID = ?''', [formId]
    );
    dbConnect.close();
    return deliveryInfo;
  }

  Future<dynamic> getAckInfo(String formId)async{
    dbConnect = await connectRemote();
    var ackInfo = await dbConnect.query(
      '''SELECT * FROM AckInfo WHERE formId = ? ''', [formId]
    );
    dbConnect.close();
    return ackInfo;
  }
}