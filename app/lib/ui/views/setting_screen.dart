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
                          onPressed: model.signOut,
                          padding: EdgeInsets.all(30.0),
                          icon: Icon(
                            Icons.article,
                            color: NavyBlue,
                            size: 40.0,
                          ),
                          color: Colors.white,
                          label: Text(
                            'About License',
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
