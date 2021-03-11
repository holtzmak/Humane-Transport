import 'package:app/core/view_models/account_screen_view_model.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const route = '/accountScreen';

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<AccountScreenViewModel>(
      onModelReady: (model) => model.loadTransporterInfo(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
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
                          color: Colors.green[400],
                        ),
                        title: Text(
                          '${model.transporter.firstName} ${model.transporter.lastName}',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () =>
                              model.navigateToAccountEditingScreen(),
                          child: Text('Edit'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Table(
                        border: TableBorder.all(color: Colors.black12),
                        children: [
                          TableRow(children: [
                            ListTile(
                              leading: Icon(
                                Icons.call,
                                size: 30.0,
                                color: Colors.green[400],
                              ),
                              title: Text(
                                '${model.transporter.userPhoneNumber}',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            ListTile(
                              leading: Icon(
                                Icons.markunread,
                                size: 30.0,
                                color: Colors.green[400],
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
