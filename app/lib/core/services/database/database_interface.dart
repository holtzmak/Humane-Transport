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
import 'package:firebase_auth/firebase_auth.dart';

abstract class DatabaseInterface {
  // TODO: #130. The return types on these functions should not be dynamic
  // Make it explicit what each function returns, if anything

  Future<void> newUser(FirestoreUser newUser);

  Future<FirestoreUser> getUser(String userId);

  Future<void> saveNewAtr(AtrIdentifier atr);

  Future<void> updateAtr(AtrIdentifier atr);

  Future<void> updateWholeAtr(AnimalTransportRecord atr);

  Future<void> setShipperInfo(String atrId, ShipperInfo shipperInfo);

  Future<void> setTransporterInfo(
      String atrId, TransporterInfo transporterInfo);

  Future<void> setFwrInfo(String atrId, FeedWaterRestInfo feedWaterRestInfo);

  Future<void> setLoadingVehicleInfo(
      String atrId, LoadingVehicleInfo vehicleInfo);

  Future<void> setDeliveryInfo(String atrId, DeliveryInfo deliveryInfo);

  Future<void> setAckInfo(
      String atrId, AcknowledgementInfo acknowledgementInfo);

  Future<void> setContingencyPlanInfo(
      String atrId, ContingencyPlanInfo contingencyPlanInfo);

  Future<void> removeAtr(String atrId);

  Future<dynamic> getRecord(User user);
}
