import 'package:app/models/shipper_info.dart';
import 'package:app/models/transporter_info.dart';
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

  AnimalTransportRecord(this.shipInfo, this.tranInfo, this.fwrInfo,
      this.vehicleInfo, this.deliveryInfo, this.ackInfo, this.contingencyInfo);

  AnimalTransportRecord withShipInfo(ShipperInfo newShipInfo) =>
      AnimalTransportRecord(newShipInfo, tranInfo, fwrInfo, vehicleInfo,
          deliveryInfo, ackInfo, contingencyInfo);

  AnimalTransportRecord withTransporterInfo(TransporterInfo newTranInfo) =>
      AnimalTransportRecord(shipInfo, newTranInfo, fwrInfo, vehicleInfo,
          deliveryInfo, ackInfo, contingencyInfo);

  AnimalTransportRecord withFwrInfo(FeedWaterRestInfo newFwrInfo) =>
      AnimalTransportRecord(shipInfo, tranInfo, newFwrInfo, vehicleInfo,
          deliveryInfo, ackInfo, contingencyInfo);

  AnimalTransportRecord withVehicleInfo(LoadingVehicleInfo newVehicleInfo) =>
      AnimalTransportRecord(shipInfo, tranInfo, fwrInfo, newVehicleInfo,
          deliveryInfo, ackInfo, contingencyInfo);

  AnimalTransportRecord withDeliveryInfo(DeliveryInfo newDeliveryInfo) =>
      AnimalTransportRecord(shipInfo, tranInfo, fwrInfo, vehicleInfo,
          newDeliveryInfo, ackInfo, contingencyInfo);

  AnimalTransportRecord withAckInfo(AcknowledgementInfo newAckInfo) =>
      AnimalTransportRecord(shipInfo, tranInfo, fwrInfo, vehicleInfo,
          deliveryInfo, newAckInfo, contingencyInfo);

  AnimalTransportRecord withContingencyInfo(
          ContingencyPlanInfo newContingencyInfo) =>
      AnimalTransportRecord(shipInfo, tranInfo, fwrInfo, vehicleInfo,
          deliveryInfo, ackInfo, newContingencyInfo);
}
