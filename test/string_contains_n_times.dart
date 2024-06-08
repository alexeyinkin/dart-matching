import 'package:matching/matching.dart';
import 'package:test/test.dart';

void main() {
  group('stringContainsNTimes.', () {
    group('Success.', () {
      test('0 times', () {
        const haystack = 'Alexey';
        const needle = 'a';

        expect(haystack, stringContainsNTimes(needle, 0));
      });

      test('1 time', () {
        const haystack = 'Alexey';
        const needle = 'x';

        expect(haystack, stringContainsNTimes(needle, 1));
      });

      test('2 times', () {
        const haystack = 'Alexey';
        const needle = 'e';

        expect(haystack, stringContainsNTimes(needle, 2));
      });
    });

    group('Error messages.', () {
      test('Not a string', () {
        const haystack = 1;
        const needle = 'a';

        final matcher = stringContainsNTimes(needle, 3);
        final mismatchDescription = StringDescription();
        final state = {};

        matcher.matches(haystack, state);
        matcher.describeMismatch(haystack, mismatchDescription, state, false);

        expect(
          mismatchDescription.toString(),
          'is not a String.',
        );
      });

      test('Not contains', () {
        const haystack = 'Alexey';
        const needle = 'a';

        final matcher = stringContainsNTimes(needle, 3);
        final mismatchDescription = StringDescription();
        final state = {};

        matcher.matches(haystack, state);
        matcher.describeMismatch(haystack, mismatchDescription, state, false);

        expect(
          mismatchDescription.toString(),
          'does not contain it.',
        );
      });

      test('Contains different count, non-zero', () {
        const haystack = 'Alexey';
        const needle = 'e';

        final matcher = stringContainsNTimes(needle, 3);
        final mismatchDescription = StringDescription();
        final state = {};

        matcher.matches(haystack, state);
        matcher.describeMismatch(haystack, mismatchDescription, state, false);

        expect(
          mismatchDescription.toString(),
          'contains it 2 times: at <2>, <4>:\n'
          'Alexey\n'
          '  ^ ^',
        );
      });

      test('Marks account for line breaks', () {
        const haystack = 'aba\nbabab\nfff\nff\n';
        const needle = 'a';

        final matcher = stringContainsNTimes(needle, 3);
        final mismatchDescription = StringDescription();
        final state = {};

        matcher.matches(haystack, state);
        matcher.describeMismatch(haystack, mismatchDescription, state, false);

        expect(
          mismatchDescription.toString(),
          'contains it 4 times: at <0>, <2>, <5>, <7>:\n'
          'aba\n'
          '^ ^\n'
          'babab\n'
          ' ^ ^\n'
          'fff\n'
          'ff\n',
        );
      });

      test('Mark newlines', () {
        const haystack = 'aaa\na\n\na';
        const needle = '\n';

        final matcher = stringContainsNTimes(needle, 4);
        final mismatchDescription = StringDescription();
        final state = {};

        matcher.matches(haystack, state);
        matcher.describeMismatch(haystack, mismatchDescription, state, false);

        expect(
          mismatchDescription.toString(),
          'contains it 3 times: at <3>, <5>, <6>:\n'
          'aaa\n'
          '   ^\n'
          'a\n'
          ' ^\n'
          '\n'
          '^\n'
          'a',
        );
      });
    });
  });
}
