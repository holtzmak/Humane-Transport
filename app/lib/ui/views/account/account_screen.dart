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
                      Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.account_circle_sharp,
                              size: 30.0,
                              color: Colors.green[400],
                            ),
                          ),
                          SizedBox(width: 30.0),
                          Text(
                            '${model.transporter.firstName} ${model.transporter.lastName}',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          SizedBox(width: 100.0),
                        ],
                      ),
                      Divider(
                        height: 40,
                        thickness: 2,
                        color: Colors.black12,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.call,
                              size: 30.0,
                              color: Colors.green[400],
                            ),
                          ),
                          SizedBox(width: 30.0),
                          Text(
                            '${model.transporter.userPhoneNumber}',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                      Divider(
                        height: 40,
                        thickness: 2,
                        color: Colors.black12,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.markunread,
                              size: 30.0,
                              color: Colors.green[400],
                            ),
                          ),
                          SizedBox(width: 30.0),
                          Text(
                            '${model.transporter.userEmailAddress} ',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                      Divider(
                        height: 40,
                        thickness: 2,
                        color: Colors.black12,
                      ),
                      ElevatedButton(
                        onPressed: () => model.navigateToAccountEditingScreen(),
                        child: Text('Edit'),
                      )
                    ],
                  ),
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
