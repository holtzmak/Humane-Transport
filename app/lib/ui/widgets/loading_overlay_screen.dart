import 'package:app/ui/common/style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A factory for a loading overlay screen. Credit https://www.greycastle.se/loading-overlay-in-flutter/
class LoadingOverlayScreen {
  BuildContext _context;

  LoadingOverlayScreen._create(this._context);

  factory LoadingOverlayScreen.of(BuildContext context) {
    return LoadingOverlayScreen._create(context);
  }

  void hide() {
    Navigator.of(_context, rootNavigator: true).pop();
  }

  void show() {
    showDialog(
        context: _context,
        barrierDismissible: false,
        child: WillPopScope(
            child: _LoadingOverlayScreen(), onWillPop: () async => false));
  }

  Future<T> during<T>(Future<T> future) async {
    show();
    return future.whenComplete(() => hide());
  }
}

class _LoadingOverlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: OverlayColor),
        child: Center(child: CircularProgressIndicator()));
  }
}
