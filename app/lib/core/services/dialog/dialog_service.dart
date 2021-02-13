// Followed tutorial: https://www.filledstacks.com/post/manager-your-flutter-dialogs-with-a-dialog-manager/
import 'dart:async';
import 'package:app/core/models/dialog.dart';
import 'package:flutter/material.dart';

class DialogService {
  GlobalKey<NavigatorState> _dialogNavigationKey = GlobalKey<NavigatorState>();
  Function(DialogRequest) _showDialogListener;
  Completer<DialogResponse> _dialogCompleter;

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<DialogResponse> showDialog({
    String title,
    String description,
    String buttonText = 'Ok',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonText: buttonText,
    ));
    return _dialogCompleter.future;
  }

  Future<DialogResponse> showConfirmationDialog(
      {String title,
      String description,
      String confirmationText = 'Ok',
      String cancelText = 'Cancel'}) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
        title: title,
        description: description,
        buttonText: confirmationText,
        cancelText: cancelText));
    return _dialogCompleter.future;
  }

  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState.pop();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}
