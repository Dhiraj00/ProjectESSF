import 'package:essf/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('non empty string', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid('test'), true);
  });
}