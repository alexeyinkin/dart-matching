import 'package:test/expect.dart';

Matcher iterableEndsWith(Iterable expected) => _IterableEndsWith(expected);

const _mismatchKey = 'mismatch';

class _IterableEndsWith extends Matcher {
  final Iterable _expected;

  _IterableEndsWith(this._expected);

  @override
  bool matches(item, Map matchState) {
    if (item is! Iterable) {
      return false;
    }

    final actual = item.toList();
    final expected = _expected.toList();

    if (actual.length < expected.length) {
      matchState[_mismatchKey] = _ShorterMismatch(
        actualLength: actual.length,
        expectedLength: expected.length,
      );

      return false;
    }

    for (int i = 0; i < expected.length; i++) {
      final index = actual.length - expected.length + i;
      final actualElement = actual[index];
      final expectedElement = expected[i];

      if (actualElement != expectedElement) {
        matchState[_mismatchKey] = _ItemMismatch(
          actual: actualElement,
          actualIndex: index,
          expected: expectedElement,
          expectedIndex: i,
        );

        return false;
      }
    }

    return true;
  }

  @override
  Description describe(Description description) {
    return description.add('an Iterable ending with $_expected');
  }

  @override
  Description describeMismatch(
    item,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    if (item is! Iterable) {
      return mismatchDescription.add('is not an Iterable');
    }

    final mismatch = matchState[_mismatchKey];

    switch (mismatch) {
      case _ShorterMismatch mismatch:
        return mismatchDescription.add(
          'is shorter: ${mismatch.actualLength} elements, '
          'expected >= ${mismatch.expectedLength} elements',
        );
      case _ItemMismatch mismatch:
        return mismatchDescription
            .add('has a mismatch at index ${mismatch.actualIndex}: ')
            .add('expected ')
            .addDescriptionOf(mismatch.expected)
            .add(' as in ')
            .addDescriptionOf(_expected)
            .add(' at index ${mismatch.expectedIndex}, but found ')
            .addDescriptionOf(mismatch.actual);
    }

    return mismatchDescription.add('was $item');
  }
}

class _ShorterMismatch {
  const _ShorterMismatch({
    required this.actualLength,
    required this.expectedLength,
  });

  final int actualLength;
  final int expectedLength;
}

class _ItemMismatch {
  const _ItemMismatch({
    required this.actual,
    required this.actualIndex,
    required this.expected,
    required this.expectedIndex,
  });

  final Object? actual;
  final int actualIndex;
  final Object? expected;
  final int expectedIndex;
}
