import 'package:app/core/view_models/new_screen_view_model.dart';
import 'package:app/ui/views/home/home_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class TestScreenThree extends StatefulWidget {
  static const route = "${HomeScreen.route}/test_screen_three";

  TestScreenThree({Key key}) : super(key: key);

  @override
  _TestScreenThreeState createState() => _TestScreenThreeState();
}

class _TestScreenThreeState extends State<TestScreenThree> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<NewScreenViewModel>(
        builder: (context, model, _) => Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios),
                  onPressed: () => model.navigateToNewScreen(),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Welcome to Test screen 3'),
                    Text('Counter is $_counter'),
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          _counter++;
                        });
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              ),
            ));
  }
}
