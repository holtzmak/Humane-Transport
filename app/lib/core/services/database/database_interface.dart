import 'package:app/core/models/acknowledgement_info.dart';
import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/atr_identifier.dart';
import 'package:app/core/models/contingency_plan_info.dart';
import 'package:app/core/models/delivery_info.dart';
import 'package:app/core/models/feed_water_rest_info.dart';
import 'package:app/core/models/loading_vehicle_info.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/core/models/transporter.dart';
import 'package:app/core/models/transporter_info.dart';

abstract class DatabaseInterface {
  Future<void> setNewTransporter(Transporter newTransporter);

  Future<Transporter> getTransporter(String userId);

  Future<AnimalTransportRecord> setNewAtr(String userId);

  Future<void> updateAtrIdentifier(AtrIdentifier atr);

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

  Future<List<AnimalTransportRecord>> getCompleteRecords();

  Future<List<AnimalTransportRecord>> getActiveRecords();

  Stream<List<AnimalTransportRecord>> getUpdatedCompleteATRs();

  Stream<List<AnimalTransportRecord>> getUpdatedActiveATRs();
}
