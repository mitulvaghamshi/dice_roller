import 'package:dice_roller/models/game_levels.dart';
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
    final pointsTotal = diceValues.fold(0, (total, current) => total + current);

    final bonusList = [
      level.pattern1(unique: diceValues.length),
      level.pattern2(sum: pointsTotal),
      level.pattern3(sum: pointsTotal, values: diceValues),
      level.pattern4(unique: diceValues.length),
    ];

    bonusList.add(level.pattern5(
        bonus: bonusList.fold(0, (last, element) => last + element.points)));

    final bonusTotal =
        bonusList.fold(0, (last, element) => last + element.points);

    final finalScore =
        (pointsTotal / level.dices * level.sides) * bonusTotal + (821600 % 500);

    return GameScore._(
      pointsTotal: pointsTotal,
      bonusTotal: bonusTotal,
      finalScore: finalScore.round(),
      duration: duration,
      level: level,
      diceValues: diceValues,
      results: bonusList,
    );
  }

  final int pointsTotal;
  final int bonusTotal;
  final int finalScore;
  final Duration duration;
  final GameLevel level;
  final Iterable<int> diceValues;
  final Iterable<Bonus> results;

  String get formattedTime {
    final buf = StringBuffer();
    if (duration.inHours > 0) buf.write(duration.inHours);
    final minutes = duration.inMinutes % Duration.minutesPerHour;
    final seconds = duration.inSeconds % Duration.secondsPerMinute;
    buf.write(minutes > 9 ? ':$minutes' : ':0$minutes');
    buf.write(seconds > 0 ? ':$seconds' : ':0$seconds');
    return buf.toString();
  }

  String get descAllRollValues => 'You have rolled: [${diceValues.join(', ')}]';

  String get descSumAndAverage => 'These die sum to $pointsTotal '
      'and have an average rounded value of '
      '${(pointsTotal / level.dices).round()}';

  String get descBonusFactor => 'Your bonus factor is: $bonusTotal';

  String get descFinalScore => 'These dice are worth $finalScore points.';

  @override
  String toString() => 'Score<$finalScore, $formattedTime, ${level.number}>';
}
