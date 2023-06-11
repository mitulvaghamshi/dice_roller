import 'package:flutter/material.dart';

/// A widget that makes it easy to create a screen with a square-ish
/// main area, a smaller menu area, and a small area for a message on top.
/// It works in both orientations on mobile- and tablet-sized screens.
@immutable
class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({
    super.key,
    required this.mainSlot,
    required this.bottomSlot,
    this.topSlot = const SizedBox.shrink(),
    this.mainAreaProminence = 0.8,
  });

  /// This is the "hero" of the screen. It's more or less square, and will
  /// be placed in the visual "center" of the screen.
  final Widget mainSlot;

  /// The second-largest area after [mainSlot]. It can be narrow or wide.
  final Widget bottomSlot;

  /// An area reserved for some static text close to the top of the screen.
  final Widget topSlot;

  /// How much bigger should the [mainSlot] be compared to the other elements.
  final double mainAreaProminence;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // This widget wants to fill the whole screen.
      var size = constraints.biggest;
      var padding = EdgeInsets.all(size.shortestSide / 30);

      if (size.height >= size.width) {
        // Portrait / Mobile mode.
        return _PortraitLayout(
          padding: padding,
          topSlot: topSlot,
          mainAreaProminence: mainAreaProminence,
          mainSlot: mainSlot,
          bottomSlot: bottomSlot,
        );
      } else {
        // Landscape / Tablet mode.
        return _LandscapeLayout(
          isLarge: size.width > 900,
          padding: padding,
          mainSlot: mainSlot,
          topSlot: topSlot,
          bottomSlot: bottomSlot,
        );
      }
    });
  }
}

@immutable
class _PortraitLayout extends StatelessWidget {
  const _PortraitLayout({
    required this.padding,
    required this.topSlot,
    required this.mainAreaProminence,
    required this.mainSlot,
    required this.bottomSlot,
  });

  final EdgeInsets padding;
  final Widget topSlot;
  final double mainAreaProminence;
  final Widget mainSlot;
  final Widget bottomSlot;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SafeArea(
        bottom: false,
        child: Padding(padding: padding, child: topSlot),
      ),
      Expanded(
        flex: (mainAreaProminence * 100).round(),
        child: SafeArea(
          top: false,
          bottom: false,
          minimum: padding,
          child: mainSlot,
        ),
      ),
      SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Padding(padding: padding, child: bottomSlot),
      ),
    ]);
  }
}

@immutable
class _LandscapeLayout extends StatelessWidget {
  const _LandscapeLayout({
    required this.isLarge,
    required this.padding,
    required this.mainSlot,
    required this.topSlot,
    required this.bottomSlot,
  });

  final bool isLarge;
  final EdgeInsets padding;
  final Widget mainSlot;
  final Widget topSlot;
  final Widget bottomSlot;

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
        flex: isLarge ? 7 : 5,
        child: SafeArea(
          right: false,
          maintainBottomViewPadding: true,
          minimum: padding,
          child: mainSlot,
        ),
      ),
      Expanded(
        flex: 3,
        child: Column(children: [
          SafeArea(
            bottom: false,
            left: false,
            maintainBottomViewPadding: true,
            child: Padding(padding: padding, child: topSlot),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              left: false,
              maintainBottomViewPadding: true,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(padding: padding, child: bottomSlot),
              ),
            ),
          )
        ]),
      ),
    ]);
  }
}
