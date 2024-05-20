import 'package:matching/matching.dart';
import 'package:test/test.dart';

void main() {
  group('throwsTestFailure.', () {
    test('OK', () {
      expect(
        () => expect(true, false),
        throwsTestFailure,
      );
    });

    test('No false negative', () {
      expect(
        () => expect(true, true),
        isNot(throwsTestFailure),
      );
    });
  });

  group('throwTestFailureContaining.', () {
    test('OK', () {
      const text = 'abc';

      expect(
        () => throw TestFailure(text),
        throwsTestFailureContaining(text),
      );
      expect(
        () => throw TestFailure('--$text--'),
        throwsTestFailureContaining(text),
      );
    });

    test('No false negative', () {
      expect(
        () => expect(true, true),
        isNot(throwsTestFailureContaining('anything')),
      );
    });

    test('Not contains', () {
      const actual = 'abc';
      const expected = 'Abc';

      try {
        expect(
          () => throw TestFailure(actual),
          throwsTestFailureContaining(expected),
        );
      } on TestFailure catch (ex) {
        expect(
          ex.message,
          contains("throws TestFailure with a message containing 'Abc'"),
        );
        expect(ex.message, contains('threw TestFailure:<abc>'));
      }
    });
  });
}
