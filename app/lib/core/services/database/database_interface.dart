import 'package:app/core/models/animal_transport_record.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DatabaseInterface {
  // TODO: #130. The return types on these functions should not be dynamic
  // Make it explicit what each function returns, if anything

  // For example, newUser should return Future<void>, we only care if it was a success
  Future<dynamic> newUser(User newUser);

  // and getUser should return Future<User>, not dynamic
  Future<dynamic> getUser(User getUser);

  Future<dynamic> updatePassword(User user);

  Future<dynamic> newRecord(AnimalTransportRecord newRecord);

  Future<dynamic> getRecord(User user);

  Future<dynamic> updateTranInfo();

  Future<dynamic> updateShipperInfo();

  Future<dynamic> updateFwr();

  Future<dynamic> updateVehicleLoadingInfo();

  Future<dynamic> updateDeliveryInfo();

  Future<dynamic> updateAckInfo();

  Future<dynamic> updateContingencyInfo();
}
