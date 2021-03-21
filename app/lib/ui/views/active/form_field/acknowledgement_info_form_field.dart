import 'dart:io';

import 'package:app/core/models/acknowledgement_info.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/ui/widgets/utility/image_screen.dart';
import 'package:flutter/material.dart';

class AcknowledgementInfoFormField extends StatefulWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  final Function(AcknowledgementInfoImages info) onSaved;
  final _ImageForm _imageForm;
  final String title = "Acknowledgements";

  void save() => _imageForm.save();

  bool validate() => _imageForm.validate();

  AcknowledgementInfoFormField(
      {Key key,
      @required AcknowledgementInfo initialInfo,
      @required this.onSaved})
      : _imageForm = _ImageForm(
          onSaved: onSaved,
          shipperAck: initialInfo.shipperAck,
          transporterAck: initialInfo.transporterAck,
          receiverAck: initialInfo.receiverAck,
        ),
        super(key: key);

  @override
  _AcknowledgementInfoFormFieldState createState() =>
      _AcknowledgementInfoFormFieldState();
}

class _AcknowledgementInfoFormFieldState
    extends State<AcknowledgementInfoFormField> {
  File _shipperAckRecentImage;
  File _transporterAckRecentImage;
  File _receiverAckRecentImage;
  String _validatorText;

  Future<File> _selectNewImage() async =>
      widget._navigationService.navigateTo(ImageScreen.route);

  Widget _showShipperAckIfOneIsAvailable() {
    if (_shipperAckRecentImage != null) {
      return Image.file(_shipperAckRecentImage);
    } else if (widget._imageForm.shipperAck.isNotEmpty) {
      return Image.network(widget._imageForm.shipperAck);
    } else {
      return CircleAvatar(
        child: Icon(Icons.image_not_supported),
      );
    }
  }

  Widget _showTransporterAckIfOneIsAvailable() {
    if (_transporterAckRecentImage != null) {
      return Image.file(_transporterAckRecentImage);
    } else if (widget._imageForm.transporterAck.isNotEmpty) {
      return Image.network(widget._imageForm.transporterAck);
    } else {
      return CircleAvatar(
        child: Icon(Icons.image_not_supported),
      );
    }
  }

  Widget _showReceiverAckIfOneIsAvailable() {
    if (_receiverAckRecentImage != null) {
      return Image.file(_receiverAckRecentImage);
    } else if (widget._imageForm.receiverAck.isNotEmpty) {
      return Image.network(widget._imageForm.receiverAck);
    } else {
      return CircleAvatar(
        child: Icon(Icons.image_not_supported),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text("Shipper acknowledgement"),
      ),
      Column(
        children: [
          RaisedButton(
              child: Text("Upload new image"),
              onPressed: () async {
                setState(() async =>
                    _shipperAckRecentImage = await _selectNewImage());
                widget._imageForm.shipperAckRecentImage =
                    _shipperAckRecentImage;
              }),
          _showShipperAckIfOneIsAvailable(),
        ],
      ),
      ListTile(
        title: Text("Transporter acknowledgement"),
      ),
      Column(
        children: [
          RaisedButton(
              child: Text("Upload new image"),
              onPressed: () async {
                setState(() async =>
                    _transporterAckRecentImage = await _selectNewImage());
                widget._imageForm.transporterAckRecentImage =
                    _transporterAckRecentImage;
              }),
          _showTransporterAckIfOneIsAvailable(),
        ],
      ),
      ListTile(
        title: Text("Consignee acknowledgement"),
      ),
      Column(
        children: [
          RaisedButton(
              child: Text("Upload new image"),
              onPressed: () async {
                setState(() async =>
                    _receiverAckRecentImage = await _selectNewImage());
                widget._imageForm.receiverAckRecentImage =
                    _receiverAckRecentImage;
              }),
          _showReceiverAckIfOneIsAvailable(),
        ],
      ),
      ListTile(
        title: Text(
          _validatorText,
          style: TextStyle(color: Colors.red),
        ),
      ),
      RaisedButton(
          child: Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => setState(() {
                _validatorText = widget._imageForm.validate()
                    ? ""
                    : "* Missing one or more of the required acknowledgement images";
              })),
    ]);
  }
}

class AcknowledgementInfoImages {
  String shipperAck;
  String transporterAck;
  String receiverAck;
  File shipperAckRecentImage;
  File transporterAckRecentImage;
  File receiverAckRecentImage;

  AcknowledgementInfoImages(
      {@required this.shipperAck,
      @required this.transporterAck,
      @required this.receiverAck,
      @required this.shipperAckRecentImage,
      @required this.transporterAckRecentImage,
      @required this.receiverAckRecentImage});
}

class _ImageForm {
  final Function(AcknowledgementInfoImages) onSaved;

  String shipperAck;
  String transporterAck;
  String receiverAck;
  File shipperAckRecentImage;
  File transporterAckRecentImage;
  File receiverAckRecentImage;

  _ImageForm(
      {@required this.onSaved,
      @required this.shipperAck,
      @required this.transporterAck,
      @required this.receiverAck,
      this.shipperAckRecentImage,
      this.transporterAckRecentImage,
      this.receiverAckRecentImage});

  bool validate() =>
      (shipperAck.isNotEmpty &&
          transporterAck.isNotEmpty &&
          receiverAck.isNotEmpty) ||
      (shipperAckRecentImage != null &&
          transporterAckRecentImage != null &&
          receiverAckRecentImage != null);

  void save() async => onSaved(AcknowledgementInfoImages(
      shipperAck: shipperAck,
      transporterAck: transporterAck,
      receiverAck: receiverAck,
      shipperAckRecentImage: shipperAckRecentImage,
      transporterAckRecentImage: transporterAckRecentImage,
      receiverAckRecentImage: receiverAckRecentImage));
}
