import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/ui/widgets/atr_display.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnimalTransportRecordPreview extends StatelessWidget {
  final AnimalTransportRecord atr;

  AnimalTransportRecordPreview({@required this.atr});

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
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AnimalTransportRecordDisplay(atr: atr))),
    )));
  }
}
