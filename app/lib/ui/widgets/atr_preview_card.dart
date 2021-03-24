import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/services/shared_preferences_service.dart';
import 'package:app/ui/common/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ATRPreviewCard extends StatefulWidget {
  // TODO: Move this into business logic somehow
  // Unfortunately it needs to stay here as the set as default is common
  // to all preview cards
  final SharedPreferencesService _sharedPreferencesService =
      locator<SharedPreferencesService>();
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
    return Container(
        height: double.infinity,
        child: Card(
            child: GridTile(
                child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder,
              color: NavyBlue,
              size: 50,
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
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
            RaisedButton(
              onPressed: () => widget._sharedPreferencesService
                  .setAtrAsDefault(widget.atr.asDefault()),
              child: Text('Set as default',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              color: NavyBlue,
            )
          ],
        ))));
  }
}
