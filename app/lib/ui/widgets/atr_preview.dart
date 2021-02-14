import 'package:app/core/models/animal_transport_record.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ATRPreview extends StatelessWidget {
  final AnimalTransportRecord atr;

  // TODO: This should be GestureTapCallback, when NavService doesn't need context
  final Function(BuildContext, AnimalTransportRecord) tapCallback;

  ATRPreview({@required this.atr, @required this.tapCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Material(
            child: ListTile(
      leading: Icon(Icons.local_shipping),
      title:
          Text('Delivery for ${atr.deliveryInfo.recInfo.receiverCompanyName}'),
      subtitle: Text(
          '${DateFormat("yyyy-MM-dd hh:mm").format(atr.vehicleInfo.dateAndTimeLoaded)} ${atr.vehicleInfo.animalSpeciesLoaded().join(',')}'),
      onTap: tapCallback(context, atr),
    )));
  }
}
