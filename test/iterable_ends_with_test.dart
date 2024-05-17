import 'package:matching/matching.dart';
import 'package:test/test.dart';

void main() {
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
        var mismatchDescription = StringDescription();
        final state = {};

        matcher.matches(actual, state);
        matcher.describeMismatch(actual, mismatchDescription, state, false);

        expect(
          mismatchDescription.toString(),
          equals(
              'has a mismatch at index 3: expected 3 as in [3,5] at index 0, but found 4'),
        );
      });

      test('Shorter', () {
        final actual = [1, 2];
        final longerEnding = [1, 2, 3];

        final matcher = iterableEndsWith(longerEnding);
        var mismatchDescription = StringDescription();
        final state = {};

        matcher.matches(actual, state);
        matcher.describeMismatch(actual, mismatchDescription, state, false);

        expect(
          mismatchDescription.toString(),
          equals('is shorter: 2 elements, expected >= 3 elements'),
        );
      });
    });
  });
}
