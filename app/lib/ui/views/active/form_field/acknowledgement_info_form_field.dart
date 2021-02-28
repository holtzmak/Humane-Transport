import 'package:app/core/models/acknowledgement_info.dart';
import 'package:flutter/material.dart';

class AcknowledgementInfoFormField extends StatefulWidget {
  final Function(AcknowledgementInfo info) onSaved;
  final AcknowledgementInfo initialInfo;
  final String title = "Acknowledgements";

  // Use the form key to save all the fields of this form
  final formKey = GlobalKey<FormState>();

  AcknowledgementInfoFormField(
      {Key key, @required this.initialInfo, @required this.onSaved})
      : super(key: key);

  @override
  _AcknowledgementInfoFormFieldState createState() =>
      _AcknowledgementInfoFormFieldState();
}

class _AcknowledgementInfoFormFieldState
    extends State<AcknowledgementInfoFormField> {
// TODO: Resolve how to edit ack info
  void _saveAll() {
    widget.onSaved(widget.initialInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(children: [
        ListTile(
          title: Text("Shipper acknowledgement"),
          subtitle: Text("TODO"),
        ),
        ListTile(
          title: Text("Transporter acknowledgement"),
          subtitle: Text("TODO"),
        ),
        ListTile(
          title: Text("Consignee acknowledgement"),
          subtitle: Text("TODO"),
        ),
        RaisedButton(child: Text("Save"), onPressed: _saveAll)
      ]),
    );
  }
}
