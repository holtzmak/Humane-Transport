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
  String _validatorText = "";

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
              key: ObjectKey("Shipper ack image picker"),
              child: Text(
                "Upload new image",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                _shipperAckRecentImage = await widget._navigationService
                    .navigateTo(ImageScreen.route) as File;
                setState(() => widget._imageForm.shipperAckRecentImage =
                    _shipperAckRecentImage);
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
              key: ObjectKey("Transporter ack image picker"),
              child: Text(
                "Upload new image",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                _transporterAckRecentImage = await widget._navigationService
                    .navigateTo(ImageScreen.route) as File;
                setState(() => widget._imageForm.transporterAckRecentImage =
                    _transporterAckRecentImage);
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
              key: ObjectKey("Receiver ack image picker"),
              child: Text(
                "Upload new image",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                _receiverAckRecentImage = await widget._navigationService
                    .navigateTo(ImageScreen.route) as File;
                setState(() => widget._imageForm.receiverAckRecentImage =
                    _receiverAckRecentImage);
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
                if (widget._imageForm.validate()) {
                  setState(() => _validatorText = "");
                  widget._imageForm.save();
                } else {
                  setState(() => _validatorText =
                      "* Missing one or more of the required acknowledgement images");
                }
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AcknowledgementInfoImages &&
          runtimeType == other.runtimeType &&
          shipperAck == other.shipperAck &&
          transporterAck == other.transporterAck &&
          receiverAck == other.receiverAck &&
          shipperAckRecentImage == other.shipperAckRecentImage &&
          transporterAckRecentImage == other.transporterAckRecentImage &&
          receiverAckRecentImage == other.receiverAckRecentImage;

  @override
  int get hashCode =>
      shipperAck.hashCode ^
      transporterAck.hashCode ^
      receiverAck.hashCode ^
      shipperAckRecentImage.hashCode ^
      transporterAckRecentImage.hashCode ^
      receiverAckRecentImage.hashCode;

  @override
  String toString() {
    return 'AcknowledgementInfoImages{shipperAck: $shipperAck, transporterAck: $transporterAck, receiverAck: $receiverAck, shipperAckRecentImage: $shipperAckRecentImage, transporterAckRecentImage: $transporterAckRecentImage, receiverAckRecentImage: $receiverAckRecentImage}';
  }
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
      (shipperAck.isNotEmpty || shipperAckRecentImage != null) &&
      (transporterAck.isNotEmpty || transporterAckRecentImage != null) &&
      (receiverAck.isNotEmpty || receiverAckRecentImage != null);

  void save() async => onSaved(AcknowledgementInfoImages(
      shipperAck: shipperAck,
      transporterAck: transporterAck,
      receiverAck: receiverAck,
      shipperAckRecentImage: shipperAckRecentImage,
      transporterAckRecentImage: transporterAckRecentImage,
      receiverAckRecentImage: receiverAckRecentImage));
}
