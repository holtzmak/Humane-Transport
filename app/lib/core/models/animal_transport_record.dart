import 'package:app/core/models/atr_identifier.dart';
import 'package:app/core/models/shipper_info.dart';
import 'package:app/core/models/transporter_info.dart';
import 'package:flutter/material.dart';

import 'acknowledgement_info.dart';
import 'contingency_plan_info.dart';
import 'delivery_info.dart';
import 'feed_water_rest_info.dart';
import 'loading_vehicle_info.dart';

@immutable
class AnimalTransportRecord {
  final AtrIdentifier identifier;
  final ShipperInfo shipInfo;
  final TransporterInfo tranInfo;
  final FeedWaterRestInfo fwrInfo;
  final LoadingVehicleInfo vehicleInfo;
  final DeliveryInfo deliveryInfo;
  final AcknowledgementInfo ackInfo;
  final ContingencyPlanInfo contingencyInfo;

  AnimalTransportRecord({
    @required this.shipInfo,
    @required this.tranInfo,
    @required this.fwrInfo,
    @required this.vehicleInfo,
    @required this.deliveryInfo,
    @required this.ackInfo,
    @required this.contingencyInfo,
    @required this.identifier,
  });

  factory AnimalTransportRecord.defaultAtr(String userId) =>
      AnimalTransportRecord(
        shipInfo: ShipperInfo.defaultShipperInfo(),
        tranInfo: TransporterInfo.defaultTransporterInfo(),
        fwrInfo: FeedWaterRestInfo.defaultFwrInfo(),
        vehicleInfo: LoadingVehicleInfo.defaultVehicleInfo(),
        deliveryInfo: DeliveryInfo.defaultDeliveryInfo(),
        ackInfo: AcknowledgementInfo.defaultAckInfo(),
        contingencyInfo: ContingencyPlanInfo.defaultContingencyInfo(),
        identifier: AtrIdentifier.defaultAtrIdentifier(userId),
      );

  @override
  int get hashCode =>
      shipInfo.hashCode ^
      tranInfo.hashCode ^
      fwrInfo.hashCode ^
      vehicleInfo.hashCode ^
      deliveryInfo.hashCode ^
      ackInfo.hashCode ^
      contingencyInfo.hashCode ^
      identifier.hashCode;

  @override
  bool operator ==(other) {
    return (other is AnimalTransportRecord) &&
        other.shipInfo == shipInfo &&
        other.tranInfo == tranInfo &&
        other.fwrInfo == fwrInfo &&
        other.vehicleInfo == vehicleInfo &&
        other.deliveryInfo == deliveryInfo &&
        other.ackInfo == ackInfo &&
        other.contingencyInfo == contingencyInfo &&
        other.identifier == identifier;
  }

  AnimalTransportRecord.fromJSON(
      Map<String, dynamic> json, String atrDocumentId)
      : shipInfo = ShipperInfo.fromJSON(json['shipperInfo']),
        tranInfo = TransporterInfo.fromJSON(json['transportInfo']),
        fwrInfo = FeedWaterRestInfo.fromJSON(json['feedWaterRestInfo']),
        vehicleInfo = LoadingVehicleInfo.fromJSON(json['loadingVehicleInfo']),
        deliveryInfo = DeliveryInfo.fromJSON(json['deliveryInfo']),
        ackInfo = AcknowledgementInfo.fromJSON(json['acknowledgementInfo']),
        contingencyInfo =
            ContingencyPlanInfo.fromJSON(json['contingencyPlanInfo']),
        identifier = AtrIdentifier.fromJSON(json['identifier'], atrDocumentId);

  Map<String, dynamic> toJSON() => {
        'shipperInfo': shipInfo.toJSON(),
        'transportInfo': tranInfo.toJSON(),
        'feedWaterRestInfo': fwrInfo.toJSON(),
        'loadingVehicleInfo': vehicleInfo.toJSON(),
        'deliveryInfo': deliveryInfo.toJSON(),
        'acknowledgementInfo': ackInfo.toJSON(),
        'contingencyPlanInfo': contingencyInfo.toJSON(),
        'identifier': identifier.toJSON(),
      };

  String toString() => '''Shipper's Information: $shipInfo
  Transporter's Information: $tranInfo
  Feed, Water, and Rest Information: $fwrInfo
  Loading Vehicle Information: $vehicleInfo
  Delivery Information: $deliveryInfo
  Acknowledgements: $ackInfo
  Contingency Plan: $contingencyInfo''';

  AnimalTransportRecord withDocId(String docId) => AnimalTransportRecord(
      shipInfo: shipInfo,
      tranInfo: tranInfo,
      fwrInfo: fwrInfo,
      vehicleInfo: vehicleInfo,
      deliveryInfo: deliveryInfo,
      ackInfo: ackInfo,
      contingencyInfo: contingencyInfo,
      identifier: AtrIdentifier(
          userId: identifier.userId,
          isComplete: identifier.isComplete,
          atrDocumentId: docId));

  AnimalTransportRecord asComplete() => AnimalTransportRecord(
      shipInfo: shipInfo,
      tranInfo: tranInfo,
      fwrInfo: fwrInfo,
      vehicleInfo: vehicleInfo,
      deliveryInfo: deliveryInfo,
      ackInfo: ackInfo,
      contingencyInfo: contingencyInfo,
      identifier: AtrIdentifier(
          userId: identifier.userId,
          isComplete: true,
          atrDocumentId: identifier.atrDocumentId));

  AnimalTransportRecord withShipInfo(ShipperInfo newShipInfo) =>
      AnimalTransportRecord(
        shipInfo: newShipInfo,
        tranInfo: tranInfo,
        fwrInfo: fwrInfo,
        vehicleInfo: vehicleInfo,
        deliveryInfo: deliveryInfo,
        ackInfo: ackInfo,
        contingencyInfo: contingencyInfo,
        identifier: identifier,
      );

  AnimalTransportRecord withTransporterInfo(TransporterInfo newTranInfo) =>
      AnimalTransportRecord(
        shipInfo: shipInfo,
        tranInfo: newTranInfo,
        fwrInfo: fwrInfo,
        vehicleInfo: vehicleInfo,
        deliveryInfo: deliveryInfo,
        ackInfo: ackInfo,
        contingencyInfo: contingencyInfo,
        identifier: identifier,
      );

  AnimalTransportRecord withFwrInfo(FeedWaterRestInfo newFwrInfo) =>
      AnimalTransportRecord(
        shipInfo: shipInfo,
        tranInfo: tranInfo,
        fwrInfo: newFwrInfo,
        vehicleInfo: vehicleInfo,
        deliveryInfo: deliveryInfo,
        ackInfo: ackInfo,
        contingencyInfo: contingencyInfo,
        identifier: identifier,
      );

  AnimalTransportRecord withVehicleInfo(LoadingVehicleInfo newVehicleInfo) =>
      AnimalTransportRecord(
        shipInfo: shipInfo,
        tranInfo: tranInfo,
        fwrInfo: fwrInfo,
        vehicleInfo: newVehicleInfo,
        deliveryInfo: deliveryInfo,
        ackInfo: ackInfo,
        contingencyInfo: contingencyInfo,
        identifier: identifier,
      );

  AnimalTransportRecord withDeliveryInfo(DeliveryInfo newDeliveryInfo) =>
      AnimalTransportRecord(
        shipInfo: shipInfo,
        tranInfo: tranInfo,
        fwrInfo: fwrInfo,
        vehicleInfo: vehicleInfo,
        deliveryInfo: newDeliveryInfo,
        ackInfo: ackInfo,
        contingencyInfo: contingencyInfo,
        identifier: identifier,
      );

  AnimalTransportRecord withAckInfo(AcknowledgementInfo newAckInfo) =>
      AnimalTransportRecord(
        shipInfo: shipInfo,
        tranInfo: tranInfo,
        fwrInfo: fwrInfo,
        vehicleInfo: vehicleInfo,
        deliveryInfo: deliveryInfo,
        ackInfo: newAckInfo,
        contingencyInfo: contingencyInfo,
        identifier: identifier,
      );

  AnimalTransportRecord withContingencyInfo(
          ContingencyPlanInfo newContingencyInfo) =>
      AnimalTransportRecord(
        shipInfo: shipInfo,
        tranInfo: tranInfo,
        fwrInfo: fwrInfo,
        vehicleInfo: vehicleInfo,
        deliveryInfo: deliveryInfo,
        ackInfo: ackInfo,
        contingencyInfo: newContingencyInfo,
        identifier: identifier,
      );
}
