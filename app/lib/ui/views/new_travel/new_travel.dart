import 'package:app/core/utilities/image_upload.dart';
import 'package:app/core/view_models/signout_view_model.dart';
import 'package:app/ui/views/base_view.dart';
import 'package:app/ui/widgets/utility/alert_dialog.dart';
import 'package:app/ui/widgets/utility/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'new_travel_journey.dart/test_screen_one.dart';

class NewTravel extends StatelessWidget {
  static const route = '/home/new_travel';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      drawer: SideBar(),
      body: Center(
        child: BaseView<SignOutViewModel>(
          builder: (context, model, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Testing feature for uploading image'),
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(UploadImage.route),
                child: Text('Upload Image'),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text('Go to page with bottom nav'),
              RaisedButton(
                onPressed: () => Navigator.of(context, rootNavigator: false)
                    .pushNamed(TestScreenOne.route),
                child: Text('Go Next'),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text('Go to page without bottom nav'),
              RaisedButton(
                onPressed: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(TestScreenOne.route),
                child: Text('Go Next'),
              ),
              SizedBox(
                height: 50.0,
              ),
              RaisedButton(
                onPressed: () async => Future.delayed(Duration(seconds: 2))
                    .then((_) => launchAlertDialog(context,
                        title: "An alert in 2 seconds?",
                        warning: "I am the Future!")),
                child: Text('Launch Future (2 seconds delay)'),
              ),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(
                height: 50.0,
              ),
              RaisedButton(
                onPressed: () => model.signOut(),
                child: Text('Sign Out'),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
