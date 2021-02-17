import 'package:app/core/models/user.dart';
import 'package:app/core/models/animal_transport_record.dart';
import 'package:mysql1/mysql1.dart';

abstract class DatabaseInterface {
  Future<dynamic> newUser(User newUser);

  Future<Results> getUser(User getUser);

  Future<dynamic> updatePassword(User user);

  Future newRecord(AnimalTransportRecord newRecord);

  Future<Results> getRecord(User user);

  Future<dynamic> updateTranInfo();

  Future<dynamic> updateShipperInfo();

  Future<dynamic> updateFwr();

  Future<dynamic> updateVehicleLoadingInfo();

  Future<dynamic> updateDeliveryInfo();

  Future<dynamic> updateAckInfo();

  Future<dynamic> updateContingencyInfo();

}