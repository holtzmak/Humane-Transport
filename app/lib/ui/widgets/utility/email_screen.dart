import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailSender {
  String emailResponse;

  void send(
      String emailBody, String eSubject, String eRecipients, File attach) {
    final Email email = Email(
      body: emailBody,
      subject: eSubject,
      recipients: [eRecipients],
      attachmentPaths: [
        attach.path,
      ],
      isHTML: false,
    );
    try {
      FlutterEmailSender.send(email);
      emailResponse = 'Success';
    } catch (error) {
      emailResponse = error.toString();
    }
  }
}

class EmailScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  static const route = '/email_sender';
  final validate = false;
  final pdf;

  EmailScreen({Key key, @required this.pdf}) : super(key: key);

  final email = EmailSender();
  final recipientController = TextEditingController();
  final subjectController = TextEditingController();
  final bodyController = TextEditingController();

  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Email Form'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Enter Email',
                      errorText: validate ? 'Empty email address' : null),
                  controller: recipientController,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email Subject'),
                  controller: subjectController,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Message'),
                  controller: bodyController,
                ),
                RaisedButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      print('valid');
                      email.send(bodyController.text, subjectController.text,
                          recipientController.text, pdf);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Email Response'),
                                content: Text(email.emailResponse),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () =>
                                          {Navigator.of(context).pop()},
                                      child: Text('Close')),
                                ],
                              ));
                    }
                  },
                  child: Text('Submit'),
                ),
              ]),
            )));
  }
}
