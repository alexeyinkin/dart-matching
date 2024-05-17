import 'package:test/expect.dart';

/// Returns a matcher which matches if the match argument is greater
/// than the given [value].
Matcher isAfter<T>(Comparable<T> value) => _ComparableMatcher<T>(
      value: value,
      lessThanResult: false,
      equalResult: false,
      greaterThanResult: true,
      comparisonDescription: 'a value greater than',
    );

/// Returns a matcher which matches if the match argument is greater
/// than or equal to the given [value].
Matcher isAfterOrEqualTo<T>(Comparable<T> value) => _ComparableMatcher<T>(
      value: value,
      lessThanResult: false,
      equalResult: true,
      greaterThanResult: true,
      comparisonDescription: 'a value greater than or equal to',
    );

/// Returns a matcher which matches if the match argument is less
/// than the given [value].
Matcher isBefore<T>(Comparable<T> value) => _ComparableMatcher<T>(
      value: value,
      lessThanResult: true,
      equalResult: false,
      greaterThanResult: false,
      comparisonDescription: 'a value less than',
    );

/// Returns a matcher which matches if the match argument is less
/// than or equal to the given [value].
Matcher isBeforeOrEqualTo<T>(Comparable<T> value) => _ComparableMatcher<T>(
      value: value,
      lessThanResult: true,
      equalResult: true,
      greaterThanResult: false,
      comparisonDescription: 'a value less than or equal to',
    );

const _mismatchKey = 'mismatch';

class _ComparableMatcher<T> extends Matcher {
  const _ComparableMatcher({
    required this.value,
    required this.lessThanResult,
    required this.equalResult,
    required this.greaterThanResult,
    required this.comparisonDescription,
  });

  /// Value to compare with.
  final Comparable<T> value;

  /// What to return if actual < expected.
  final bool lessThanResult;

  /// What to return if actual == expected.
  final bool equalResult;

  /// What to return if actual > expected.
  final bool greaterThanResult;

  /// Textual name of the inequality.
  final String comparisonDescription;

  @override
  bool matches(Object? item, Map matchState) {
    if (item is! Comparable) {
      matchState[_mismatchKey] = _NotComparableMismatch(type: item.runtimeType);
      return false;
    }

    if (item is! T) {
      matchState[_mismatchKey] = _DifferentComparablesMismatch(
        actual: item.runtimeType,
        expected: T,
      );
      return false;
    }

    final bool result;
    final String comparisonResult;

    switch (item.compareTo(value)) {
      case < 0:
        result = lessThanResult;
        comparisonResult = 'is before ';
      case == 0:
        result = equalResult;
        comparisonResult = 'equals ';
      case > 0:
        result = greaterThanResult;
        comparisonResult = 'is after ';
      default:
        throw Exception('Cannot get here.');
    }

    if (!result) {
      matchState[_mismatchKey] = _ComparisonMismatch(
        comparisonResult: comparisonResult,
      );
    }

    return result;
  }

  @override
  Description describe(Description description) {
    return description
        .add(comparisonDescription)
        .add(' ')
        .addDescriptionOf(value);
  }

  @override
  Description describeMismatch(
    dynamic item,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    final mismatch = matchState[_mismatchKey];

    switch (mismatch) {
      case _NotComparableMismatch mismatch:
        return mismatchDescription.add(
          'is of type ${mismatch.type}, which is not an instance of Comparable',
        );

      case _DifferentComparablesMismatch mismatch:
        return mismatchDescription
            .add('is of type ${mismatch.actual}, ')
            .add('which is not comparable to ${mismatch.expected} ')
            .addDescriptionOf(value);

      case _ComparisonMismatch mismatch:
        return mismatchDescription
            .add(mismatch.comparisonResult)
            .addDescriptionOf(value);
    }

    return mismatchDescription.add('was $item');
  }
}

class _NotComparableMismatch {
  const _NotComparableMismatch({
    required this.type,
  });

  final Type type;
}

class _DifferentComparablesMismatch {
  const _DifferentComparablesMismatch({
    required this.actual,
    required this.expected,
  });

  final Type actual;
  final Type expected;
}

class _ComparisonMismatch {
  const _ComparisonMismatch({
    required this.comparisonResult,
  });

  final String comparisonResult;
}
