import 'package:app/core/view_models/ongoing_view_model.dart';
import 'package:app/ui/views/base_view.dart';
import 'package:app/ui/widgets/post_item.dart';
import 'package:flutter/material.dart';

class OngoingTravel extends StatelessWidget {
  static const route = '/ongoing';
  @override
  Widget build(BuildContext context) {
    return BaseView<OngoingViewModel>(
      onModelReady: (model) => model.listenToTavelHistoryChanges(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: model.histories.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => model.editHistoryTravel(index),
                    child: PostItem(
                      history: model.histories[index],
                      onDeleteItem: () => model.deletePost(index),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () => model.navigateToCreateView(),
                child: Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
