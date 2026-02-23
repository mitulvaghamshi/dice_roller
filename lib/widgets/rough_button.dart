import 'package:dice_roller/controllers/settings_controller.dart';
import 'package:dice_roller/utils/audio_manager.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class RoughButton extends StatelessWidget {
  const RoughButton({
    super.key,
    required this.child,
    required this.onTap,
    this.fillColor,
    this.enabled = true,
    this.draw = false,
    this.imageName = 'assets/imgs/bar.webp',
    this.padding = const .symmetric(vertical: 16, horizontal: 32),
  });

  final Widget child;
  final Color? fillColor;
  final bool enabled;
  final bool draw;
  final String imageName;
  final EdgeInsetsGeometry padding;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    final muted = context.read<SettingsController>().muted.value;
    return RawMaterialButton(
      onPressed: () async {
        if (enabled) onTap();
        if (!muted) await AudioManager.playAsset('clips/start.mp3');
      },
      padding: padding,
      splashColor: palette.pen,
      fillColor: enabled
          ? (fillColor ?? palette.backgroundButton)
          : palette.backgroundLevelSelection,
      constraints: const BoxConstraints(minWidth: 50, minHeight: 50),
      shape: BeveledRectangleBorder(borderRadius: .circular(32), side: .new()),
      child: Stack(
        alignment: .center,
        children: [if (draw) Image.asset(imageName), child],
      ),
    );
  }
}
