import 'package:app/core/models/animal_transport_record.dart';
import 'package:flutter/material.dart';

class AnimalTransportRecordPreview extends StatelessWidget {
  final AnimalTransportRecord atr;

  AnimalTransportRecordPreview({this.atr});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text(
                'Delivery for ${atr.deliveryInfo.recInfo.receiverCompanyName}'),
            subtitle: Text(
                'Date: ${atr.vehicleInfo.dateLoaded} Animals: ${atr.vehicleInfo.animalsLoaded().join(',')}'),
          ),
        ],
      ),
    );
  }
}
