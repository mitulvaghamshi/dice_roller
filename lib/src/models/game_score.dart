import 'package:dice_roller/src/models/game_levels.dart';
import 'package:flutter/foundation.dart';

@immutable
class GameScore {
  const GameScore._({
    required this.pointsTotal,
    required this.bonusTotal,
    required this.finalScore,
    required this.duration,
    required this.level,
    required this.diceValues,
    required this.results,
  });

  factory GameScore({
    required Iterable<int> diceValues,
    required GameLevel level,
    required Duration duration,
  }) {
    final pointsTotal = diceValues.fold(0, (acc, val) => acc + val);

    final bonuses = [
      level.pattern1(unique: diceValues.length),
      level.pattern2(sum: pointsTotal),
      level.pattern3(sum: pointsTotal, values: diceValues),
      level.pattern4(unique: diceValues.length),
    ];

    final totalP1ToP4 = bonuses.fold(0, (acc, val) => acc + val.points);
    bonuses.add(level.pattern5(bonus: totalP1ToP4));

    final bonusTotal = bonuses.fold(0, (acc, val) => acc + val.points);

    final finalScore =
        (pointsTotal / level.dices * level.sides) * bonusTotal + (821600 % 500);

    return GameScore._(
      pointsTotal: pointsTotal,
      bonusTotal: bonusTotal,
      finalScore: finalScore.round(),
      duration: duration,
      level: level,
      diceValues: diceValues,
      results: bonuses,
    );
  }

  final int pointsTotal;
  final int bonusTotal;
  final int finalScore;
  final Duration duration;
  final GameLevel level;
  final Iterable<int> diceValues;
  final Iterable<Bonus> results;

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
