import 'package:matching/matching.dart';
import 'package:test/test.dart';

void main() {
  group('iterableStartsWith.', () {
    group('Success.', () {
      test('Starts with non-empty', () {
        final actual = [1, 2, 3, 4, 5];
        final ending = [1, 2];

        expect(actual, iterableStartsWith(ending));
      });

      test('Starts with empty', () {
        final actual = [1, 2, 3, 4, 5];
        final empty = [];

        expect(actual, iterableStartsWith(empty));
      });

      test('Exact match', () {
        final actual = [1, 2, 3, 4, 5];
        final exactMatch = [1, 2, 3, 4, 5];

        expect(actual, iterableStartsWith(exactMatch));
      });
    });

    group('Error messages.', () {
      test('Wrong beginning', () {
        final actual = [1, 2, 3, 4, 5];
        final notEnding = [1, 3];

        final matcher = iterableStartsWith(notEnding);
        final mismatchDescription = StringDescription();
        final state = {};

        matcher.matches(actual, state);
        matcher.describeMismatch(actual, mismatchDescription, state, false);

        expect(
          mismatchDescription.toString(),
          'has a mismatch at index 1: expected <3> as in [1, 3] '
          'but found <2>',
        );
      });

      test('Shorter', () {
        final actual = [1, 2];
        final longerBeginning = [3, 4, 5];

        final matcher = iterableStartsWith(longerBeginning);
        final mismatchDescription = StringDescription();
        final state = {};

        matcher.matches(actual, state);
        matcher.describeMismatch(actual, mismatchDescription, state, false);

        expect(
          mismatchDescription.toString(),
          'is shorter: 2 elements, expected >= 3 elements',
        );
      });
    });
  });

  group('iterableEndsWith.', () {
    group('Success.', () {
      test('Ends with non-empty', () {
        final actual = [1, 2, 3, 4, 5];
        final ending = [4, 5];

        expect(actual, iterableEndsWith(ending));
      });

      test('Ends with empty', () {
        final actual = [1, 2, 3, 4, 5];
        final empty = [];

        expect(actual, iterableEndsWith(empty));
      });

      test('Exact match', () {
        final actual = [1, 2, 3, 4, 5];
        final exactMatch = [1, 2, 3, 4, 5];

        expect(actual, iterableEndsWith(exactMatch));
      });
    });

    group('Error messages.', () {
      test('Wrong ending', () {
        final actual = [1, 2, 3, 4, 5];
        final notEnding = [3, 5];

        final matcher = iterableEndsWith(notEnding);
        final mismatchDescription = StringDescription();
        final state = {};

        matcher.matches(actual, state);
        matcher.describeMismatch(actual, mismatchDescription, state, false);

        expect(
          mismatchDescription.toString(),
          'has a mismatch at index 3: expected <3> as in [3, 5] at index 0, '
          'but found <4>',
        );
      });

      test('Shorter', () {
        final actual = [1, 2];
        final longerEnding = [1, 2, 3];

        final matcher = iterableEndsWith(longerEnding);
        final mismatchDescription = StringDescription();
        final state = {};

        matcher.matches(actual, state);
        matcher.describeMismatch(actual, mismatchDescription, state, false);

        expect(
          mismatchDescription.toString(),
          'is shorter: 2 elements, expected >= 3 elements',
        );
      });
    });
  });
}
