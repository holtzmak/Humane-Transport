import 'package:app/core/models/animal_transport_record.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ATRPreviewCard extends StatefulWidget {
  final AnimalTransportRecord atr;

  final GestureTapCallback onTap;

  ATRPreviewCard({Key key, @required this.atr, @required this.onTap})
      : super(key: key);

  @override
  _AtrPreviewState createState() => _AtrPreviewState();
}

class _AtrPreviewState extends State<ATRPreviewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Material(
            child: ListTile(
      leading: Icon(Icons.local_shipping),
      title: Text(
          'Delivery for ${widget.atr.deliveryInfo.recInfo.receiverCompanyName}'),
      subtitle: Text(
          '${DateFormat("yyyy-MM-dd hh:mm").format(widget.atr.vehicleInfo.dateAndTimeLoaded)} ${widget.atr.vehicleInfo.animalSpeciesLoaded.join(',')}'),
      onTap: widget.onTap,
    )));
  }
}
