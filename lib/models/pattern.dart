import 'package:flutter/material.dart';

@immutable
class Pattern {
  // Pattern 1
  const Pattern.p1r1()
    : points = 0,
      result = 'Pattern 1 does not apply!',
      reason = 'Sides are less then 4.';

  const Pattern.p1r2()
    : points = 10,
      result = 'Pattern 1 matched!',
      reason = 'All Dices have same values.';

  const Pattern.p1r3()
    : points = 0,
      result = 'Pattern 1 does not apply!',
      reason = 'Some Dices have different values.';

  // Pattern 2
  const Pattern.p2r1()
    : points = 0,
      result = 'Pattern 2 does not apply!',
      reason = 'Maximum score is less then 20.';

  const Pattern.p2r2()
    : points = 15,
      result = 'Pattern 2 matched!',
      reason = 'Sum is a prime number.';

  const Pattern.p2r3()
    : points = 0,
      result = 'Pattern 2 does not apply!',
      reason = 'Sum is not a prime number.';

  // Pattern 3
  const Pattern.p3r1()
    : points = 0,
      result = 'Pattern 3 does not apply!',
      reason = 'Dices are less then 5.';

  const Pattern.p3r2()
    : points = 5,
      result = 'Pattern 3 matched!',
      reason = 'At least half of Dices have same value as average.';

  const Pattern.p3r3()
    : points = 0,
      result = 'Pattern 3 does not apply!',
      reason = 'Less then half of Dices have same value as average.';

  // Pattern 4
  const Pattern.p4r1()
    : points = 0,
      result = 'Pattern 4 does not apply!',
      reason = 'Either Dices are less then 4 or Sides are less then Dices.';

  const Pattern.p4r2()
    : points = 8,
      result = 'Pattern 4 matched!',
      reason = 'All Dices have unique values.';

  const Pattern.p4r3()
    : points = 0,
      result = 'Pattern 4 does not apply!',
      reason = 'Some Dices have same values.';

  // Pattern 5
  const Pattern.p5r1()
    : points = 1,
      result = 'Pattern 5 matched!',
      reason = 'You did not match any other patterns!';

  const Pattern.p5r2()
    : points = 0,
      result = 'Pattern 5 does not apply!',
      reason = 'You already matched other pattern(s).';

  final int points;
  final String result;
  final String reason;
}
