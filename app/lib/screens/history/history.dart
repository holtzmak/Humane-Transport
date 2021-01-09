import 'package:flutter/material.dart';

class TravelHistory extends StatefulWidget {
  @override
  _TravelHistoryState createState() => _TravelHistoryState();
}

class _TravelHistoryState extends State<TravelHistory> {
  void initState() {
    super.initState();
    print('Init: Travel history');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back to Home'),
      ),
      body: Center(
        child: Text(
          'This is Travel History page',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
