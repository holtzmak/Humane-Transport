import 'package:app/core/utilities/optional.dart';
import 'package:flutter/material.dart';

enum ResponseType { success, failure }

class Response<T> {
  final ResponseType type;
  final String reason;
  final Optional<T> response;

  Response.failure({@required this.reason})
      : type = ResponseType.failure,
        response = Optional.empty();

  Response.success({@required this.response})
      : type = ResponseType.success,
        reason = "Successful";
}
