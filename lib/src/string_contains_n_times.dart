import 'package:test/expect.dart';

/// A matcher for [String] that contains [needle] exactly [n] times.
Matcher stringContainsNTimes(String needle, int n) =>
    _StringContainsNTimes(needle, n);

const _mismatchKey = 'mismatch';

class _StringContainsNTimes extends Matcher {
  final String _needle;
  final int _n;

  _StringContainsNTimes(this._needle, this._n);

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is! String) {
      return false;
    }

    final positions = <int>[];
    int position = -1;

    while (true) {
      position = item.indexOf(_needle, position + 1);

      if (position == -1) {
        break;
      }

      positions.add(position);
    }

    if (positions.length == _n) {
      return true;
    }

    matchState[_mismatchKey] = _Mismatch(positions: positions);
    return false;
  }

  @override
  Description describe(Description description) {
    return description.add('a String containing "$_needle" exactly $_n times');
  }

  @override
  Description describeMismatch(
    dynamic item,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    if (item is! String) {
      return mismatchDescription.add('is not a String.');
    }

    final mismatch = matchState[_mismatchKey];

    switch (mismatch) {
      case final _Mismatch mismatch:
        if (mismatch.positions.isEmpty) {
          return mismatchDescription.add('does not contain it.');
        }

        return mismatchDescription.add(
          'contains it ${mismatch.positions.length} times: '
          'at ${mismatch.positions.map((n) => '<$n>').join(', ')}:\n'
          '${_markActualWithPositions(item, mismatch.positions)}',
        );
    }

    return mismatchDescription.add('was $item');
  }

  String _markActualWithPositions(String actual, List<int> positions) {
    // Plus extra one space to align with he extra '\n' in the actual.
    final marked = _positionsToMarks(positions).padRight(actual.length + 1);
    final buffer = StringBuffer();
    int lineStart = 0;

    for (final line in actual.split('\n')) {
      final lineWithEnding = '$line\n'; // The extra '\n' in the last iteration.
      buffer.write(lineWithEnding);

      final markedPart = marked
          .substring(lineStart, lineStart + lineWithEnding.length)
          .trimRight();

      if (markedPart != '') {
        buffer.writeln(markedPart);
      }

      lineStart += lineWithEnding.length;
    }

    final result = buffer.toString();
    return result.substring(0, result.length - 1);
  }

  String _positionsToMarks(List<int> positions) {
    final buffer = StringBuffer();
    int lastPosition = 0;

    for (final position in positions) {
      buffer.write(' ' * (position - lastPosition));
      buffer.write('^');
      lastPosition = position + 1;
    }

    return buffer.toString();
  }
}

class _Mismatch {
  const _Mismatch({
    required this.positions,
  });

  final List<int> positions;
}
