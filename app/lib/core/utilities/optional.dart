import 'package:flutter/foundation.dart';

/// Inspired by Java's Optional type.
@immutable
class Optional<T> {
  final T _optional;

  Optional(this._optional);

  bool isPresent() => _optional != null;

  T get() =>
      isPresent() ? _optional : throw Exception("The Optional value is null!");
}
