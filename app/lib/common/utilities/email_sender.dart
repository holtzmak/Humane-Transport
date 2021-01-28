import 'dart:io';
import 'package:app/screens/history/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/material.dart';

class EmailSender {
    String emailResponse;
    Future<String> send(String emailBody, String eSubject, String eRecipients,
        File attach) async {
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
        await FlutterEmailSender.send(email);
        emailResponse = 'Email Sent';
      } catch (error) {
        emailResponse = error.toString();
      }
      return emailResponse;
    }
  }
}

class EmailRoute extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final validate = false;
  final pdf;
  EmailRoute({Key key, @required this.pdf}) : super(key: key);

  final email = EmailSender();
  final recipientController = TextEditingController();
  final subjectController = TextEditingController();
  final bodyController = TextEditingController();

  Widget build(BuildContext context) {
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
                     Future.value(email.send(
                              bodyController.text,
                              subjectController.text,
                              recipientController.text,
                              pdf)).then((values) => showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(),
                                    elevation: 14,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(email.emailResponse),
                                    ),
                                  );
                                },
                              ));
                    }
                    Navigator.of(context).pushNamed(TravelHistory.route);
                  },
                  child: Text('Submit'),
                ),
              ]),
            )));
  }
}
