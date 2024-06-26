import 'package:test/test.dart';

/// A matcher for functions that throw [TestFailure].
final Matcher throwsTestFailure = throwsA(isA<TestFailure>());

/// A matcher for functions that throw [TestFailure] with [message]
/// as its substring.
Matcher throwsTestFailureContaining(String message) =>
    throwsA(_IsTestFailureContaining(message));

const _mismatchKey = 'mismatch';

class _IsTestFailureContaining extends Matcher {
  final String _contains;

  _IsTestFailureContaining(this._contains);

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is! TestFailure) {
      return false;
    }

    final message = item.message;

    if (message == null) {
      matchState[_mismatchKey] = const _NullMessageMismatch();
      return false;
    }

    if (!message.contains(_contains)) {
      matchState[_mismatchKey] = _WrongMessageMismatch(actual: message);
      return false;
    }

    return true;
  }

  @override
  Description describe(Description description) {
    return description
        .add('TestFailure with a message containing ')
        .addDescriptionOf(_contains);
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
      case _NullMessageMismatch _:
        return mismatchDescription.add(
          'TestFailure with null for message',
        );

      case final _WrongMessageMismatch mismatch:
        return mismatchDescription
            .add('TestFailure with the message ')
            .addDescriptionOf(mismatch.actual);
    }

    return mismatchDescription.add('was $item');
  }
}

class _NullMessageMismatch {
  const _NullMessageMismatch();
}

class _WrongMessageMismatch {
  const _WrongMessageMismatch({
    required this.actual,
  });

  final String actual;
}
