import 'package:app/core/services/validation_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validation Service', () {
    test('string field validation success when not empty or null', () async {
      expect(null, ValidationService().stringFieldValidator("abc"));
    });
    test('string field validation failure when empty', () async {
      expect("* Required", ValidationService().stringFieldValidator(""));
    });
    test('string field validation failure when null', () async {
      expect("* Required", ValidationService().stringFieldValidator(null));
    });
    test('int field validation success when not 0 or null', () async {
      expect(null, ValidationService().intFieldValidator(123));
    });
    test('int field validation failure when 0', () async {
      expect("* Required", ValidationService().intFieldValidator(0));
    });
    test('int field validation failure when null', () async {
      expect("* Required", ValidationService().intFieldValidator(null));
    });
    test('non null int field validation success when not null', () async {
      expect(null, ValidationService().nonNullIntFieldValidator(123));
    });
    test('non null int field validation failure when null', () async {
      expect("* Required", ValidationService().nonNullIntFieldValidator(null));
    });
    test('can be empty field validation always successful when null', () async {
      expect(null, ValidationService().canBeEmptyFieldValidator(null));
    });
    test('can be empty field validation always successful when empty',
        () async {
      expect(null, ValidationService().canBeEmptyFieldValidator(""));
    });
    test('can be empty field validation always successful', () async {
      expect(null, ValidationService().canBeEmptyFieldValidator("abc"));
    });
    test('password validation success when password at least 6 characters',
        () async {
      expect(null, ValidationService().passwordValidator("abc123"));
    });
    test('password validation failure when password empty', () async {
      expect("* Required", ValidationService().passwordValidator(""));
    });
    test('password validation failure when password less than 6 characters',
        () async {
      expect("Password should be at least 6 characters",
          ValidationService().passwordValidator("12345"));
    });
    test('password validation failure when password null', () async {
      expect("* Required", ValidationService().passwordValidator(null));
    });
    test('password validation failure when password greater than 10 characters',
        () async {
      expect("Password should not be greater than 10 characters",
          ValidationService().passwordValidator("abc123efg45"));
    });
    test('email validation success when email is regex valid', () async {
      expect(null, ValidationService().emailValidator("abc@gmail.com"));
    });
    test('email validation failure when email is regex invalid', () async {
      expect('* Please enter a valid Email',
          ValidationService().emailValidator("bademail.com"));
    });
    test('email validation failure when email empty', () async {
      expect('* Required', ValidationService().emailValidator(""));
    });
    test('email validation failure when email null', () async {
      expect('* Required', ValidationService().emailValidator(null));
    });
  });
}
