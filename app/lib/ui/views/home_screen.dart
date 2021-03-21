import 'package:app/core/view_models/home_screen_view_model.dart';
import 'package:app/ui/common/default_image.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Beige,
      appBar: appBar('Home Screen'),
      body: Center(
        child: TemplateBaseViewModel<HomeScreenViewModel>(
          onModelReady: (model) => model.loadTransporterInfo(),
          builder: (context, model, child) => SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset("assets/home_cover.jpg"),
                    // TODO: #223. Use the logged in transporter's name
                    Positioned(
                      bottom: 20.0,
                      left: 10.0,
                      child: model.transporter != null
                          ? Text(
                              '${model.transporter.firstName} ${model.transporter.lastName} ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediumTextSize),
                            )
                          : CircularProgressIndicator(
                              strokeWidth: 4,
                              valueColor: AlwaysStoppedAnimation(NavyBlue),
                            ),
                    ),
                    Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.white,
                          onPressed: model.navigateToAccountScreen,
                        )),
                    Positioned(
                      child: model.transporter != null
                          ? CircleAvatar(
                              radius: 52,
                              backgroundColor: NavyBlue,
                              child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: model.transporter
                                          .displayImageUrl.isNotEmpty
                                      ? NetworkImage(
                                          model.transporter.displayImageUrl)
                                      : NetworkImage(defaultImage)),
                            )
                          : CircularProgressIndicator(
                              strokeWidth: 4,
                              valueColor: AlwaysStoppedAnimation(NavyBlue),
                            ),
                    )
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10.0),
                  children: <Widget>[
                    RaisedButton.icon(
                      onPressed: model.startNewAtr,
                      padding: EdgeInsets.all(30.0),
                      icon: Icon(
                        Icons.add_circle,
                        color: NavyBlue,
                        size: 40.0,
                      ),
                      color: Colors.white,
                      label: Text(
                        'New Form',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: NavyBlue),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                      ),
                    ),
                    RaisedButton.icon(
                      onPressed: model.navigateToActiveScreen,
                      padding: EdgeInsets.all(30.0),
                      icon: Icon(
                        Icons.wifi_protected_setup,
                        color: NavyBlue,
                        size: 40.0,
                      ),
                      color: Colors.white,
                      label: Text(
                        'Active Form',
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
                      onPressed: model.navigateToHistoryScreen,
                      padding: EdgeInsets.all(30.0),
                      icon: Icon(
                        Icons.history_sharp,
                        color: NavyBlue,
                        size: 40.0,
                      ),
                      color: Colors.white,
                      label: Text(
                        'Travel History',
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
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
