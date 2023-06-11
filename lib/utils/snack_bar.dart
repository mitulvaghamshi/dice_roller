import 'package:dice_roller/utils/palette.dart';
import 'package:flutter/material.dart';

/// Use this when creating [MaterialApp] if you want [showSnackBar] to work.
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey(debugLabel: 'scaffoldMessengerKey');

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

void showErrorbar(String errorMessage, {SnackBarAction? action}) {
  var palette = Palette();
  var richText = RichText(
    text: TextSpan(children: [
      TextSpan(
        text: 'Error: ',
        style: TextStyle(color: palette.redPen, fontWeight: FontWeight.bold),
      ),
      TextSpan(text: errorMessage, style: TextStyle(color: palette.ink)),
    ]),
  );
  var snackBar = SnackBar(
    action: action,
    content: richText,
    behavior: SnackBarBehavior.floating,
    backgroundColor: palette.backgroundMain,
    dismissDirection: DismissDirection.horizontal,
    margin: const EdgeInsets.only(bottom: 30, left: 24, right: 24),
    duration: Duration(milliseconds: errorMessage.characters.length * 120),
  );

  scaffoldMessengerKey.currentState
    ?..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
