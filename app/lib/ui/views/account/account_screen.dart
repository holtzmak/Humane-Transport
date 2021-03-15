import 'package:app/core/view_models/account_screen_view_model.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/common/style.dart';
import 'package:hexcolor/hexcolor.dart';

class AccountScreen extends StatelessWidget {
  static const route = '/accountScreen';

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<AccountScreenViewModel>(
      onModelReady: (model) => model.loadTransporterInfo(),
      builder: (context, model, child) => Scaffold(
        appBar: appBar('Profile'),
        body: model.transporter != null
            ? Center(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.account_circle_sharp,
                          size: 30.0,
                          color: buttonColor,
                        ),
                        title: Text(
                          '${model.transporter.firstName} ${model.transporter.lastName}',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () =>
                              model.navigateToAccountEditingScreen(),
                          child: Text('Edit'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  buttonColor)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Table(
                        border:
                            TableBorder.all(color: Colors.black12, width: 2),
                        children: [
                          TableRow(
                              decoration:
                                  BoxDecoration(color: HexColor('#BFBA9F')),
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.call,
                                    size: 30.0,
                                    color: buttonColor,
                                  ),
                                  title: Text(
                                    '${model.transporter.userPhoneNumber}',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                              ]),
                          TableRow(
                              decoration:
                                  BoxDecoration(color: HexColor('#BFBA9F')),
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.markunread,
                                    size: 30.0,
                                    color: buttonColor,
                                  ),
                                  title: Text(
                                    '${model.transporter.userEmailAddress} ',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                              ])
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
