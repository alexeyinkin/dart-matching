import 'package:matching/matching.dart';
import 'package:test/test.dart';

void main() {
  group('_ComparableMatcher.', () {
    group('Ints.', () {
      test('Comparing to a less one', () {
        const actual = 7;
        const less = 6;

        expect(actual, isAfter(less));
        expect(actual, isAfterOrEqualTo(less));

        expect(
          () => expect(actual, isBeforeOrEqualTo(less)),
          throwsTestFailureContaining('is after <6>'),
        );

        expect(
          () => expect(actual, isBefore(less)),
          throwsTestFailureContaining('is after <6>'),
        );
      });

      test('Comparing to an equal one', () {
        const actual = 7;
        const equal = 7;

        expect(
          () => expect(actual, isAfter(equal)),
          throwsTestFailureContaining('equals <7>'),
        );

        expect(actual, isAfterOrEqualTo(equal));
        expect(actual, isBeforeOrEqualTo(equal));

        expect(
          () => expect(actual, isBefore(equal)),
          throwsTestFailureContaining('equals <7>'),
        );
      });

      test('Comparing to a greater one', () {
        const actual = 7;
        const greater = 8;

        expect(
          () => expect(actual, isAfter(greater)),
          throwsTestFailureContaining('is before <8>'),
        );

        expect(
          () => expect(actual, isAfterOrEqualTo(greater)),
          throwsTestFailureContaining('is before <8>'),
        );

        expect(actual, isBeforeOrEqualTo(greater));
        expect(actual, isBefore(greater));
      });
    });

    group('Int vs expected float.', () {
      test('Comparing to a less one', () {
        const actual = 7;
        const less = 6.0;

        expect(actual, isAfter(less));
        expect(actual, isAfterOrEqualTo(less));

        expect(
          () => expect(actual, isBeforeOrEqualTo(less)),
          throwsTestFailureContaining('is after <6.0>'),
        );

        expect(
          () => expect(actual, isBefore(less)),
          throwsTestFailureContaining('is after <6.0>'),
        );
      });

      test('Comparing to an equal one', () {
        const actual = 7;
        const equal = 7.0;

        expect(
          () => expect(actual, isAfter(equal)),
          throwsTestFailureContaining('equals <7.0>'),
        );

        expect(actual, isAfterOrEqualTo(equal));
        expect(actual, isBeforeOrEqualTo(equal));

        expect(
          () => expect(actual, isBefore(equal)),
          throwsTestFailureContaining('equals <7.0>'),
        );
      });

      test('Comparing to a greater one', () {
        const actual = 7;
        const greater = 8.0;

        expect(
          () => expect(actual, isAfter(greater)),
          throwsTestFailureContaining('is before <8.0>'),
        );

        expect(
          () => expect(actual, isAfterOrEqualTo(greater)),
          throwsTestFailureContaining('is before <8.0>'),
        );

        expect(actual, isBeforeOrEqualTo(greater));
        expect(actual, isBefore(greater));
      });
    });

    group('Float vs expected int.', () {
      test('Comparing to a less one', () {
        const actual = 7.0;
        const less = 6;

        expect(actual, isAfter(less));
        expect(actual, isAfterOrEqualTo(less));

        expect(
          () => expect(actual, isBeforeOrEqualTo(less)),
          throwsTestFailureContaining('is after <6>'),
        );

        expect(
          () => expect(actual, isBefore(less)),
          throwsTestFailureContaining('is after <6>'),
        );
      });

      test('Comparing to an equal one', () {
        const actual = 7.0;
        const equal = 7;

        expect(
          () => expect(actual, isAfter(equal)),
          throwsTestFailureContaining('equals <7>'),
        );

        expect(actual, isAfterOrEqualTo(equal));
        expect(actual, isBeforeOrEqualTo(equal));

        expect(
          () => expect(actual, isBefore(equal)),
          throwsTestFailureContaining('equals <7>'),
        );
      });

      test('Comparing to a greater one', () {
        const actual = 7.0;
        const greater = 8;

        expect(
          () => expect(actual, isAfter(greater)),
          throwsTestFailureContaining('is before <8>'),
        );

        expect(
          () => expect(actual, isAfterOrEqualTo(greater)),
          throwsTestFailureContaining('is before <8>'),
        );

        expect(actual, isBeforeOrEqualTo(greater));
        expect(actual, isBefore(greater));
      });
    });

    group('Strings.', () {
      test('Comparing to a less one', () {
        const actual = 'abc';
        const less = 'Abc';

        expect(actual, isAfter(less));
        expect(actual, isAfterOrEqualTo(less));

        expect(
          () => expect(actual, isBeforeOrEqualTo(less)),
          throwsTestFailureContaining("is after 'Abc'"),
        );

        expect(
          () => expect(actual, isBefore(less)),
          throwsTestFailureContaining("is after 'Abc'"),
        );
      });

      test('Comparing to an equal one', () {
        const actual = 'abc';
        const equal = 'abc';

        expect(
          () => expect(actual, isAfter(equal)),
          throwsTestFailureContaining("equals 'abc'"),
        );

        expect(actual, isAfterOrEqualTo(equal));
        expect(actual, isBeforeOrEqualTo(equal));

        expect(
          () => expect(actual, isBefore(equal)),
          throwsTestFailureContaining("equals 'abc'"),
        );
      });

      test('Comparing to a greater one', () {
        const actual = 'abC';
        const greater = 'abc';

        expect(
          () => expect(actual, isAfter(greater)),
          throwsTestFailureContaining("is before 'abc'"),
        );

        expect(
          () => expect(actual, isAfterOrEqualTo(greater)),
          throwsTestFailureContaining("is before 'abc'"),
        );

        expect(actual, isBeforeOrEqualTo(greater));
        expect(actual, isBefore(greater));
      });
    });

    group('DateTime.', () {
      test('Comparing to a less one', () {
        final actual = DateTime.utc(1985, 8, 16, 13, 30);
        final less = DateTime.utc(1985);

        expect(actual, isAfter(less));
        expect(actual, isAfterOrEqualTo(less));

        expect(
          () => expect(actual, isBeforeOrEqualTo(less)),
          throwsTestFailureContaining(
            'is after DateTime:<1985-01-01 00:00:00.000Z>',
          ),
        );

        expect(
          () => expect(actual, isBefore(less)),
          throwsTestFailureContaining(
            'is after DateTime:<1985-01-01 00:00:00.000Z>',
          ),
        );
      });

      test('Comparing to an equal one', () {
        final actual = DateTime.utc(1985, 8, 16, 13, 30);
        final equal = DateTime.utc(1985, 8, 16, 13, 30);

        expect(
          () => expect(actual, isAfter(equal)),
          throwsTestFailureContaining(
            'equals DateTime:<1985-08-16 13:30:00.000Z>',
          ),
        );

        expect(actual, isAfterOrEqualTo(equal));
        expect(actual, isBeforeOrEqualTo(equal));

        expect(
          () => expect(actual, isBefore(equal)),
          throwsTestFailureContaining(
            'equals DateTime:<1985-08-16 13:30:00.000Z>',
          ),
        );
      });

      test('Comparing to a greater one', () {
        final actual = DateTime.utc(1985, 8, 16, 13, 30);
        final greater = DateTime.utc(1986);

        expect(
          () => expect(actual, isAfter(greater)),
          throwsTestFailureContaining(
            'is before DateTime:<1986-01-01 00:00:00.000Z>',
          ),
        );

        expect(
          () => expect(actual, isAfterOrEqualTo(greater)),
          throwsTestFailureContaining(
            'is before DateTime:<1986-01-01 00:00:00.000Z>',
          ),
        );

        expect(actual, isBeforeOrEqualTo(greater));
        expect(actual, isBefore(greater));
      });
    });

    test('Not Comparable', () {
      const actual = [];
      const less = 7;

      expect(
        () => expect(actual, isAfter(less)),
        throwsTestFailureContaining(
          'is of type List<dynamic>, which is not an instance of Comparable',
        ),
      );

      expect(
        () => expect(actual, isAfterOrEqualTo(less)),
        throwsTestFailureContaining(
          'is of type List<dynamic>, which is not an instance of Comparable',
        ),
      );

      expect(
        () => expect(actual, isBeforeOrEqualTo(less)),
        throwsTestFailureContaining(
          'is of type List<dynamic>, which is not an instance of Comparable',
        ),
      );

      expect(
        () => expect(actual, isBefore(less)),
        throwsTestFailureContaining(
          'is of type List<dynamic>, which is not an instance of Comparable',
        ),
      );
    });

    test('Different Comparables', () {
      const actual = '7';
      const less = 7;

      expect(
        () => expect(actual, isAfter(less)),
        throwsTestFailureContaining(
          'is of type String, which is not comparable to num <7>',
        ),
      );

      expect(
        () => expect(actual, isAfterOrEqualTo(less)),
        throwsTestFailureContaining(
          'is of type String, which is not comparable to num <7>',
        ),
      );

      expect(
        () => expect(actual, isBeforeOrEqualTo(less)),
        throwsTestFailureContaining(
          'is of type String, which is not comparable to num <7>',
        ),
      );

      expect(
        () => expect(actual, isBefore(less)),
        throwsTestFailureContaining(
          'is of type String, which is not comparable to num <7>',
        ),
      );
    });
  });
}
