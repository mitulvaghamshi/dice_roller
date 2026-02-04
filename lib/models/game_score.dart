import 'package:dice_roller/models/game_levels.dart';
import 'package:dice_roller/models/pattern.dart';
import 'package:flutter/foundation.dart';

@immutable
class GameScore {
  factory GameScore({
    required Iterable<int> diceValues,
    required GameLevel level,
    required Duration duration,
  }) {
    final sum = diceValues.fold(0, (acc, val) => acc + val);

    final patterns = [
      level.pattern1(length: diceValues.length),
      level.pattern2(sum: sum),
      level.pattern3(sum: sum, values: diceValues),
      level.pattern4(length: diceValues.length),
    ];

    final totalP1ToP4 = patterns.fold(0, (acc, val) => acc + val.points);

    final patterns2 = [...patterns, level.pattern5(bonus: totalP1ToP4)];

    final bonusTotal = patterns2.fold(0, (acc, val) => acc + val.points);

    final finalScore =
        (sum / level.dices * level.sides) * bonusTotal + (821600 % 500);

    return ._(
      pointsTotal: sum,
      bonusTotal: bonusTotal,
      finalScore: finalScore.round(),
      duration: duration,
      level: level,
      diceValues: diceValues,
      results: patterns2,
    );
  }

  const GameScore._({
    required this.pointsTotal,
    required this.bonusTotal,
    required this.finalScore,
    required this.duration,
    required this.level,
    required this.diceValues,
    required this.results,
  });

  final int pointsTotal;
  final int bonusTotal;
  final int finalScore;
  final Duration duration;
  final GameLevel level;
  final Iterable<int> diceValues;
  final Iterable<Pattern> results;

  @override
  String toString() => 'Score($finalScore, $formattedTime, ${level.level})';
}

extension Utils on GameScore {
  String get descBonusFactor => 'Your bonus factor is: $bonusTotal';
  String get descFinalScore => 'These dice are worth $finalScore points.';
  String get descAllRollValues => 'You have rolled: [${diceValues.join(', ')}]';
  String get descSumAndAverage =>
      'These die sum to $pointsTotal '
      'and have an average rounded value of '
      '${(pointsTotal / level.dices).round()}';

  String get formattedTime {
    final buffer = StringBuffer();
    if (duration.inHours > 0) buffer.write(duration.inHours);
    final minutes = duration.inMinutes % Duration.minutesPerHour;
    final seconds = duration.inSeconds % Duration.secondsPerMinute;
    buffer.write(minutes > 9 ? ':$minutes' : ':0$minutes');
    buffer.write(seconds > 0 ? ':$seconds' : ':0$seconds');
    return buffer.toString();
  }
}
