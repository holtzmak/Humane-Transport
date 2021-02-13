import 'package:flutter/foundation.dart';

class DialogRequest {
  final String title;
  final String description;
  final String buttonText;
  final String cancelText;

  DialogRequest(
      {@required this.title,
      @required this.description,
      @required this.buttonText,
      this.cancelText});
}

class DialogResponse {
  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;

  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
  });
}
