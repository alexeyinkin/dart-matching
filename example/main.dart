import 'package:matching/matching.dart';
import 'package:test/test.dart';

void main() {
  test('iterableEndsWith', () {
    final actual = [1, 2, 3, 4, 5];
    final ending = [4, 5];

    expect(actual, iterableEndsWith(ending));
  });

  test('stringContainsNTimes', () {
    const haystack = 'Maria';
    const needle = 'a';

    expect(haystack, stringContainsNTimes(needle, 2));
  });
}
