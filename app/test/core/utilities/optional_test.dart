import 'package:app/core/utilities/optional.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Optional", () {
    test('Value is present', () {
      expect(Optional("test").isPresent(), true);
    });
    test('Nullable constructor, value is present', () {
      expect(Optional.ofNullable("test").isPresent(), true);
    });
    test('Of constructor, value is present', () {
      expect(Optional.of("test").isPresent(), true);
    });
    test('Value is not present', () {
      expect(Optional(null).isPresent(), false);
    });
    test('Nullable constructor, value is not present', () {
      expect(Optional.ofNullable(null).isPresent(), false);
    });
    test('Of constructor, value is not present', () {
      expect(Optional.of(null).isPresent(), false);
    });
    test('Value get does not throw', () {
      expect(Optional("test").get(), "test");
    });
    test('Value get does throw', () {
      expect(() => Optional(null).get(), throwsException);
    });
    test('Empty constructor is empty', () {
      expect(Optional.empty().isPresent(), false);
    });
  });
}
