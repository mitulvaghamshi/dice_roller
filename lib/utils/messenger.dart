import 'package:dice_roller/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Use this when creating [MaterialApp] if you want [showSnackBar] to work.
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>(
  debugLabel: '[DiceGame]: scaffoldMessengerKey',
);

void showBanner(String message) {
  final messenger = scaffoldMessengerKey.currentState;
  messenger?.showMaterialBanner(
    MaterialBanner(
      content: Text(message),
      actions: [
        TextButton(
          onPressed: messenger.clearMaterialBanners,
          child: const Text('Dismiss'),
        ),
      ],
    ),
  );
}

/// Shows [message] in a snack bar as long as a [ScaffoldMessengerState]
/// with global key [scaffoldMessengerKey] is anywhere in the widget tree.
void showSnackBar(String message) {
  final messenger = scaffoldMessengerKey.currentState;
  messenger?.showSnackBar(SnackBar(content: Text(message)));
}

void showErrorBar(String message, {SnackBarAction? action}) {
  final palette = scaffoldMessengerKey.currentContext?.read<Palette>();
  final messanger = scaffoldMessengerKey.currentState;
  messanger?.hideCurrentSnackBar();
  messanger?.showSnackBar(
    SnackBar(
      action: action,
      dismissDirection: .horizontal,
      behavior: SnackBarBehavior.floating,
      backgroundColor: palette?.backgroundMainSet.dark,
      margin: const .only(bottom: 30, left: 24, right: 24),
      duration: Duration(milliseconds: message.characters.length * 120),
      content: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Error: ',
              style: TextStyle(fontWeight: .bold, color: palette?.redPen),
            ),
            TextSpan(
              text: message,
              style: TextStyle(color: palette?.ink),
            ),
          ],
        ),
      ),
    ),
  );
}
