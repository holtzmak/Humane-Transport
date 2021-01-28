import 'package:app/common/utilities/optional.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Optional", () {
    test('Value is present', () {
      expect(Optional("test").isPresent(), true);
    });
    test('Value is not present', () {
      expect(Optional(null).isPresent(), false);
    });
    test('Value get does not throw', () {
      expect(Optional("test").get(), "test");
    });
    test('Value get does throw', () {
      expect(() => Optional(null).get(), throwsException);
    });
  });
}
