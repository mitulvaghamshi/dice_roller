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
    this.drawRectangle = false,
    this.imageName = 'assets/imgs/bar.webp',
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
  });

  final Widget child;
  final Color? fillColor;
  final bool enabled;
  final bool drawRectangle;
  final String imageName;
  final EdgeInsetsGeometry padding;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var palette = context.read<Palette>();
    return RawMaterialButton(
      onPressed: enabled ? onTap : null,
      padding: padding,
      elevation: 5,
      disabledElevation: 5,
      splashColor: Colors.deepOrange,
      fillColor: enabled
          ? (fillColor ?? palette.backgroundButton)
          : palette.backgroundLevelSelection,
      constraints: const BoxConstraints(minWidth: 50, minHeight: 50),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [if (drawRectangle) Image.asset(imageName), child],
      ),
    );
  }
}
