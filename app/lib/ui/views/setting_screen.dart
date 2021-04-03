import 'package:app/core/view_models/setting_screen_view_model.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/widgets/utility/busy_overlay_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  static const route = '/setting';

  SettingScreen({
    Key key,
  }) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<SettingScreenViewModel>(
        builder: (context, model, child) => BusyOverlayScreen(
            show: model.state == ViewState.Busy,
            child: Scaffold(
              backgroundColor: Beige,
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: NavyBlue, //change your color here
                ),
                title: const Text('Settings',
                    style: TextStyle(
                        color: NavyBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: MediumTextSize)),
                backgroundColor: White,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10.0),
                      children: <Widget>[
                        RaisedButton.icon(
                          onPressed: model.signOut,
                          padding: EdgeInsets.all(30.0),
                          icon: Icon(
                            Icons.logout,
                            color: NavyBlue,
                            size: 40.0,
                          ),
                          color: Colors.white,
                          label: Text(
                            'Sign Out',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: NavyBlue),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                          ),
                        ),
                        RaisedButton.icon(
                          //Just added model.signOut for now, will remove once created model for about screen
                          onPressed: () => showLicensePage(
                            context: context,
                            applicationName: "Humane Transport",
                            applicationIcon: Padding(
                                padding: EdgeInsets.all(9),
                                child: Image.asset('assets/splash_screen.png',
                                    width: 60, height: 60)),
                            applicationVersion: 'Version 0.0.1',
                            applicationLegalese:
                                'Copyright (C) 2020 Clark Inocalla, Kelly Holtzman, Mansi Patel, Sana Khan.'
                                '\n\nThis program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. \n'
                                '\n\nThis program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. \n'
                                '\n\nYou should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/. \n',
                          ),
                          padding: EdgeInsets.all(30.0),
                          icon: Icon(
                            Icons.article,
                            color: NavyBlue,
                            size: 40.0,
                          ),
                          color: Colors.white,
                          label: Text(
                            'About Licenses',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: NavyBlue),
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            )));
  }
}
