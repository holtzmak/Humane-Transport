import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/firestore_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DatabaseInterface {
  // TODO: #130. The return types on these functions should not be dynamic
  // Make it explicit what each function returns, if anything

  Future<void> newUser(FirestoreUser newUser);

  Future<FirestoreUser> getUser(String userId);

  Future<dynamic> newRecord(AnimalTransportRecord newRecord);

  Future<dynamic> getRecord(User user);

  // TODO: #130. Replace these individual methods with single functions like updateIncompleteATR(), addCompleteATR(), removeIncompleteATR(), and so on
  // We don't handle ATRs in pieces ATM
  Future<dynamic> updateTranInfo();
  // We might not need this
  Future<dynamic> updateShipperInfo();
  // We might not need this
  Future<dynamic> updateFwr();

  Future<dynamic> updateVehicleLoadingInfo();

  Future<dynamic> updateDeliveryInfo();

  Future<dynamic> updateAckInfo();

  Future<dynamic> updateContingencyInfo();
}
