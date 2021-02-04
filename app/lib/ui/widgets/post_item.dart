import 'package:app/core/models/test_history.dart';
import 'package:flutter/material.dart';

// TODO: Refactor the style
class PostItem extends StatelessWidget {
  final HistoryRecord history;
  final Function onDeleteItem;
  const PostItem({
    Key key,
    this.history,
    this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(history.title),
          )),
          IconButton(
            icon: Icon(
              Icons.delete_forever_outlined,
              size: 25,
            ),
            onPressed: () {
              if (onDeleteItem != null) {
                onDeleteItem();
              }
            },
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
          ]),
    );
  }
}
