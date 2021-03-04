import 'package:app/core/view_models/new_screen_view_model.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// TODO: Update as per #134 and #119.
class NewScreen extends StatelessWidget {
  static const route = '/new';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: TemplateBaseViewModel<NewScreenViewModel>(
          builder: (context, model, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: model.startNewAtr,
                child: Text('New'),
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
