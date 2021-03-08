import 'dart:async';

import 'package:app/core/utilities/optional.dart';
import 'package:app/ui/widgets/utility/dialog.dart';
import 'package:flutter/material.dart';

/// A useful service created by FilledStacks:
/// https://www.filledstacks.com/post/manager-your-flutter-dialogs-with-a-dialog-manager/
class DialogService {
  final _dialogNavigationKey = GlobalKey<NavigatorState>();
  Function(DialogRequest) _showDialogListener;
  Optional<Completer<DialogResponse>> _dialogCompleter;

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<DialogResponse> showDialog({
    String title,
    String description,
    String buttonText = 'Ok',
  }) {
    _dialogCompleter = Optional(Completer<DialogResponse>());
    _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonText: buttonText,
    ));
    return _dialogCompleter.get().future;
  }

  Future<DialogResponse> showConfirmationDialog(
      {String title,
      String description,
      String confirmationText = 'Ok',
      String cancelText = 'Cancel'}) {
    _dialogCompleter = Optional(Completer<DialogResponse>());

    _showDialogListener(DialogRequest(
        title: title,
        description: description,
        buttonText: confirmationText,
        cancelText: cancelText));
    return _dialogCompleter.get().future;
  }

  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState.pop();
    _dialogCompleter.get().complete(response);
    _dialogCompleter = Optional.empty();
  }
}
