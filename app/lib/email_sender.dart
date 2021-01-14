import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/material.dart';


class EmailSender {
  Future<void> send(
      String emailBody, String eSubject, String eRecipients) async {
    final Email email = Email(
      body: emailBody,
      subject: eSubject,
      recipients: [eRecipients],
      attachmentPaths: null,
      isHTML: false,
    );
    String emailResponse;


    try {
      await FlutterEmailSender.send(email);
      emailResponse = 'success';
    } catch (error) {
      emailResponse = error.toString();
    }

    print(emailResponse);
  }
}

class EmailRoute extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final validate = false;



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
                      email.send(bodyController.text, subjectController.text,
                          recipientController.text);
                    }
                  },
                  child: Text('Submit'),
                ),
              ]),
            )));
  }
}
