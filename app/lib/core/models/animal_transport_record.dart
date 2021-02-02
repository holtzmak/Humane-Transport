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
  final ShipperInfo shipInfo;
  final TransporterInfo tranInfo;
  final FeedWaterRestInfo fwrInfo;
  final LoadingVehicleInfo vehicleInfo;
  final DeliveryInfo deliveryInfo;
  final AcknowledgementInfo ackInfo;
  final ContingencyPlanInfo contingencyInfo;

  AnimalTransportRecord(
      {@required this.shipInfo,
      @required this.tranInfo,
      @required this.fwrInfo,
      @required this.vehicleInfo,
      @required this.deliveryInfo,
      @required this.ackInfo,
      @required this.contingencyInfo});

  AnimalTransportRecord withShipInfo(ShipperInfo newShipInfo) =>
      AnimalTransportRecord(
          shipInfo: newShipInfo,
          tranInfo: tranInfo,
          fwrInfo: fwrInfo,
          vehicleInfo: vehicleInfo,
          deliveryInfo: deliveryInfo,
          ackInfo: ackInfo,
          contingencyInfo: contingencyInfo);

  AnimalTransportRecord withTransporterInfo(TransporterInfo newTranInfo) =>
      AnimalTransportRecord(
          shipInfo: shipInfo,
          tranInfo: newTranInfo,
          fwrInfo: fwrInfo,
          vehicleInfo: vehicleInfo,
          deliveryInfo: deliveryInfo,
          ackInfo: ackInfo,
          contingencyInfo: contingencyInfo);

  AnimalTransportRecord withFwrInfo(FeedWaterRestInfo newFwrInfo) =>
      AnimalTransportRecord(
          shipInfo: shipInfo,
          tranInfo: tranInfo,
          fwrInfo: newFwrInfo,
          vehicleInfo: vehicleInfo,
          deliveryInfo: deliveryInfo,
          ackInfo: ackInfo,
          contingencyInfo: contingencyInfo);

  AnimalTransportRecord withVehicleInfo(LoadingVehicleInfo newVehicleInfo) =>
      AnimalTransportRecord(
          shipInfo: shipInfo,
          tranInfo: tranInfo,
          fwrInfo: fwrInfo,
          vehicleInfo: newVehicleInfo,
          deliveryInfo: deliveryInfo,
          ackInfo: ackInfo,
          contingencyInfo: contingencyInfo);

  AnimalTransportRecord withDeliveryInfo(DeliveryInfo newDeliveryInfo) =>
      AnimalTransportRecord(
          shipInfo: shipInfo,
          tranInfo: tranInfo,
          fwrInfo: fwrInfo,
          vehicleInfo: vehicleInfo,
          deliveryInfo: newDeliveryInfo,
          ackInfo: ackInfo,
          contingencyInfo: contingencyInfo);

  AnimalTransportRecord withAckInfo(AcknowledgementInfo newAckInfo) =>
      AnimalTransportRecord(
          shipInfo: shipInfo,
          tranInfo: tranInfo,
          fwrInfo: fwrInfo,
          vehicleInfo: vehicleInfo,
          deliveryInfo: deliveryInfo,
          ackInfo: newAckInfo,
          contingencyInfo: contingencyInfo);

  AnimalTransportRecord withContingencyInfo(
          ContingencyPlanInfo newContingencyInfo) =>
      AnimalTransportRecord(
          shipInfo: shipInfo,
          tranInfo: tranInfo,
          fwrInfo: fwrInfo,
          vehicleInfo: vehicleInfo,
          deliveryInfo: deliveryInfo,
          ackInfo: ackInfo,
          contingencyInfo: newContingencyInfo);
}
