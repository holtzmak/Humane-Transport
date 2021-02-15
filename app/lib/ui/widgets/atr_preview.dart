import 'package:app/core/models/animal_transport_record.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ATRPreview extends StatelessWidget {
  final AnimalTransportRecord atr;

  final GestureTapCallback onTap;

  ATRPreview({@required this.atr, @required this.onTap});

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
      onTap: onTap,
    )));
  }
}
