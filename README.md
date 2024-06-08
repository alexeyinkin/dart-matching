This package is a work in progress.
It will contain all the matchers you were missing.
If you have a good general purpose matcher, submit a PR!

Currently we have:

## Comparables

- `isAfter(Comparable)`
- `isAfterOrEqualTo(Comparable)`
- `isBefore(Comparable)`
- `isBeforeOrEqualTo(Comparable)`

## Iterables

- `iterableStartsWith(Iterable)`
- `iterableEndsWith(Iterable)`

## Strings

- `stringContainsNTimes(String, int)`

## Testing Other Matchers

- `throwsTestFailure`
- `throwsTestFailureContaining(String)`
