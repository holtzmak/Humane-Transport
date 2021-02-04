import 'package:app/core/models/test_history.dart';
import 'package:app/core/view_models/add_history_view_model.dart';
import 'package:app/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class AddHistory extends StatelessWidget {
  final titleController = TextEditingController();
  final HistoryRecord editHistory;
  static const route = '/addHistory';

  AddHistory({Key key, this.editHistory}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<AddHistoryViewModel>(
      onModelReady: (model) => model.setEdittingHistory(editHistory),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0),
              Text('Add travel history'),
              TextFormField(
                decoration: InputDecoration(hintText: "Title"),
                controller: titleController,
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () => model.popScreen(),
                    child: Text('Cancel'),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (!model.busy) {
                        model.addHistory(title: titleController.text);
                        print('add button pressed');
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
