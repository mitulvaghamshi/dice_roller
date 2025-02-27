import 'package:dice_roller/utils/palette.dart';
import 'package:flutter/material.dart';

/// Use this when creating [MaterialApp] if you want [showSnackBar] to work.
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey(debugLabel: '[DiceGame]:scaffoldMessengerKey');

void showBanner(String message) {
  var messenger = scaffoldMessengerKey.currentState;
  messenger?.showMaterialBanner(
    MaterialBanner(content: Text(message), actions: [
      TextButton(
        onPressed: messenger.clearMaterialBanners,
        child: const Text('Dismiss'),
      ),
    ]),
  );
}

/// Shows [message] in a snack bar as long as a [ScaffoldMessengerState]
/// with global key [scaffoldMessengerKey] is anywhere in the widget tree.
void showSnackBar(String message) {
  var messenger = scaffoldMessengerKey.currentState;
  messenger?.showSnackBar(SnackBar(content: Text(message)));
}

void showErrorbar(String message, {SnackBarAction? action}) {
  var palette = Palette();
  scaffoldMessengerKey.currentState
    ?..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        action: action,
        behavior: SnackBarBehavior.floating,
        backgroundColor: palette.backgroundMain.dark,
        dismissDirection: DismissDirection.horizontal,
        margin: const EdgeInsets.only(bottom: 30, left: 24, right: 24),
        duration: Duration(milliseconds: message.characters.length * 120),
        content: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Error: ',
              style: TextStyle(
                color: palette.redPen,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: message, style: TextStyle(color: palette.ink)),
          ]),
        ),
      ),
    );
}
