import 'package:app/core/services/service_locator.dart';
import 'package:app/core/services/validation_service.dart';
import 'package:app/ui/common/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailForm extends StatefulWidget {
  final ValidationService _validator = locator<ValidationService>();
  static const route = '/emailForm';
  final formKey = GlobalKey<FormState>();

  final dynamic pdf;

  EmailForm({Key key, @required this.pdf}) : super(key: key);

  @override
  _EmailForm createState() => _EmailForm();
}

class _EmailForm extends State<EmailForm> {
  String emailResponse;
  final _recipientController = TextEditingController();
  final _subjectController = TextEditingController(
    text: 'Copy of Animal Transport Record',
  );
  final _bodyController = TextEditingController(
      text: 'This email contains a copy of Animal Transport Record');

  void dispose() {
    _recipientController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Email PDF',
          style: TextStyle(color: NavyBlue),
        ),
        iconTheme: IconThemeData(color: NavyBlue),
        backgroundColor: Beige,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
            key: widget.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: widget._validator.emailValidator,
                    controller: _recipientController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2.0, color: NavyBlue)),
                        labelText: 'Add Recipient Email',
                        labelStyle: TextStyle(color: NavyBlue),
                        hintText: 'example@example.com'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: widget._validator.stringFieldValidator,
                    controller: _subjectController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: NavyBlue)),
                      labelText: 'Add Email Subject',
                      labelStyle: TextStyle(color: NavyBlue),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: widget._validator.stringFieldValidator,
                      controller: _bodyController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                          labelText: 'Add Message',
                          labelStyle: TextStyle(color: NavyBlue),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2.0, color: NavyBlue)),
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Beige,
                      border: Border.all(color: DarkerBeige),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Text(
                    "Clicking send will open your device's email application",
                    style: TextStyle(fontSize: BodyTextSize),
                  ),
                ),
                SizedBox(
                    height: 42,
                    width: 200,
                    child: RaisedButton.icon(
                      color: NavyBlue,
                      onPressed: () async {
                        if (widget.formKey.currentState.validate()) {
                          await send();
                        }
                      },
                      label: Text(
                        'Send',
                        style: TextStyle(
                            color: Colors.white, fontSize: MediumTextSize),
                      ),
                      icon: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      ),
                    )),
              ],
            )),
      ),
    );
  }

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: [
        widget.pdf.path,
      ],
      isHTML: false,
    );
    try {
      FlutterEmailSender.send(email).then((_) {
        emailResponse = 'Email Sent';
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    emailResponse,
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    'Copy of animal transport record sent!',
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          dispose();
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(color: NavyBlue),
                        )),
                  ],
                ));
      });
    } catch (error) {
      emailResponse = error.toString();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  'Error Sending Email!',
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  emailResponse,
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(color: NavyBlue),
                      )),
                ],
              ));
    }
  }
}
