import 'package:app/core/view_models/account_screen_view_model.dart';
import 'package:app/ui/common/default_image.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/widgets/utility/setting_icon.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const route = '/accountScreen';

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<AccountScreenViewModel>(
      onModelReady: (model) => model.loadTransporterInfo(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(
                color: NavyBlue,
                fontWeight: FontWeight.bold,
                fontSize: MediumTextSize),
          ),
          actions: <Widget>[SettingIconWidget()],
          automaticallyImplyLeading: false,
          backgroundColor: White,
          leading: new IconButton(
              color: NavyBlue,
              icon: new Icon(Icons.arrow_back),
              onPressed: model.navigateToHomeScreen),
        ),
        body: model.transporter != null
            ? Center(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.grey[300],
                            backgroundImage:
                                model.transporter.displayImageUrl.isNotEmpty
                                    ? NetworkImage(
                                        model.transporter.displayImageUrl)
                                    : NetworkImage(defaultImage)),
                        title: Text(
                          '${model.transporter.firstName} ${model.transporter.lastName}',
                        ),
                        trailing: ElevatedButton(
                          onPressed: () =>
                              model.navigateToAccountEditingScreen(),
                          child: Text('Edit'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(NavyBlue)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Table(
                        border:
                            TableBorder.all(color: Colors.black12, width: 2),
                        children: [
                          if (model.transporter.isAdmin)
                            TableRow(
                                decoration: BoxDecoration(color: Beige),
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.account_circle,
                                      size: 30.0,
                                      color: NavyBlue,
                                    ),
                                    title: Text(
                                      'Administrator',
                                    ),
                                  ),
                                ]),
                          TableRow(
                              decoration: BoxDecoration(color: Beige),
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.call,
                                    size: 30.0,
                                    color: NavyBlue,
                                  ),
                                  title: Text(
                                    '${model.transporter.userPhoneNumber}',
                                  ),
                                ),
                              ]),
                          TableRow(
                              decoration: BoxDecoration(color: Beige),
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.markunread,
                                    size: 30.0,
                                    color: NavyBlue,
                                  ),
                                  title: Text(
                                    '${model.transporter.userEmailAddress} ',
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
