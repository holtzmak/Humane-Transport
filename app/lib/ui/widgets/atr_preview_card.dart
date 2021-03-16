import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/ui/common/style.dart';
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
        child: GridTile(
            child: Column(
      children: [
        Icon(
          Icons.folder,
          color: NavyBlue,
          size: 40,
        ),
        ListTile(
          title: Text(
            'Transport for ${widget.atr.deliveryInfo.recInfo.receiverCompanyName}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: BodyTextSize),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${DateFormat("yyyy-MM-dd hh:mm").format(widget.atr.vehicleInfo.dateAndTimeLoaded)}',
            textAlign: TextAlign.center,
          ),
          onTap: widget.onTap,
        )
      ],
    )));
  }
}
